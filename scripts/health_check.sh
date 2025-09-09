#!/bin/bash

# CPU 使用率
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
# 内存使用率
mem=$(free | awk '/Mem/ {printf("%.2f"), $3/$2 * 100}')
# 磁盘使用率
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
      echo "   $name 已超过安全阈值，可能会导致系统变慢。"
    fi
  else
    echo "✅ $name usage is ok: $value%"
    if [ "$explain" = true ]; then
      echo "   $name 在正常范围内。"
    fi
  fi
}

check_status "$cpu" 85 "CPU"
check_status "$mem" 90 "Memory"
check_status "$disk" 80 "Disk"
