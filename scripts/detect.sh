#!/bin/bash

echo "Running threat detection..."

# Brute force detection
FAIL_COUNT=$(grep "Failed password" ../logs/auth.log | wc -l)

if [ $FAIL_COUNT -gt 3 ]; then
  echo "ALERT: Possible brute force attack" >> ../alerts/alerts.log
fi

# Unauthorized sudo
if grep -q "not allowed" ../logs/linux.log; then
  echo "ALERT: Unauthorized sudo attempt" >> ../alerts/alerts.log
fi

# Resource anomaly (NEW 🔥)
if grep -q "CPU usage high" ../logs/system.log; then
  echo "ALERT: High CPU usage detected" >> ../alerts/alerts.log
fi

# Memory issue (NEW 🔥)
if grep -q "Out of memory" ../logs/system.log; then
  echo "ALERT: Possible system instability (OOM)" >> ../alerts/alerts.log
fi

echo "Detection complete."
