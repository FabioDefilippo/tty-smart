if [[ ! -f $(which gpm) ]];
then
 sudo apt install gpm -y
fi
sudo service gpm start || sudo service gpm restat
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
pwd
echo ""
ls -F
echo ""

select SCELTA in $(if [ -f $(which cp) ];then echo "copy";fi) $(if [ -f $(which mv) ];then echo "move";fi) $(if [ -f $(which clear) ];then echo "clear";fi) "cd" "up" $(if [ -f $(which ls) ];then echo "details";fi) $(if [ -f $(which nano) ];then echo "nano";fi) $(if [ -f $(which vim) ];then echo "vim";fi) $(if [ -f $(which chmod) ];then echo "chmod+"; echo "chmod-" ;fi) "create_folder" "command" "exit"
do
 case "$SCELTA" in
  "exit")
   sudo service gpm stop
   exit 0
  ;;
  "create_folder")
   read -e -p "new-file name: " SFILE
   mkdir "$SFILE"
  ;;
  "vim")
   read -e -p "to: " SFILE
   vim "$SFILE"
  ;;
  "nano")
   read -e -p "to: " SFILE
   nano -l "$SFILE"
  ;;
  "details")
   ls -la
  ;;
  "chmod+")
   select PERMESSO in "execute" "write" "read"
   do
    case "$PERMESSO" in
     "write")
      read -e -p "to: " SFILE
      chmod +w "$SFILE"
     ;;
     "read")
      read -e -p "to: " SFILE
      chmod +r "$SFILE"
     ;;
     "execute")
      read -e -p "to: " SFILE
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
      read -e -p "to: " SFILE
      chmod -w "$SFILE"
     ;;
    "read")
     read -e -p "to: " SFILE
     chmod -r "$SFILE"
    ;;
    "execute")
     read -e -p "to: " SFILE
     chmod -x "$SFILE"
   ;;
   esac
   break
  done
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
