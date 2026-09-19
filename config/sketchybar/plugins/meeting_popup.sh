#!/bin/bash
# Rebuilds the rows of the meeting popup: every event in the lookahead window,
# with its organizer, attendees and notes.

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/plugins/meeting_query.sh"

PARENT=meeting

MAX_EVENTS=8
MAX_ATTENDEES=10
MAX_NOTE_LINES=8
WRAP_WIDTH=64

# Popups do not scroll, so the whole list has to stay shorter than the screen.
MAX_ROWS=40

# Label indents, in points: a plain row, the details under an event title, and
# the members of a collapsible section.
INDENT_ROW=10
INDENT_DETAIL=26
INDENT_MEMBER=34

# Sketchybar drops oversized messages silently, so rows go out in chunks. The
# budget counts arguments, not rows, and a row is worth around 20 of them.
ARGS_PER_BATCH=600

# One "<kind>\t<text>[\t<url>]" line per popup row. Section kinds come in pairs:
# a "<section>head" header followed by its "<section>" members.
popup_rows() {
  meeting_events | jq -r \
    --argjson maxev "$MAX_EVENTS" \
    --argjson maxatt "$MAX_ATTENDEES" \
    --arg today "$(/bin/date +%Y-%m-%d)" \
    --arg tomorrow "$(/bin/date -v+1d +%Y-%m-%d)" '
def ts: sub("\\.[0-9]+Z$"; "Z") | fromdate;
def daykey: strflocaltime("%Y-%m-%d");
def hm: strflocaltime("%H:%M");
def clean: tostring | gsub("[\\t\\r\\n]"; " ");

# "name <email>", or just the email when the name carries nothing extra.
def person: if ((.name // "") == "") or (.name == .email) then (.email // "")
            else "\(.name) <\(.email)>" end;

# "Monday, September 20". BSD strftime has no unpadded day, hence the ltrimstr.
def daylong: "\(strflocaltime("%A, %B")) \(strflocaltime("%d") | ltrimstr("0"))";

# Only multi-day events have to repeat the date for their end.
def timerange:
  (.startDate | ts) as $s | (.endDate | ts) as $e
  | if ($s | daykey) == ($e | daykey)
    then "\($s | daylong) · \($s | hm) - \($e | hm)"
    else "\($s | daylong) \($s | hm) - \($e | daylong) \($e | hm)" end;

# Optional attendees are the least interesting ones, so they go last.
def attendees: (.attendees // []) | sort_by(if (.role // "") == "optional" then 1 else 0 end);

def notelines:
  (.notes // "") | gsub("\\r"; "") | split("\n") | map(gsub("^\\s+|\\s+$"; "")) | map(select(. != ""));

def eventrows:
  attendees as $att
  | ["event", "\(.title // "(no title)")", (.meetingUrl // "")],
    ["time", timerange],
    (.organizer | select((.email // "") != "") | ["meta", "Organizer  \(person)"]),
    ($att | select(length > 0) | ["atthead", "Attendees (\(length))"]),
    # "required" is the norm, so only the exceptions are worth labelling.
    ($att[0:$maxatt][] | (.role // "") as $role |
      ["att", (if $role == "" or $role == "required" then person else "\(person)  \($role)" end)]),
    ($att | select(length > $maxatt) | ["att", "+\(length - $maxatt) more"]),
    (notelines | select(length > 0) | (["notehead", "Notes"], (.[] | ["note", .])));

# Events that started on an earlier day are still listed under today.
[ .[0:$maxev][] | . + { _day: ([(.startDate | ts | daykey), $today] | max) } ]
| group_by(._day)
| .[] as $g
| (["day", (if $g[0]._day == $today then "Today"
            elif $g[0]._day == $tomorrow then "Tomorrow"
            else ($g[0]._day | strptime("%Y-%m-%d") | mktime | strftime("%a %d %b")) end)]),
  ($g[] | eventrows)
| map(clean)
| @tsv
'
}

# Sketchybar labels never wrap, so long ones are split over several rows. Most
# labels are short enough to need no help, and folding those costs a process.
fold_label() {
  if ((${#1} <= WRAP_WIDTH)); then
    printf '%s\n' "$1"
  else
    /usr/bin/fold -s -w "$WRAP_WIDTH" <<<"$1"
  fi
}

# The rows of the last rebuild go away in the same message the new ones arrive in.
args=(--remove "/$PARENT.popup\..*/")

index=0        # rows added so far, and the name of a row that needs no stable one
visible=0      # rows that are actually drawn, so the ones counting towards MAX_ROWS
event_no=0     # the event the current section belongs to
member_no=0    # the member of the current section
note_budget=0  # note rows the current event may still add
truncated=0

flush_args() {
  ((${#args[@]} == 0)) && return
  sketchybar "${args[@]}" >/dev/null
  args=()
}

# add_row <kind> <text> [url] [name]
add_row() {
  local kind="$1" text="$2" url="$3" name="${4:-$PARENT.popup.$index}" hidden=0
  local row=(
    icon.drawing=off
    label.font.size=11.0
    label.color="$WHITE"
    label.padding_left="$INDENT_ROW"
    label.padding_right=10
    label="$text"
  )

  case "$kind" in
  day)
    row+=(
      label.font.style=Bold
      label.color="$GREY"
    )
    ;;
  event)
    row+=(
      icon.drawing=on
      icon="$CALENDAR"
      icon.color="$BLUE"
      icon.font.size=12.0
      label.font.style=Bold
      label.font.size=12.0
    )
    [[ -n "$url" ]] && row+=(click_script="open '$url'; sketchybar --set $PARENT popup.drawing=off")
    ;;
  time)
    row+=(label.padding_left="$INDENT_DETAIL")
    ;;
  meta)
    row+=(
      label.color="$LIGHT_BLUE"
      label.padding_left="$INDENT_DETAIL"
    )
    ;;
  atthead | notehead)
    row+=(
      label.color="$LIGHT_BLUE"
      label.padding_left=8
      icon.drawing=on
      icon="$CHEVRON_RIGHT"
      icon.color="$LIGHT_BLUE"
      icon.font.size=8.0
      # The chevron fills the gutter to the left of the header label.
      icon.padding_left=18
      icon.padding_right=4
      # The members of a section are named after it, minus the "head".
      click_script="$CONFIG_DIR/plugins/meeting_toggle.sh '$PARENT.popup.${kind%head}.$event_no' '$name'"
    )
    ;;
  att | note)
    # Sections start collapsed, so their members take up no room until asked for.
    hidden=1
    row+=(
      label.color="$GREY"
      label.padding_left="$INDENT_MEMBER"
      drawing=off
    )
    ;;
  esac

  ((hidden)) || ((visible++))

  args+=(--add item "$name" "popup.$PARENT" --set "$name" "${row[@]}")
  ((index++))
  if ((${#args[@]} >= ARGS_PER_BATCH)); then
    flush_args
  fi
}

# Adds one label as however many rows it folds into. Runs in the current shell to
# keep appending to "args", and spends "note_budget" as it goes so that a wall of
# notes cannot fill the popup on its own.
#
# add_wrapped <kind> <text> [name_prefix]
add_wrapped() {
  local kind="$1" text="$2" prefix="$3" line line_no=0

  while IFS= read -r line; do
    [[ "$kind" == note ]] && ((note_budget-- <= 0)) && break
    add_row "$kind" "$line" "" "${prefix:+$prefix.$line_no}"
    ((line_no++))
  done < <(fold_label "$text")
}

while IFS=$'\t' read -r kind text url; do
  # Collapsed members are free, so only drawn rows count towards the budget. The
  # last row is kept free for the "more events" hint.
  if ((visible >= MAX_ROWS - 1)); then
    truncated=1
    break
  fi

  case "$kind" in
  event)
    event_no=$((event_no + 1))
    add_row "$kind" "$text" "$url"
    ;;
  atthead | notehead)
    member_no=0
    [[ "$kind" == notehead ]] && note_budget=$MAX_NOTE_LINES
    add_wrapped "$kind" "$text" "$PARENT.popup.$kind.$event_no"
    ;;
  att | note)
    [[ "$kind" == note ]] && ((note_budget <= 0)) && continue
    add_wrapped "$kind" "$text" "$PARENT.popup.$kind.$event_no.$((member_no++))"
    ;;
  *)
    add_wrapped "$kind" "$text"
    ;;
  esac
done < <(popup_rows)

if ((index == 0)); then
  add_row day "No upcoming events"
elif ((truncated)); then
  add_row day "…"
fi

flush_args
