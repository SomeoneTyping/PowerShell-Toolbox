# PowerShell-Toolbox

Contains helpful PowerShell-Modules for everyday work

## Module: Jumper

Attention: The Jumper needs the module "CsvTools" in this repository

Example:

```powershell
# Add the current position to the caret list
PS /home/you> jump -add "home"

# List all saved carets
PS /home/you> jump -list
  home              - /home/you

# Now, when you are somewhere on your computer, you can jump back to a saved caret
PS /somewhere/on/your/computer> jump home
PS /home/you
```

Info: Your first saved caret will be choosen when you just type "jump".
Info: The search for the caret is a contains-search, so its enought just to type "jump ho" in the example above.

## Module: QuickCommand

Attention: The QuickCommand needs the module "CsvTools" in this repository

Example:

```powershell
# Add the current position to the caret list
PS /home/some/docker/folder> ls

[...]
-a----       01.01.2019     15:00            123 Dockerfile
[...]

# List all saved carets
PS /home/some/docker/folder> quick


# Now, when you are somewhere on your computer, you can jump back to a saved caret
PS /somewhere/on/your/computer> jump home
PS /home/you
```


