# !/bin/sh
# redirect stdout/stderr to a file
exec &> logfile.txt

url_1="$1"

lighthouse --disable-device-emulation --disable-cpu-throttling --perf --output=json $url_1
echo "$url_1" >> results.txt
grep -B 2 "1600ms" logfile.txt >> results.txt