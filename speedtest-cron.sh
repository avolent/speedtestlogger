#!/bin/bash
 
date >> ~/speedtestlogger/speedtest.log
~/speedtestlogger/speedtest-ifttt.sh >> ~/speedtestlogger/speedtest.log
echo "" >> ~/speedtestlogger/speedtest.log
