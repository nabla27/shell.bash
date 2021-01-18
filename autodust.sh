#!/bin/bash
limit=5			#デフォルトの保存日数

today=`date '+%Y-%m-%d'`

function DATE (){
#date=`echo $file | cut -d [ -f 2 | cut -d ] -f 1`
	date=`echo $file | awk -F'[[]' '{print $NF}' | awk -F'[]]' '{print $(NF-1)}'`
}

function PROGRESS (){
	pass=$((( `date -d"$today" +%s` - `date -d"$date" +%s`) / 60 / 60 / 24))	#経過日数
}



function STRING (){
	case $file in
		*.sh*)														#.shを含む    保存日数+20
			limit=$(($limit + 20))
			;;
	esac
}

function SIZE (){
	size=`du -sb ~/data_folder/dustbin/$file | awk '{print $1}'`
	if [ "$size" -le 200 ]; then									#200kbyte以下  保存日数=5
		limit=5
	elif [ "$size" -le 2000 ]; then									#2000byte以下　保存日数+10
		limit=$(($limit + 10))
	else															#2000byte以上　保存日数+20
		limit=$(($limit + 20))
	fi
}
		
for file in `ls ~/data_folder/dustbin`
do
	limit=5
	DATE
	PROGRESS
	SIZE
	STRING
    if [ "$limit" -ge 25 -a "$pass" -ge "$limit" ]; then			#保存日数が25日以上のファイルのみ確認する
		echo " $file	を削除してもよろしいですか。(y/n)"
		read ans
		if [ "$ans" = y -o "$ans" = Y ]; then
			rm ~/data_folder/dustbin/$file
			echo "ゴミ箱内の　$file　を削除しました。"              ##########
		fi
	elif [ "$pass" -ge "$limit" ]; then								#経過日数が保存期間を超えたら削除
		rm ~/data_folder/dustbin/$file
		echo "ゴミ箱内の　$file　を削除しました。"                  ##########
	fi
done
