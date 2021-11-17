# PowerShell-Toolbox

Contains helpful PowerShell-Modules for everyday work.

## Installation

See comments in "import.ps1" file for temporary import and permanent import (or import with every start of the PowerShell)


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


## Module: DockerCommander

Example:

```powershell

# Show help with all available commands
PS /home/you> dc

usage: dc [action]

Actions:
  lumos                                  --> Show all active containers and all images
  stop                                   --> Stops all running containers
  clean [all|container|images|volumes]   --> Default: all. Removes unused containers, images and volumes.
  jump                                   --> Jump per shell into a running container

# Jump with the shell into a running container. When there is only one container running, jump directly into it.
PS /home/you> dc jump

```


## Module: QuickCommand

Attention: The QuickCommand needs the module "CsvTools" in this repository

Example:

```powershell
# In your current folder is a Dockerfile
PS /home/some/docker/folder> ls

[...]
-a----       01.01.2019     15:00            123 Dockerfile
[...]

# Type "quick" and it will list some previously saved commands (see configurations.csv.EXAMPLE) to execute directly
PS /home/some/docker/folder> quick
  1 - docker build --tag currentdocker . ; docker run -it currentdocker
Execute Number: 1

# Now, the selected command will be executed directly


```


