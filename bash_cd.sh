c() {	
	if [ "$1" = ".." ] || [ "${1:0:1}" = "/" ]
	then
		cd $1
		return 0
	fi
	match=`(ls -a -d */ | grep "$1")`
	old_IFS=$IFS
	IFS=$'\n'
	count=""
	for f in ${match[@]}; do	
		if [ "$count" = "1" ] 
		then
			select folder in ${match[@]}
			do
				IFS=$old_IFS
				cd "$folder"
				return 0
			done 
		fi	
		count="1"
	done
	if [ "$match" = "" ]
	then
		cd $1
	else
		cd "$match"
	fi
	IFS=old_IFS
	return 0
}
