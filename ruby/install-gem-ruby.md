#Install gem in Ruby when we have some permission problem

Follow the steps: 

    1 execute 'sudo xcode-select --install'
    2 Install rbenv with 'brew install rbenv'
    3 Add eval '"$(rbenv init -)"' to the end of '~/.zshrc' or '~/.bash_profile'
    4 Install a ruby version 'rbenv install 2.3.0'
    5 Select a ruby version by rbenv 'rbenv global 2.3.0'
    6 Open a new terminal window
    7 Verify that the right gem folder is being used with gem env home
