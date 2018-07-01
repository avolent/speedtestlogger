# Speedtest logger for a linux device

### Auto Speedtest logger based off https://makezine.com/projects/send-ticket-isp-when-your-internet-drops/ for any device

1. __Install python.__
```
sudo apt-get update
sudo apt-get install python3-pip
```
>or for older python version
```
sudo  apt-get install python-pip
```
2. __Install speedtest-cli__
```
sudo pip3 install speedtest-cli
```
>or for older python version
```
sudo pip install speedtest-cli
```
3. __Test if speedtest-cli is installed correctly__
```
speedtest-cli
```
>output should be something like
```
server@ubuntu:~$ speedtest-cli
Retrieving speedtest.net configuration...
Testing from ISP Internet (xxx.xxx.xxx.xxx)...
Retrieving speedtest.net server list...
Selecting best server based on ping...
Hosted by ISP Internet (Location) [19.58 km]: 6.562 ms
Testing download speed................................................................................
Download: 41.21 Mbit/s
Testing upload speed......................................................................................................
Upload: 15.52 Mbit/s
```
4. __Create the ifttt applet__
>Use the following link to create an ifttt applet:
https://ifttt.com/applets/379108p-log-speedtest-results-to-spreadsheet
>Locate and make note of your secret key from:
https://ifttt.com/services/maker_webhooks/settings

5. __Download the git and edit the speedtest-ifft.sh__
~~~
git clone https://github.com/avolent/speedtestlogger.git

vi speedtest-ifft.sh
~~~
>replace "SECRET_KEY" `secret_key="SECRET_KEY"` with your own. This is located at the bottom of the file.

```
# Send to IFTTT
secret_key="SECRET_KEY"
value1=`echo $server_ping | cut -d" " -f1`
value2=`echo $download | cut -d" " -f1`
value3=`echo $upload | cut -d" " -f1` 
json="{\"value1\":\"${value1}\",\"value2\":\"${value2}\",\"value3\":\"${value3}\"}"
curl -X POST -H "Content-Type: application/json" -d "${json}" https://maker.ifttt.com/trigger/speedtest/with/key/${secret_key}  
```
6. __Ensure the the speedtest-ifft.sh is executable and test__
>Make Executable and run
```
sudo chmod +x speedtest-ifft.sh
./speedtest-ifft.sh
```
>Output should look something like this and a spreadsheet should be aded to your goolge drive.
```
$ ./speedtest-ifttt.sh 
Congratulations! You've fired the speedtest event
```

7. __Ensure the speedtest-cron.sh file is executable and test__
>Make Executable and run
~~~
sudo chmod +x speedtest-cron.sh
./speedtest-cron.sh
~~~
>Check your spreadsheet for an update.

8. __Edit your crontab__
>Edit your crontab to make script run every hr.
~~~
crontabe -e
~~~
>add this to the bottom.
~~~
0 * * * * ~/speedtestlogger/speedtest-cron.sh
~~~
>Save and check you spreadsheet every hr to see if it updates.
