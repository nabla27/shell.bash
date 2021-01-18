#!/bin/bash
param1="$1"
param2="$2"
pwd=`pwd`
lastline=`cat ~/data_folder/Book_Mark | tail -1`						#ブックマークの最終行
lastnum=`echo $lastline | awk -F'[:]' '{print $1}'`						#ブックマークの最終番号

function DELETE(){														#ブックマークの削除機能
	if [ "$param2" -eq 0 ]; then
		sed -i $(($lastnum+1))'d' ~/data_folder/Book_Mark
	else
		sed -i $(($param2+1))'d' ~/data_folder/Book_Mark
		for((j=$param2+1;j<=$lastnum;j++))do
			sed -ie s/$j:/$((j-1)):/g ~/data_folder/Book_Mark
		done
	fi
}
case $param1 in
	save)																#引数"save"でブックマークの保存
	echo "コメントを入力してください。"
	read comment
	echo "$(($lastnum+1)): $pwd	#$comment" >> ~/data_folder/Book_Mark
	;;
	[0-9]|[1-9][0-9])													#指定した番号のブックマークへ移動
	if [ "$param1" -le "$lastnum" ]; then 
		line=`awk "NR==$param1+1" ~/data_folder/Book_Mark`
		line_p=`echo $line | awk -F'[:]' '{print $2}'`
		linepwd=`echo $line_p | awk -F'[#]' '{print $1}'`
		cd $linepwd
	else
		echo "登録されていない番号です。"
	fi
	;;
	show)																#引数"show"でブックマーク一覧を表示	
	cat ~/data_folder/Book_Mark | column -t -s \#
	;;
	rm)																	#引数"rm"で指定した番号のブックマークを削除
	if [ "$param2" -le "$lastnum" ]; then
		DELETE
	else
		echo "登録されていない番号です。"
	fi
	;;
	reset)                     											#引数"reset"でブックマークをリセット
	sed -i "3,$(($lastnum+1))"d ~/data_folder/Book_Mark
	;;
esac


