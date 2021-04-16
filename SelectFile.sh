#!/bin/bash
#### Discription #####################################################################
#This is a file to select by entering only one key.
#
#I show Usage of this file below.
# >>>$ bash SelectFile.sh "param1" "param2"
#
#You can specify some parameters.
#I show each parameters function.
# 1 : return full path of selected file.
# 2 : return name of selected file.
# 3 : return file type of selected file. h/hyperlink f/normal file d/directory
#If you do not specify any parameters, cannot get anything.
#I show examples of executing method below.
# >>>$ bash SelectFile.sh 1
# >>>$ bash SelectFile.sh 2 3
#
#The following initial values can be changed arbitrarily.
C_path="\e[33;4m"	#The color of current path displayed above.
C_link="\e[35m"		#The color of hyper link file.
C_dir="\e[36m"		#The color of directory file.
C_norf="\e[37m"		#The color of normal file.
blockNum=10		#The number of showing file on display.
######################################################################################
#Initial parameter. Do not change below.
mode="SelectFile"
tf_allfile="False"; tf_selected="False"
Cend="\e[m"
num=1; s_num=1; block=0;
text[1]=""; text[2]=""
######################################################################################
while [ $mode = "SelectFile" ]
do
	c_path=`pwd`
	clear

	echo -e "${C_path}`pwd`${Cend}"
	echo
	echo "${text[1]}"
	echo "${text[2]}"
	echo "${text[3]}"
#	echo "debug: num=$num numMax=$numMax"
	echo "__________________________________________________"
	IFS_BACKUP=$IFS
	IFS=$'\n'
	if [ $tf_allfile = "False" ]; then
		tmp=1
		for file_name in `ls`
		do
			if [ $tmp -ge $((block*blockNum)) -a $tmp -le $(((block+1)*blockNum)) ]; then
			if [ $num -eq $tmp ]; then prin="→"; selected_file="${file_name}"
			else prin="  "; fi

			if [ -h "${c_path}/${file_name}" ]; then
				echo -e " ${prin} ${C_link}${file_name}${Cend}"
			elif [ -d "${c_path}/${file_name}" ]; then
				echo -e " ${prin} ${C_dir}${file_name}${Cend}"
			elif [ -f "${c_path}/${file_name}" ]; then
				echo -e " ${prin} ${C_norf}${file_name}${Cend}"
			else
				echo " ${prin} ${file_name}"
			fi
			fi
			tmp=$((tmp+1))
		done
	elif [ $tf_allfile = "True" ]; then
		tmp=1
		for file_name in `ls -A`
		do
			if [ $num -eq $tmp ]; then prin="→"; selected_file="${file_name}"
			else prin="  "; fi

			if [ -h "${c_path}/${file_name}" ]; then 
				echo -e " ${prin} ${C_link}${file_name}${Cend}"
			elif [ -d "${c_path}/${file_name}" ]; then
				echo -e " ${prin} ${C_dir}${file_name}${Cend}"
			elif [ -f "${c_path}/${file_name}" ]; then 
				echo -e " ${prin} ${C_norf}${file_name}${Cend}"
			else
				echo " ${prin} ${file_name}"
			fi
			tmp=$((tmp+1))
		done
	fi
	IFS=$IFS_BACKUP
	read -s -n 1 _key
	text[3]=""
	if [ $tf_selected = "False" ]; then
		text[1]=""; text[2]=""
		case $_key in
			w)
			num=$((num-1))
			;;
			s)
			num=$((num+1))
			;;
			d)
			tf_selected="True"
			text[1]=" → Open"
			text[2]="    Select"
			;;
			a|q)
			cd ..
			;;
			"[")
			num=$((num-blockNum))
			;;
			"]")
			num=$((num+blockNum))
			;;
			p)
			if [ $tf_allfile = "False" ]; then tf_allfile="True"
			else tf_allfile="False"; fi
			;;
		esac
	elif [ $tf_selected = "True" ]; then
		case $_key in 
			w)
			s_num=$((s_num-1))
			;;
			s)
			s_num=$((s_num+1))
			;;
			a|q)
			tf_selected="False"
			text[1]=""; text[2]=""
			;;
			d)
			if [ $s_num -eq 1 ]; then
				if [ -d "`pwd`/${selected_file}" ]; then 
					cd "`pwd`/${selected_file}"
					tf_selected="False"
				else 
					text[3]="This is not a directory."
				fi
			elif [ $s_num -eq 2 ]; then
				break
			fi
		esac
		for tmp in {1..2}
		do
			if [ $tmp -eq $s_num ]; then s_prin[$tmp]="→"
			else s_prin[$tmp]="  ";fi
		done
		if [ $tf_selected = "True" ]; then
			text[1]=" ${s_prin[1]} Open"
			text[2]=" ${s_prin[2]} Select"
		else
			text[1]=""; text[2]=""
		fi
	fi

	if [ $tf_allfile = "False" ]; then numMax=`ls -1 | wc -l`
	else numMax=`ls -A -1 | wc -l`; fi
	if [ $num -gt $numMax -o $num -le 0 ]; then num=1; fi
	if [ $s_num -le 0 -o $s_num -gt 2 ]; then s_num=1; fi
	block=$((num/blockNum))









done
tmp=1
while [ $tmp -le $# ]
do
	if [ $# -eq 0 ]; then echo $#; break; fi
	case ${tmp} in
	1)
	echo "`pwd`/${selected_file}"
	;;
	2)
	echo "${selected_file}"
	;;
	3)
	if [ -h "`pwd`/${selected_file}" ]; then echo h
	elif [ -d "`pwd`/${selected_file}" ]; then echo d
	elif [ -f "`pwd`/${selected_file}" ]; then echo f; fi
	;;
	esac
	tmp=$((tmp+1))
done













	
