```markdown
# ZA - Zoom Around the terminal

 ________  ________     
|\_____  \|\   __  \    
 \|___/  /\ \  \|\  \   
     /  / /\ \   __  \  
    /  /_/__\ \  \ \  \ 
   |\________\ \__\ \__\
    \|_______|\|__|\|__|  

The **ZA** terminal utility is a Bash based system list files and directories within a specified directory and provide the option to navigate to a specific directory or open a file using the nano text editor.

#### Usage

```bash
# List files and directories in the current directory
za

# Move to the directory or open the file with nano
za [directory_path or file_number]
```

# Note for V0.1
Nano Editor: The script uses the Nano text editor to open files. Ensure that Nano is installed on your system for the full functionality of the script. I will add a system were you can add you own editor of your choosing Prime, for V0.1 it's just nano

#### Installation

To install **ZA**, follow these steps:

1. Clone the repository:

   ```bash
   git clone <repository_url>
   cd <repository_directory>
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

This will remove the script from /usr/local/bin/za, remove the alias, and update the bash configuration.

---

### Makefile

Certainly! The line:

```make
alias za="source /usr/local/bin/za"
```

creates a shortcut command `za` that, when executed, is equivalent to running `source /usr/local/bin/za`. This line is part of your makefile and helps set up a convenient way to run your Bash script.

The makefile provides two targets - `install` and `uninstall`. The `install` target sets up the necessary permissions, copies the script to the system's bin directory, creates an alias for 'za', and updates the bash configuration. The `uninstall` target removes the script, unaliases 'za', and updates the bash configuration accordingly.