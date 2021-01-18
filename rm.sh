#!/bin/bash

param1="$1"
param2="$2"
pwd=`pwd`
date=`date '+%Y-%m-%d'`
num_num=`echo $param1 | grep -c [0-9]`
num11=999
num12=999
num21=999
num22=999

if [ "$param2" = "d" ]; then
	cp -r $param1 ~/data_folder/dustbin/"$param1_$date"
	rm -ri $param1
elif [ "$param2" = "dd" ]; then
	rm -r $param1
else

	if [ -d "$param1" ];then
		echo "指定したディレクトリの中には以下のファイルが存在します。"
		ls -a $pwd/$param1
		echo
		echo "削除するディレクトリ名を入力してください。"
		read read_dir
		if [ "$read_dir" = "$param1" ]; then
			if [ "$num_num" -gt 0 ]; then
				num11=`echo $read_dir | sed -e 's/[^0-9]//g'`
				num12=`echo $param1   | sed -e 's/[^0-9]//g'`
			fi
			if [ \( \( "$num11" -eq "$num12" \) -a \( "$num_num" -gt 0 \) \) -o \( "$num_num" -eq 0 \) ]; then
				zip -rq "$param1".zip\["$date"\]d $param1
				mv "$param1".zip\["$date"\]d ~/data_folder/dustbin
				rm -r "$param1"
				echo "ディレクトリ[$param1]を削除しました。復元するにはfキーを押してください。"
				read read_dir2
				if [ "$read_dir2" = "f" ]; then
					mv ~/data_folder/dustbin/"$param1".zip\["$date"\]d "$pwd"
					unzip -q "$param1".zip\["$date"\]d
					rm "$param1".zip\["$date"\]d
					echo "ディレクトリを復元しました。"
				elif [ "$read_dir2" != "f" ]; then
					echo "削除が完了しました。"
				fi
			else
				echo "ディレクトリ名と一致しません。"
			fi
		else 
			echo "ディレクトリ名と一致しません。"
		fi
	elif [ -f $param1 ]; then
		cat $param1 | head
		echo "*    *    *    *    *    *    *    *    *    *    *    *    *    *"
		cat $param1 | tail
		echo "削除するファイル名を入力してください。"
		read read_file
		if [ "$read_file" = "$param1" ]; then
			if [ $num_num -gt 0 ]; then
				num21=`echo $read_file | sed -e 's/[^0-9]//g'`
				num22=`echo $param1    | sed -e 's/[^0-9]//g'`
			fi
			if [ \( \( "$num21" -eq "$num22" \) -a \( "$num_num" -gt "0" \) \) -o \( "$num_num" -eq "0" \) ]; then
				zip -q "$param1".zip\["$date"\]f $param1
				mv "$param1".zip\["$date"\]f ~/data_folder/dustbin
				rm "$param1"
				echo "ファイル[$param1]を削除しました。復元するにはfキーを押してください。"
				read read_file2
				if [ "$read_file2" = "f" ]; then
					mv ~/data_folder/dustbin/"$param1".zip\["$date"\]f "$pwd"
					unzip -q "$param1".zip\["$date"\]f
					rm "$param1".zip\["$date"\]f
					echo "ファイルを復元しました。"
				elif [ "$read_file2" != "f" ]; then
					echo "削除が完了しました。"
				fi
			else
				echo "ファイル名と一致しません。"
			fi
		else
			echo "ファイル名と一致しません。"
		fi
	else
		echo "一致するファイルまたはディレクトリが存在しません。"
	fi
fi

#Command List And Alias Setting.
#alias rm='rm.sh'

#delete a file or directory with copy and confirmation.
#>>> $ rm "name"
#delete a file or directory with copy to dushbin.
#>>> $ rm "name" d
#delete a file of directory without copy.
#>>> $ rm "name" dd
