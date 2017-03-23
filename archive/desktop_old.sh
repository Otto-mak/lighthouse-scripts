# !/bin/sh

echo "first meaningful paint time report \n \n" > results.txt

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>logfile 2>&1

for url in "$@"
do

    echo "$url"
    lighthouse --disable-device-emulation --disable-cpu-throttling --perf --output=json $url

	echo "$url" >> results.txt
	grep -B 2 "1600ms" logfile >> results.txt
	echo "\n"  >> results.txt

	echo "\n"

	echo "$url done!" >&3

done

echo "finished! check out the report.txt file for metrics" >&3