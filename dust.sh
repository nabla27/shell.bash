#!/bin/bash
param1="$1"
param2="$2"
limit=5

today=`date '+%Y-%m-%d'`

function DATE (){
	date=`echo $file | awk -F'[[]' '{print $NF}' | awk -F'[]]' '{print $(NF-1)}'`
}

function PROGRESS (){
	pass=$((( `date -d"$today" +%s` - `date -d"$date" +%s`) / 60 / 60 / 24))
}

function STRING (){
	case $file in
			*.sh*)
				limit=$(($limit + 20))
				;;
	esac
}

function SIZE (){
	size=`du -sb ~/data_folder/dustbin/$file | awk '{print $1}'`
	if [ "$size" -le 200 ]; then
		limit=5
	elif [ "$size" -le 2000 ]; then
		limit=$(($limit + 10))
	else 
		limit=$(($limit + 20))
	fi
}

echo "#ゴミ箱 [2] [4] . [6] . [8] ." > ~/data_folder/dust_list

for file in `ls ~/data_folder/dustbin`
do
	limit=5
	DATE
	PROGRESS
	SIZE
	STRING
	echo "ファイル名: $file 	サイズ: $size	経過日数: $pass		予定削除日: $(($limit - $pass))日後" >> ~/data_folder/dust_list
done
if [ "$param1" = "w" -a -n "$param2" ]; then
	cat ~/data_folder/dust_list | sort -r -n -k $param2 | column -t

else
	cat ~/data_folder/dust_list | column -t
fi

