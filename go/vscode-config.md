### To stop remove imports when we save the file.

Ctrl+Shift+P --> Configure Language Specific Settings
```
{
    "git.confirmSync": false,
    "[go]": {

        "editor.insertSpaces": false,
        "editor.formatOnSave": false,
        "editor.codeActionsOnSave": {
            "source.organizeImports": true
        },
        "editor.suggest.snippetsPreventQuickSuggestions": true
    },
    "workbench.iconTheme": "material-icon-theme",
    "gopls": {
        "experimentalWorkspaceModule": true,
    }
}
```