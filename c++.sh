#!/bin/bash
pwd=`pwd`
param1="$1"
param2="$2"
param3="$3"
date=`date`
n=0


function excute {													#function that excutes source file.
	cd $PASS
	g++ -o pass $param1
	./pass
}


if [ $param1 = "w" ]; then
	vim ~/data_folder/c_date

else
	if [ -r "/mnt/c/Users/nabla/C_lesson/$param1" ]; then			#search on C_lesson that is windows directory.
		PASS="/mnt/c/Users/nabla/C_lesson"
		excute
	elif [ -r "~/program/C++_dir/$param1" ]; then					#search on C++ directory.
		PASS="~/program/C++_dir"
		excute
	elif [ -r "$pwd/$param1" ]; then								#search on current directory.
		PASS="$pwd"
		excute
	elif [ -r ~/$param1 ]; then										#search on home directory.
		PASS=~/
		excute
	else
		echo
		echo "以下のどこにもソースファイルが存在しないか、読み取りパーミッションが与えられていません。"			#error message.
		echo "~/ 	~/program/C++_dir 	/mnt/c/Users/nabla/C_lesson 	$pwd"
		echo "上記のどこかにソースファイルを移動させ、パーミッションを与えてください。"
		echo
	fi
fi

if [ "$param2" = s ]; then
	if [ ! -f ~/data_folder/c_date ]; then
		touch ~/data_folder/c_date									#create file for saving code.
	fi

	echo "#========================================================================================" >> ~/data_folder/c_date
	echo "# $param3 [$date]"                                                                         >> ~/data_folder/c_date
	echo "#========================================================================================" >> ~/data_folder/c_date
	cat "$1" >> ~/data_folder/c_date
	echo >> ~/data_folder/c_date
	echo >> ~/data_folder/c_date
fi

cd $pwd																#return to current directory.

