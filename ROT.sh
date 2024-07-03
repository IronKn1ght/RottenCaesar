#!/bin/bash

endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
grayColour="\e[0;37m\033[1m"

echo -e "${redColour}
                     ██▀███   ▒█████  ▄▄▄█████▓▄▄▄█████▓▓█████  ███▄    █ 
                    ▓██ ▒ ██▒▒██▒  ██▒▓  ██▒ ▓▒▓  ██▒ ▓▒▓█   ▀  ██ ▀█   █ 
                    ▓██ ░▄█ ▒▒██░  ██▒▒ ▓██░ ▒░▒ ▓██░ ▒░▒███   ▓██  ▀█ ██▒
                    ▒██▀▀█▄  ▒██   ██░░ ▓██▓ ░ ░ ▓██▓ ░ ▒▓█  ▄ ▓██▒  ▐▌██▒
                    ░██▓ ▒██▒░ ████▓▒░  ▒██▒ ░   ▒██▒ ░ ░▒████▒▒██░   ▓██░
                    ░ ▒▓ ░▒▓░░ ▒░▒░▒░   ▒ ░░     ▒ ░░   ░░ ▒░ ░░ ▒░   ▒ ▒ 
                      ░▒ ░ ▒░  ░ ▒ ▒░     ░        ░     ░ ░  ░░ ░░   ░ ▒░
                      ░░   ░ ░ ░ ░ ▒    ░        ░         ░      ░   ░ ░ 
                       ░         ░ ░                       ░  ░         ░ 
                                                      
                     ▄████▄   ▄▄▄      ▓█████   ██████  ▄▄▄       ██▀███  
                    ▒██▀ ▀█  ▒████▄    ▓█   ▀ ▒██    ▒ ▒████▄    ▓██ ▒ ██▒
                    ▒▓█    ▄ ▒██  ▀█▄  ▒███   ░ ▓██▄   ▒██  ▀█▄  ▓██ ░▄█ ▒
                    ▒▓▓▄ ▄██▒░██▄▄▄▄██ ▒▓█  ▄   ▒   ██▒░██▄▄▄▄██ ▒██▀▀█▄  
                    ▒ ▓███▀ ░ ▓█   ▓██▒░▒████▒▒██████▒▒ ▓█   ▓██▒░██▓ ▒██▒
                    ░ ░▒ ▒  ░ ▒▒   ▓▒█░░░ ▒░ ░▒ ▒▓▒ ▒ ░ ▒▒   ▓▒█░░ ▒▓ ░▒▓░
                      ░  ▒     ▒   ▒▒ ░ ░ ░  ░░ ░▒  ░ ░  ▒   ▒▒ ░  ░▒ ░ ▒░
                    ░          ░   ▒      ░   ░  ░  ░    ░   ▒     ░░   ░ 
                    ░ ░            ░  ░   ░  ░      ░        ░  ░   ░      ${endColour}\n"

echo -e "                                   ${redColour}#${endColour}${grayColour}Script by IronKn1ght${endColour}${redColour}#${endColour}\n\n"


upper="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
lower="abcdefghijklmnopqrstuvwxyz"

# Función para manejar Ctrl+C
function ctrl_c() {
  echo -e "${redColour}\n\n|!| El script se ha finalizado |!|${endColour}"
  exit 1
}
trap ctrl_c INT

echo -ne "${yellowColour}|+|${endColour}${grayColour}Escribe el texto cifrado que quieres descifrar${endColour}${yellowColour} ->${endColour} "
read cipher

# Función para descifrar el texto
function decrypt() {
  local text="$1"
  local shift="$2"
  local decrypted=""

  for (( i=0; i<${#text}; i++ )); do
    char="${text:$i:1}"
    if [[ $char =~ [A-Z] ]]; then
      index=$(( $(printf %d "'$char") - 65 ))
      decrypted+=${upper:$(( (index - shift + 26) % 26 )):1}
    elif [[ $char =~ [a-z] ]]; then
      index=$(( $(printf %d "'$char") - 97 ))
      decrypted+=${lower:$(( (index - shift + 26) % 26 )):1}
    else
      decrypted+="$char"
    fi
  done

  echo "$decrypted"
}

echo -e "\n${yellowColour}|+|${endColour}${grayColour}Posibles descifrados del texto${endColour}${blueColour} \"$cipher\"${endColour}${grayColour}:${endColour}\n"

# Iterar sobre todas las posibles rotaciones
for (( rot=0; rot<26; rot++ )); do
  decrypted=$(decrypt "$cipher" $rot)
echo -e "${redColour}Rotación${endColour} ${grayColour}$rot${endColour}${grayColour}:${endColour}${blueColour} $decrypted${endColour}"
done
