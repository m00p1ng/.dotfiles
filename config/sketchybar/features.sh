#!/bin/bash

WIDGETS=(
  SLACK
  CURRENCY
  CPU
  MEETING
)

for widget in "${WIDGETS[@]}"; do
  var="SKETCHYBAR_WIDGET_${widget}"
  if [[ "${!var}" == "true" ]]; then
    declare "ENABLED_${widget}=true"
  else
    declare "ENABLED_${widget}=false"
  fi
done
