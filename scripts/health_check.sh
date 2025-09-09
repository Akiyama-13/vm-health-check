#!/bin/bash

# CPU usage
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
# Memory usage
mem=$(free | awk '/Mem/ {printf("%.2f"), $3/$2 * 100}')
# Disk usage
disk=$(df / | awk 'END {print $5}' | sed 's/%//')

explain=false
if [[ "$1" == "--explain" ]]; then
  explain=true
fi

check_status () {
  value=$1
  threshold=$2
  name=$3
  if (( $(echo "$value > $threshold" | bc -l) )); then
    echo "❌ $name usage is high: $value%"
    if [ "$explain" = true ]; then
      echo "   $name has exceeded the safe threshold and may slow down the system."
    fi
  else
    echo "✅ $name usage is ok: $value%"
    if [ "$explain" = true ]; then
      echo "   $name is within the normal range."
    fi
  fi
}

check_status "$cpu" 85 "CPU"
check_status "$mem" 90 "Memory"
check_status "$disk" 80 "Disk"
