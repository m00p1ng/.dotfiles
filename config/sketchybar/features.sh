if [[ "$SKETCHYBAR_WIDGET_SLACK" == "true" ]]; then
  ENABLED_SLACK=true
else
  ENABLED_SLACK=false
fi

if [[ "$SKETCHYBAR_WIDGET_CURRENCY" == "true" ]]; then
  ENABLED_CURRENCY=true
else
  ENABLED_CURRENCY=false
fi

if [[ "$SKETCHYBAR_WIDGET_CPU" == "true" ]]; then
  ENABLED_CPU=true
else
  ENABLED_CPU=false
fi
