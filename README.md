# PowerShell-Toolbox

Contains helpful PowerShell-Modules for everyday work

Every module in this repository works independant.

## Module: Jumper

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
