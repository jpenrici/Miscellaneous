# Installation

1) Close Qt Creator.
2) Copy the directory to /home/user/Perl_Formatter.
3) Grant execution permission to the script (chmod +x perl_formatter.sh).
4) Copy the Perl_Formatter.xml file to /home/user/.config/QtProject/qtcreator/externaltools.
5) Locate the file /home/user/.config/QtProject/QtCreator.ini and modify the [ExternalTools] argument by inserting the lines:

```
[ExternalTools]
...
OverrideCategories\Perl\1\Tool=Perl_Formatter
OverrideCategories\Perl\size=1
...
```

6) Open Qt Creator again and go to Edit > Preferences > Environment > External Tools and verify the changes.
