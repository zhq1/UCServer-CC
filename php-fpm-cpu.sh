#!/bin/bash
CPUS=$(grep -c CPU /proc/cpuinfo)
PIDS=$(ps aux | grep "php-fpm[:] pool" | awk '{print $2}')

let i=0
for PID in $PIDS; do
 CPU=$(echo "$i % $CPUS" | bc)
 taskset -pc $CPU $PID
 let i++
done
