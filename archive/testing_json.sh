# !/bin/sh

printf '{ \n \t "first meaningful paint time report":[ \n \t ' > results.txt

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
_ID_=1

for url in "$@"
do

	exec 1>logfile_$_ID_.log 2>&1
    printf "$url"

    lighthouse --disable-device-emulation --disable-cpu-throttling --perf --output=json $url

	printf "%s"  '{ "url":"' >> results.txt
	printf "%s" $url >> results.txt
	printf "%s" '",' >> results.txt
	printf "\n" >> results.txt

	STR=grep -B 2 "1600ms" logfile_$_ID_.log
	echo "$STR" >&3
	$STR=${STR%?}
	$STR >> results.txt
	printf "\b }," >> results.txt
	printf "\n"  >> results.txt

	echo "$url done!" >&3

	_ID_=$((_ID_ + 1))

done

printf "\n ] \n }" >> results.txt
printf "\033[1;32mfinished! check out the results.txt file for metrics\033[0m\n" >&3


