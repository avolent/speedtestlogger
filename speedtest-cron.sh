#!/bin/bash
 
date >> ~/Scripts/Speedtest/speedtest.log
~/Scripts/Speedtest/speedtest-ifttt.sh >> ~/Scripts/Speedtest/speedtest.log
echo "" >> ~/Scripts/Speedtest/speedtest.log
