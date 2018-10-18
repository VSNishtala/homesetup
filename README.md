# HomeSetup
## Terminal .dotfiles and bash improvements for MacOs

### 1. Installation

#### 1.1 Clone the repository using the following command:

`#> git clone https://github.com/yorevs/homesetup.git ~/HomeSetup`

#### 1.2 Install dotfiles:

`#> cd ~/HomeSetup && ./install.sh` => **To install one by one**

or

`#> cd ~/HomeSetup && ./install.sh -a` => **To install all files**

Your old dotfiles will be backed up using .bak suffix.

### 2. Dotfiles in this project

The following files will be added when installing this project:

```
~/.bashrc # Bash resources init
~/.bash_profile # Profile bash init
~/.bash_aliases # All defined aliases
~/.bash_prompt # Enhanced shell prompt
~/.bash_env # Environment variables
~/.bash_colors # All defined color related stuff
~/.bash_functions # Scripting functions
```

The following directory will be linked to your HOME folder:

`~/bin # Includes all useful script provided by the project`

If this folder already exists, the install script will copy all files into it.

To override or add customised aliases, profile stuff and environment variables, you need to create a custom file as follows:

```
~/.aliases # For aliases customisation
~/.profile # For profile customisation
~/.env # For environment variables customisation
```

### 3. Aliases

This project will many aliases (shortcuts) to your shell:

#### Navigational

ALIAS   | Equivalent
------- | ----------
..      | cd ..
...     | cd ...
....    | cd ....
.....   | cd .....
~       | cd ~
\-       | cd -
?       | pwd

#### General

ALIAS   | Equivalent
------- | -------
q       | exit
reload  | 'Reload all dotfiles and check for updates'
sudo    | 'Enable aliases to be sudo’ed'
cls     | clear
vi      | vim
tl      | tail -F
week    | 'Current week of the month' 
now     | 'Current date'
now-ms  | 'Current timestamp in milliseconds'
wget    | 'MacOS has no wget, so use curl instead'
calc    | 'Evaluate mathematical expression'
urle    | 'URL-encode string'
urld    | 'URL-decode string'

#### IP related

ALIAS   | Equivalent
------- | -------
ifa     | 'List all active interfaces on the system'
ip      | 'Get the real IP on the internet'
ipl     | 'Get the local IPs on the local network'
ips     | 'Get all associated local IPs of the machine'

#### Mac Stuff

ALIAS      | Equivalent
---------- | ----------
clean-ds   | 'Delete all .DS_store files'
show-files | 'Show hidden files in Finder'
hide-files | 'Hiden hidden files in Finder'

**Please check: [bash_aliases](./bash_aliases.sh) for all aliases**

### 4. Functions

This project adds many script functions the shell. All functions provide a help using the options -h or --help.

Function   | Purpose
---------- | ----------
sf         | Search for files recursively
sd         | Search for directories recursively
ss         | Search for strings in files recursively
hist       | Search for a previous issued command from history
del-tree   | Send files recursively to Trash (del tree)
jp         | Pretty print (format) JSON string
ip-info    | Check information about the IP
ip-resolve | Resolve domain names associated with the IP
ip-lookup  | Lookup DNS entries to determine the IP address
port-check | Check the state of a local port
envs       | Prints all environment variables
paths      | Print each PATH entry on a separate line
ver        | Check the version of the app using common ways
tc         | Check whether the tool is installed
tools      | Check whether some dev. tools are installed
aa         | Manipulate all custom aliases (add/remove/set)
save       | Save the one directory to be loaded by `load`
load       | cd into a saved directory issued by `save`
punch      | Punch the clock. Add, edit and list punches
plist      | Display (kill?) a process list, given process name
cmd        | Add/Remove/List/Execute saved bash commands
dv         | Check the latest dotfiles version

**Please check: [bash_functions](./bash_functions.sh) for all functions**

### 5. Scripts

The project contains some useful scripts that can be used directly from shell. It is also added to your path variable.

Function                | Purpose
----------------------- | -----------------------
build-java-hierarchy.py | This is a python application to help understanding a Java project and it's class hierarchies
calc.py                 | Simple app to do mathematical calculations
git-completion.sh       | bash/zsh completion support for core Git
git-diff-cmd            | Enable opendiff to be used with git instead of normal diff
git-pull-all            | Pull all projects within the specified path to the given repository/branch
hostname-change.sh      | Change the hostname permanently
ip-utils.sh             | Validate an IP and check details about it
send-msg.py             | IP Message Sender. Sends UDP/TCP messages using multi-threads
tcalc.py                | Simple app to do mathematical calculations with time 
toolcheck.sh            | Check if the a tool is installed on the system

**Please check: [bin](./bin) for all scripts**

### 5. HomeSetup Terminal

HomeSetup suggests a terminal profile to use. If you want to, you will need to do the following steps:

* [x] Install the terminal font 'Droid-Sans-Mono-for-Powerline-Nerd-Font-Complete.otf'.
* [x] Import the HomeSetup.terminal from "$HOME_SETUP/misc/HomeSetup.terminal" to your Terminal App.
* [x] Set HomeSetup as the default profile.

Done! Now you have your terminal just like mine.

**To keep your HomeSetup updated, don't forget to run `#> dv` sometimes and update (git pull) the code**

