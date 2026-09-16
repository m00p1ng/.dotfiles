#!/bin/bash
# Single definition of "the next meeting", shared by meeting.sh and meeting_click.sh
# so the widget and its click action always act on the same event.
#
# Usage: meeting_query "<includeEventProps>" "<propertyOrder>"

meeting_query() {
  icalBuddy \
    --includeEventProps "$1" \
    --propertyOrder "$2" \
    --noCalendarNames \
    --includeOnlyEventsFromNowOn \
    --limitItems 1 \
    --excludeAllDayEvents \
    --includeCals "$SKETCHYBAR_WIDGET_MEETING_CALENDARS" \
    --bullet "" \
    eventsToday
}
