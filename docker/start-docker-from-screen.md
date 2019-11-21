# Docker em looping e não inicia

- Pode acontecer de ficar em looping e não inicia
- Processamento do docker está muito elevado

The solution for us is to:

Stop docker desktop completely
Start docker desktop from Applications
Wait for 1 minute (critical step, otherwise next step doesn't work)
Execute the command: screen ~/Library/Containers/com.docker.docker/Data/vms/0/tty
You should see on the screen some strange message and a cursor jumping around like crazy; this is desired; if not, see the steps below for "RESET"
Move the cursor up/down with the keys; this makes screen repaint some regions of the terminal and it reveals the boot options of LinuxKit
Select "Continue" from the menu and press enter; the VM is not booting and after 1-2 minutes, docker desktop is running

RESET:

Kill docker desktop from the status bar
Press CTRL+C in the terminal
Blindly: type in the command reset and enter; if necessary, then twice
try again the steps from above