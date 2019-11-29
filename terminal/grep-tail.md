#How use grep or tail and together

Exemple 1
```cat access.log | grep POST | grep '" 500 ' | tail```
Just get text in file with POST and text " 500.

Example 2
```tail -F access.log | grep POST | grep '" 500 '```
Keep reading text inside file

Example 3
```zgrep -A100 -B100 "like text" file.log | zless```
Bring 100 lines after and 100 lines before