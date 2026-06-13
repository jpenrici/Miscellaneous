# Kate editor

Install the file in the directory of your choice, for example:

`/home/user/scripts/compile_and_run.pl`

# Configuration

In Kate, configure the external tool or create the file:

`/home/user/.config/kate/externaltools/Execute%20CMakeLists.ini`

```
[General]
actionName=externaltool_ExecuteCMakeLists
arguments=--dir="%{Document:NativePath}"
category=Custom
executable=/home/user/scripts/compile_and_run.pl
icon=text-x-c++src
name=Execute CMakeLists
output=Ignore
reload=false
save=None
trigger=None
```

# Running

In Kate, open the CMakeLists.txt file and go to Tools > External Tools > Custom > Run CMakeLists.txt

