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

	echo "$url done!" >&3

	_ID_=$((_ID_ + 1))

done

printf "\033[1;32mfinished! check out the results.txt file for metrics\033[0m\n" >&3
rm *.log