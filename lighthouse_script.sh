# !/bin/sh

echo "first meaningful paint time report \n \n" > results.txt

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
_ID_=1

for url in "$@"
do

	exec 1>logfile_$_ID_.log 2>&1
    echo "$url"
    lighthouse --disable-device-emulation --disable-cpu-throttling --perf --output=json $url

	echo "$url" >> results.txt
	grep -B 2 "1600ms" logfile_$_ID_.log >> results.txt
	echo "\n"  >> results.txt

	echo "\n"

	echo "$url done!" >&3

	_ID_=$((_ID_ + 1))

done

echo "finished! check out the report.txt file for metrics" >&3