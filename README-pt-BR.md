# Sublime_Text

Os arquivos deste diretório foram testados no **Sublime Text versão 3.2.2**.<br>
A maioria dos scripts focam o ambiente **Linux**.<br>

## Alguns Detalhes

No diretório **`Sublime-Build`** os códigos tem como objetivo principal, facilitar a compilação e a visualização da execução (resultados) no emulador terminal, que neste caso é o `xfce4-terminal`.<br>
Há outros emuladores de terminal no Linux como o `gnome-terminal`, `xterm`, `konsole`, entre outros.

Exemplo: <br>

**`C++17_xfce4-terminal.sublime-build`**<br>

```
{
  "cmd": ["bash", "-c", "g++ -std=c++17 '${file}' -o '${file_path}/${file_base_name}' && xfce4-terminal -e 'bash -c \"${file_path}/${file_base_name};echo;echo;echo Compilation Completed C++17;echo Press ENTER to continue; read line; rm ${file_path}/${file_base_name}; exit; exec bash\"'"],
  "file_regex": "^(..[^:]*):([0-9]+):?([0-9]+)?:? (.*)$",
  "working_dir": "${file_path}",
  "selector": "source.c, source.c++, source.cxx, source.cpp"
}
```
<br>

Explicando os passos:<br>

1. Chama-se o **Bash** para executar uma sequência de comandos, o primeiro é do compilador **g++**.<br>
- `"bash", "-c", "g++ -std=c++17 '${file}' -o '${file_path}/${file_base_name}'` ...<br>
2. Compilado o arquivo **C++**, este será aberto no terminal externo, abrindo uma janela do **xfce4-terminal**.<br>
- `&& xfce4-terminal -e` ...<br>
3. No **xfce4-terminal** é executado outra sequência de comandos Bash que em resumo irá rodar o arquivo C++ executável, processar e ao final escrever "Press ENTER to continue" e aguardar o "ENTER". Quando teclado, o Bash remove o arquivo executável e o arquivo objeto, voltando ao estado inicial.<br>
- `'bash -c \"${file_path}/${file_base_name};echo;echo;echo Compilation Completed C++17;echo Press ENTER to continue; read line; rm ${file_path}/${file_base_name}; exit` ...<br>

## Saiba mais:

[xfce4-terminal](https://docs.xfce.org/apps/terminal/start) (Terminal do XFCE4) <br>
[Sublime Text](https://www.sublimetext.com/docs/3/build_systems.html) (DOCUMENTATION Build Systems) <br>

**Atenção:** Estude os scripts e as referências antes executá-los.
