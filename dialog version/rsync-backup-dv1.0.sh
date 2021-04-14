#!/usr/bin/env bash
#
# --------------------------------------------------------------------------------------------------------------------------- #
# ------------------------------------------------ VARIÁVEIS------------------------------------------------- #
LOG="$(date +%m%Y)"

ARQUIVO_LOG="bkp-$LOG.log"

MENSAGEM_LOG="#$(date "+%A, %d %B %Y")#" 
# --------------------------------------------------------------------------------------------------------------------------- #
# ------------------------------------------------- TESTES -------------------------------------------------- # 
[ ! -x "$(which dialog)" ] && sudo apt install dialog -y 1> /dev/null 2>&1 # dialog instalado?
[ ! -x "$(which rsync)" ] && sudo apt install rsync -y # rsync instalado?
# --------------------------------------------------------------------------------------------------------------------------- #
# ------------------------------------------------- FUNÇÕES ------------------------------------------------- #
Backup_local () {
  dialog --infobox 'Iniciando Backup...' 3 25; sleep 1
  echo "$MENSAGEM_LOG" >> "$ARQUIVO_LOG"
  rsync -avh --progress "$dir_origem" "$dir_destino" --log-file="$ARQUIVO_LOG" \
  | perl -lane 'BEGIN { $/ = "\r"; $|++ } $F[1] =~ /(\d+)%$/ && print $1' \
  | dialog --gauge 'Aguarde... Copiando Arquivos' 8 70 0
  dialog --msgbox 'Backup concluído com sucesso!' 6 35
  dialog --title 'Log de Backup' --textbox "$ARQUIVO_LOG" 0 0
  clear
  exit
}
Backup_remoto () {
  dialog --infobox 'Iniciando Backup...' 3 25; sleep 1
  echo "$MENSAGEM_LOG" >> "$ARQUIVO_LOG"
  sudo rsync -avhP --progress -e ssh "$dir_origem" "$dir_destino" --log-file="$ARQUIVO_LOG" \
  | perl -lane 'BEGIN { $/ = "\r"; $|++ } $F[1] =~ /(\d+)%$/ && print $1' \
  | dialog --gauge 'Aguarde... Copiando Arquivos' 8 70 0
  dialog --msgbox 'Backup concluído com sucesso!' 6 35
  dialog --title 'Log de Backup' --textbox "$ARQUIVO_LOG" 0 0
  clear
  exit
}
# ---------------------------------------------------------------------------------------------------------------------------- #
# ------------------------------------------------- EXECUÇÃO ------------------------------------------------ #
dialog --title 'Backup com rsync' \
--yesno 'Deseja fazer um Backup?' 6 28

[ $? -eq 0 ] && {
  menu=$(dialog --title 'Backup com rsync' \
  --menu 'Selecione o tipo de Backup' 10 32 2 \
  1 'Backup local' \
  2 'Backup remoto' --stdout
  )
  case "$menu" in
    1) 
      dir_origem=$(dialog --title 'Selecione o arquivo ou diretório' \
      --fselect "$HOME"/ 14 80 --stdout)
      [ $? -eq 0 ] && {
        dir_destino=$(dialog --title 'Selecione o diretório em que será salvo' \
        --dselect "$HOME"/ 14 50 --stdout)
        [ $? -eq 0 ] && {
          Backup_local
        }
        clear && exit 0
      }  
      clear && exit 0
    ;;
    2)
      dir_origem=$(dialog --title 'Selecione o arquivo ou diretório' \
      --fselect "$HOME"/ 14 80 --stdout)
      [ $? -eq 0 ] && {
        dir_destino=$(dialog --title 'Selecione o diretório em que será salvo' \
        --dselect "$HOME"/ 14 50 --stdout)
        [ $? -eq 0 ] && {
          Backup_remoto
        }
        clear && exit 0
      }  
      clear && exit 0
    ;;
  esac
}
clear && exit
# ------------------------------------------------------------------------------------------------------------------------------ #
