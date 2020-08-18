c() {	
	if [ "$1" = ".." ] || [ "${1:0:1}" = "/" ]
	then
		cd $1
		return 0
	fi
	setopt sh_word_split

	if [ "${1:0:1}" = "." ]
	then
		match=`(ls -a -d .*/ | grep "\\.${1:1}")`
	else
		a=`(ls -a -d */ | grep "$1")`
		match=`(ls -a -d .*/ | grep "$1")`
		match="$a\n$match"
	fi
	old_IFS=$IFS
	IFS=$'\n' 
	
	count=""
	for f in ${match[@]}; do	
		if [ "$count" = "1" ] 
		then
			select folder in ${match[@]}
			do
				IFS=$old_IFS
				unsetopt sh_word_split
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
	unsetopt sh_word_split
	return 0
}
