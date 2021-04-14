#!/usr/bin/env bash
#
# --------------------------------------------------------------------------------------------------------------------------- #
# ------------------------------------------------ VARIÁVEIS------------------------------------------------- #
VERDE="\033[32;1m"
AMARELO="\033[33;1m"
VERMELHO="\033[31;1m"

LOG="$(date +%m%Y)"

ARQUIVO_LOG="bkp-$LOG.log"

MENU="
  $0 [-OPÇÃO]
    
    -l  Backup local
    -r  Backup remoto
"
MENSAGEM_LOG="#$(date "+%A, %d %B %Y")#" 
# --------------------------------------------------------------------------------------------------------------------------- #
# ------------------------------------------------- TESTES -------------------------------------------------- # 
[ ! -x "$(which rsync)" ] && sudo apt install rsync -y # rsync instalado?
# --------------------------------------------------------------------------------------------------------------------------- #
# ------------------------------------------------- FUNÇÕES ------------------------------------------------- #
Backup_local () {
  clear && echo -e "${AMARELO}Backup local \n" && tput sgr0
  echo "$MENSAGEM_LOG" >> "$ARQUIVO_LOG"
  rsync -avh --progress "$dir_origem" "$dir_destino" --log-file="$ARQUIVO_LOG" # Alterar as opções se necessário
  Verifica_status
}
Backup_remoto () {
  clear && echo -e "${AMARELO}Backup remoto \n" && tput sgr0
  echo "$MENSAGEM_LOG" >> "$ARQUIVO_LOG"
  sudo rsync -avhP --progress -e ssh "$dir_origem" "$dir_destino" --log-file="$ARQUIVO_LOG" # Alterar as opções se necessário
  Verifica_status
}
Verifica_status () {
  tail -1 "$ARQUIVO_LOG" | grep "rsync error" 
  if [ ! $? -eq 0 ]; then
    echo -e "\n${VERDE}Backup concluído com sucesso. \n" && tput sgr0 && exit 0
  else
    echo -e "\n${VERMELHO}Backup concluído com erros. Erros mais comuns: \n
    - Nome do arquivo e/ou diretório incorretos
    - Arquivos ou diretório inexistentes
    - Diretório está vazio 
    - Nomes compostos sem * entre as palavras. Ex: /Área*de*Trabalho
    " && tput sgr0 && exit 1
  fi
}   
# --------------------------------------------------------------------------------------------------------------------------- #
# ------------------------------------------------- EXECUÇÃO ------------------------------------------------ #
echo -e "\n Backup com rsync \n $MENU" 
while test -n "$1"; do
  case "$1" in
    -l)
        clear && echo -e "${AMARELO}Backup local \n" && tput sgr0 
        read -rp "Informe a origem: " dir_origem
        #Exemplo: /home/user/nome*composto
        echo -e "\nOs arquivos serão salvos em /home/$USER/Backup/ \n"
        echo "Deseja manter esse diretório de destino? [s/n] "
        read -rn1 resposta && echo ""
        case "$resposta" in
          S | s) dir_destino="/home/$USER/Backup/" && Backup_local ;; 
          N | n) read -rp "Digite o diretório de destino: " dir_destino && Backup_local ;; 
              *) echo "Processo abortado." && exit 1 ;;
        esac
    ;;
    -r) 
        clear && echo -e "${AMARELO}Backup remoto \n" && tput sgr0
        read -rp "Digite a origem (Exemplo:/home/$USER/Backup/): " dir_origem && echo ""  
        read -rp "Digite o destino (Exemplo: username@xxx.xxx.xxx:~/destino): " dir_destino && echo ""
        Backup_remoto
    ;;
     *) echo -e "${VERMELHO}Opção inválida. Digite $0 [-OPÇÃO] \n" && tput sgr0
        exit 1
    ;;
  esac
done
# --------------------------------------------------------------------------------------------------------------------------- #
