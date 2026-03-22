#!/bin/bash

echo "Running threat detection..."

FAIL_COUNT=$(grep "Failed password" ../logs/auth.log | wc -l)

if [ $FAIL_COUNT -gt 3 ]; then
  echo "ALERT: Possible brute force attack" >> ../alerts/alerts.log
fi

SUDO_ALERT=$(grep "not allowed" ../logs/linux.log)

if [ ! -z "$SUDO_ALERT" ]; then
  echo "ALERT: Unauthorized sudo attempt" >> ../alerts/alerts.log
fi

echo "Detection complete."
