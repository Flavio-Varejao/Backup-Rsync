# Backup com a Ferramenta Rsync

Site:
Autor:      Flávio Varejão
Manutenção: Flávio Varejão

Estes scripts fazem o backup de arquivos locais ou remotos utilizando a ferramenta rsync.

<a name="ancora"></a>
- [Versão com Bash](#ancora1)
- [Versão com Dialog](#ancora2)

<a id="ancora1"></a>
## rsync-backup.sh
>
### Permissão

Dê permissão de execução (primeiro acesso):
```
    $ chmod +x rsync-backup.sh
```

### Execução

Neste exemplo o script vai executar um backup local:
```
    $ ./rsync-backup.sh -l
``` 
 
Na execução do script é possível escolher o diretório de origem e de destino dos arquivos. 
No término do backup é gerado um arquivo de log com informações do backup 
(data, hora, arquivos copiados, etc).

### Opções incluídas ou sugeridas para o comando rsync:

-a Agrupa todas essas opções -rlptgoD (recursiva, links, permissões, horários, grupo, proprietário, dispositivos);
-v Modo verboso (mostra o processo);
-h Números compreensíveis para humanos;
-P Exibe os tempos de transferência, nomes dos arquivos e diretórios sincronizados;
-z Comprime os arquivos ou diretórios;
-e ssh Utiliza o protocolo de rede SSH;
--delete-after Após a transferência exclui arquivos do destino que não estão na origem (sincroniza os diretórios);
--progress Mostra o progresso durante a transferência.

Para incluir novas opções veja em 'rsync --help' altere o comando rsync na seção de FUNÇÕES.

### Histórico:

  Versão 1.0, Flávio:
    17/03/2020
      - Início do programa.
      - Adicionado variáveis, testes, funções e execução.
    28/03/2020         
      - Adicionado tratamento de erros (função Verifica_status).
  Versão 2.0, Flávio:
    29/07/2020
      - Alterações no cabeçalho do script e no comando do backup remoto.

### Testado em:

  bash 5.0.17
  
[Topo](#ancora)

<a id="ancora1"></a>
## rsync-backup-dv1.0.sh
>
### Permissão

Dê permissão de execução (primeiro acesso):
```
    $ chmod +x rsync-backup-dv1.0.sh
```

### Execução

Neste exemplo o script vai perguntar se você deseja fazer um backup:
```
    $ ./rsync-backup-dv1.0.sh
```

Na execução do script é possível escolher o diretório de origem e de destino dos arquivos.
No término do backup é gerado um arquivo log com informações do backup 
(data, hora, arquivos copiados, etc).

### Opções incluídas no comando rsync:

-a Agrupa todas essas opções -rlptgoD (recursiva, links, permissões, horários, grupo, proprietário, dispositivos);
-v Modo verboso (mostra o processo);
-h Números compreensíveis para humanos;
-P Exibe os tempos de transferência, nomes dos arquivos e diretórios sincronizados;
-z Comprime os arquivos ou diretórios;
-e ssh Utiliza o protocolo de rede SSH;
--delete-after Após a transferência exclui arquivos do destino que não estão na origem (sincroniza os diretórios);
--progress Mostra o progresso durante a transferência.

Para incluir novas opções (rsync --help) altere o comando rsync na seção de FUNÇÕES.

### Histórico:

  Versão 1.0, Flávio:
    25/03/2020
      - Início do programa
      - Adicionado variáveis, testes, funções e execução
    28/03/2020         
      - Adicionado barras de progresso
    31/07/2020
      - Alterações no cabeçalho do script e no comando do backup remoto

### Testado em:
  
  bash 5.0.17

[Topo](#ancora)
