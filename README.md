# Bash Scripting

Types of Linux Shells

- **The Bourne Shell**
- **GNU Bourne-Again Shell (bash)**
- **The C Shell (csh)**
- **TENEX c shell**
- **The Korn Shell (ksh)**
- **The Z Shell (zsh)**
- **Fish Shell**

## **_Bash_**

Bash is a command language interpreter. It is widely available on various operating systems and is a default command interpreter on most GNU/Linux systems. The name is an acronym for the ‘**B**ourne-**A**gain **SH**ell’.

## **_Shell_**

Shell is a macro processor which allows for an interactive or non-interactive command execution.

## **_Scripting_**

Scripting allows for an automatic commands execution that would otherwise be executed interactively one by one.

To see what is meant by scripting, use shell in combination with your favorite text editor eg vi or nano.

1. vi to create a new file called [task.sh](http://task.sh/) containing the following commands

```bash
pentestlab@OSTE:~/Scripts$ cat task.sh
date
cal
id
hostname
pwd
```

1. Once ready, make your new file executable using `**chmod**` command with an option `**+x**`.
2. Lastly, execute your new script by prefixing its name with **`./`**.

```bash
pentestlab@OSTE:~/Scripts$ vi task.sh
pentestlab@OSTE:~/Scripts$ chmod +x task.sh
pentestlab@OSTE:~/Scripts$ ./task.sh
Tue Dec 14 23:05:47 EAT 2021
   December 2021
Su Mo Tu We Th Fr Sa
          1  2  3  4
 5  6  7  8  9 10 11
12 13 14 15 16 17 18
19 20 21 22 23 24 25
26 27 28 29 30 31

uid=1000(pentestlab) gid=1000(pentestlab) groups=1000(pentestlab),4(adm),20(dialout),24(cdrom),25(floppy),27(sudo),29(audio),30(dip),44(video),46(plugdev),114(netdev)
OSTE
/home/pentestlab/Scripts
```

---

`**bash**` is a default interpreter on many GNU/Linux systems, thus we have been using it even without realising. This is why our previous shell script works even without us defining bash as an interpreter. To see what is your default interpreter execute command **`echo $SHELL`**:

```bash
pentestlab@OSTE:~/Scripts$ echo $SHELL
/bin/bash
```

To define your script’s interpreter as Bash, first locate a full path to its executable binary using **`which`** command, prefix it with a [shebang](https://en.wikipedia.org/wiki/Shebang_%28Unix%29) **`#!`** and insert it as the first line of your script.

```bash
pentestlab@OSTE:~/Scripts$ vi job.sh
pentestlab@OSTE:~/Scripts$ cat job.sh
#!/bin/bash

date
cal
id
hostname
pwd

pentestlab@OSTE:~/Scripts$ ./job.sh
Tue Dec 14 23:14:48 EAT 2021
   December 2021
Su Mo Tu We Th Fr Sa
          1  2  3  4
 5  6  7  8  9 10 11
12 13 14 15 16 17 18
19 20 21 22 23 24 25
26 27 28 29 30 31

uid=1000(pentestlab) gid=1000(pentestlab) groups=1000(pentestlab),4(adm),20(dialout),24(cdrom),25(floppy),27(sudo),29(audio),30(dip),44(video),46(plugdev),114(netdev)
OSTE
/home/pentestlab/Scripts
pentestlab@OSTE:~/Scripts$
```

## 💡shell interpreter definition **`#!/bin/bash`**
