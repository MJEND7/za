# ZA - Zoom Around the terminal

```
 ________  ________     
|\_____  \|\   __  \    
 \|___/  /\ \  \|\  \   
     /  / /\ \   __  \  
    /  /_/__\ \  \ \  \ 
   |\________\ \__\ \__\
    \|_______|\|__|\|__|               
```
                        
The **ZA** terminal utility is a Bash-based system for listing files and directories within a specified directory and provides the option to navigate to a specific directory or open a file using the configured text editor.

### Why?
I've spent considerable time working on deployments, and the constant need to use multiple commands to navigate the file system and deal with files like "config_bak_whatever.json" is a flipping pain. These files and folders are pretty mcuh lists so why couldn't simply use an index to 'cd' into them. This frustration inspired the creation of ***za***, initially intended for just a better way to open folders expanded to include text editor configuration that eliminated the need for an extra command to open files; I want ***za*** to handle that. While it's a work in progress, its current simplicity efficiently accomplishes the task. I'm eager to further develop and share the concept of streamlining terminal tools and tools in general for faster and more efficient workflows.

#### Usage

```bash
# List files and directories in the current directory
za

# Move to the directory or open the file with the configured text editor
za [directory_path or file_number]
```

### Commands and Features

**List Files and Directories:**
- Execute `za` to list files and directories in the current directory.

**Navigate or Open:**
- Execute `za [directory_path or file_number]` to navigate to the specified directory or open the file with the configured text editor. Use '+' to indicate a folder and '-' for a file.

**Configuration:**
- Execute `za -ce [editor_command]` to set the default text editor command. For example, `za -ce vim` sets the default editor to Vim.

**Show Help:**
- Execute `za help` to display this help message.

### Example

```bash
$ za
[1][+] Documents
[2][-] notes.txt
[3][+] Pictures
```

Enter `za 1` to move to the 'Documents' directory or `za 2` to open 'notes.txt' with the configured text editor.

### Note for V0.1

**Text Editor:** The script uses the configured text editor to open files. Ensure that your desired text editor is installed on your system for the full functionality of the script.

#### Installation

To install **ZA**, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/MJEND7/za.git
   cd za
   ```

2. Run the installation:

   ```bash
   make install
   ```

   This will make the script executable, copy it to /usr/local/bin/za, create an alias for 'za' using the `source` command, and update the bash configuration.

3. Now you can use **ZA** by simply typing:

   ```bash
   za
   ```

#### Uninstallation

To uninstall **ZA**, use the following command:

```bash
make uninstall
```

This will remove the script from /usr/local/bin/za, remove the alias, and update the bash configuration accordingly.

---

### Makefile

```make
alias za="source /usr/local/bin/za"
```

creates a shortcut command `za` that, when executed, is equivalent to running `source /usr/local/bin/za`. This line is part of your makefile and helps set up a convenient way to run your Bash script.

The makefile provides two targets - `install` and `uninstall`. The `install` target sets up the necessary permissions, copies the script to the system's bin directory, creates an alias for 'za', and updates the bash configuration. The `uninstall` target removes the script, unaliases 'za', and updates the bash configuration accordingly.
