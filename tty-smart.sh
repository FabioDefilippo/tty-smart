#!/bin/bash
#Author: Fabio Defilippo
#email: 4starfds@gmail.com

if [[ ! -f $(which gpm) ]];
then
	if [[ -f $(which apt) ]];
	then
		sudo apt install gpm -y
	elif [[ -f $(which pacman) ]];
	then
		sudo pacman -S gpm
	else
		echo "I can not find a packet manager"
	fi
fi
sudo service gpm start || sudo service gpm restart
clear
while [ true ];
do
COPIADA=""
COPIAIN=""
MUOVIDA=""
MUOVIIN=""
SCELTA=""
COMANDO=""
PERMESSO=""
CARTELLA=""
SFILE=""
PERM=""
PERMESSO=""
EDITBIN=""
HASH=""
echo ""
pwd
echo ""
ls -F
echo ""

select SCELTA in $(if [ -f $(which cp) ];then echo "copy";fi) $(if [ -f $(which mv) ];then echo "move";fi) $(if [ -f $(which clear) ];then echo "clear";fi) "cd" "up" $(if [ -f $(which ls) ];then echo "details";fi) $(if [ -f $(which stat) ];then echo "properties";fi) "edit" $(if [ -f $(which chmod) ];then echo "permissions" ;fi) "create_folder" $(if [ -f $(which md5sum) ]; then echo "hash";elif [ -f $(which sha1sum) ]; then echo "hash";elif [ -f $(which sha256sum) ]; then echo "hash";elif [ -f $(which sha512sum) ];then echo "hash";fi) $(if [ -f $(which open) ];then echo "open";fi) "command" "exit"
do
	case "$SCELTA" in
	"exit")
		sudo service gpm stop
		exit 0
	;;
	"open")
		read -e -p "filename: " SFILE
		open "$SFILE"
	;;
	"create_folder")
		read -e -p "new-folder name: " SFILE
		mkdir "$SFILE"
	;;
	"properties")
		read -e -p "filename: " SFILE
		stat "$SFILE"
	;;
	"hash")
		select HASH in $(if [ -f $(which md5sum) ];then echo "md5";fi) $(if [ -f $(which sha1sum) ];then echo "sha1";fi) $(if [ -f $(which sha256sum) ];then echo "sha256";fi) $(if [ -f $(which sha512sum) ];then echo "sha512";fi)
		do
		case "$HASH" in
			"md5")
				read -e -p "filename: " SFILE
				md5sum "$SFILE"
			;;
			"sha1")
				read -e -p "filename: " SFILE
				sha1sum "$SFILE"
			;;
			"sha256")
				read -e -p "filename: " SFILE
				sha256sum "$SFILE"
			;;
			"sha512")
				read -e -p "filename: " SFILE
				sha512sum "$SFILE"
			;;
		esac
		break
		done
	;;
	"permissions")
		select PERM in $(if [ -f $(which chmod) ];then echo "chmod+"; echo "chmod-" ;fi)
		do
		case "$PERM" in
			"chmod+")
			select PERMESSO in "execute" "write" "read"
			do
				case "$PERMESSO" in
				"write")
					read -e -p "filename: " SFILE
					chmod +w "$SFILE"
				;;
				"read")
					read -e -p "filename: " SFILE
					chmod +r "$SFILE"
				;;
				"execute")
					read -e -p "filename: " SFILE
					chmod +x "$SFILE"
				;;
				esac
				break
			done
			;;
			"chmod-")
			select PERMESSO in "execute" "write" "read"
			do
				case "$PERMESSO" in
				"write")
					read -e -p "filename: " SFILE
					chmod -w "$SFILE"
				;;
				"read")
					read -e -p "filename: " SFILE
					chmod -r "$SFILE"
				;;
				"execute")
					read -e -p "filename: " SFILE
					chmod -x "$SFILE"
				;;
				esac
				break
			done
		;;
		esac
		break
	done
	;;
	"edit")
		select EDITBIN in $(if [ -f $(which nano) ];then echo "nano";fi) $(if [ -f $(which pico) ];then echo "pico";fi) $(if [ -f $(which vi) ];then echo "vi";fi) $(if [ -f $(which vim) ];then echo "vim";fi)
		do
		case "$EDITBIN" in
			"vim")
				read -e -p "filename: " SFILE
				vim "$SFILE"
			;;
			"nano")
				read -e -p "filename: " SFILE
				nano -l "$SFILE"
			;;
			"vi")
				read -e -p "filename: " SFILE
				vi "$SFILE"
			;;
			"pico")
				read -e -p "filename: " SFILE
				pico "$SFILE"
			;;
			esac
			break
		done
	;;
	"details")
		ls -la
	;;
	"cd")
		read -e -p "to: " CARTELLA
		cd "$CARTELLA"
	;;
	"up")
		cd ..
	;;
	"clear")
		clear
	;;
	"move")
		pwd
		read -e -p "from: " MUOVIADA
		read -e -p "to: " MUOVIIN
		mv "$MUOVIADA" "$MUOVIIN"
	;;
	"copy")
		pwd
		read -e -p "from: " COPIADA
		read -e -p "to: " COPIAIN
		cp "$COPIADA" "$COPIAIN"
	;;
	"command")
		read -e -p "command: " COMANDO
		echo "$COMANDO"|bash
	;;
	esac
	break
done
done
