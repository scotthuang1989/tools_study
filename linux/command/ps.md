[reference](https://www.pslinux.online/index.php)

## PS Usage

The ps command comes has 2 sets of syntax styles, BSD style and UNIX style.
* Using the command without hyphen ("-") is BSD style
* using with hyphen is UNIX style.

For example: ps aux is BSD style and ps -aux is UNIX style. These two commands are not similar. The "u" in the BSD style means "show detailed information", whereas "-u" in the UNIX style is used to show processes for a user. It is permissible to mix both the BSD style and UNIX style. For example: "ps ax -f".

## PS Options

### Simple Process Selection
```
ps --help simple
```
enables you to list the basic options to be used with the ps command

<table>
<tr><th>OPTIONS</th><th>Description</th></tr>
<tr><td>-A, -e </td><td>all processes</td></tr>
<tr><td>-a </td><td>all with tty, except session leaders</td></tr>
<tr><td> a</td><td>all with tty, including other users</td></tr>
<tr><td>-d</td><td>all except session leaders</td></tr>
<tr><td>-N, --deselect</td><td>negate selection</td></tr>
<tr><td>r </td><td>only running processes</td></tr>
<tr><td>T </td><td>all processes on this terminal</td></tr>
<tr><td>x </td><td>processes without controlling ttys</td></tr>
</table>

### Process Selection by List

```
ps --help list
```

<table>
<tr><th>Selection by list</th><th>Description</th></tr>
<tr><td>-C </td><td>Selects the processes of given command name</td></tr>
<tr><td>-G </td><td>Selects the processes whose real group name or ID given.</td></tr>
<tr><td>-g</td><td>Selects the processes whose session or effective group name given.</td></tr>
<tr><td>-p</td><td>Selects the processes whose process id select by parent process id</td></tr>
<tr><td>-s</td><td>Selects the processes whose session id given.</td></tr>
<tr><td>-t, t</td><td>Indicate the terminal associated with ps</td></tr>
<tr><td>-u </td><td>Selects the processes whose effective user id or name given.</td></tr>
<tr><td>U</td><td>Selects the processes whose real user id or name given.</td></tr>
</table>


### Output Format

```
ps --help output
```
<table>
<tr><th>Output Formats</th><th>Description</th></tr>
<tr><td>-F </td><td>extra full format</td></tr>
<tr><td>-f </td><td>full-format listing</td></tr>
<tr><td>-c</td><td>Show different scheduler information for the -l option.</td></tr>
<tr><td>-j</td><td>show process hierarchy</td></tr>
<tr><td>j</td><td>jobs format, BSD job control format</td></tr>
<tr><td>-l</td><td>long format</td></tr>
<tr><td>l</td><td>BSD long format</td></tr>
<tr><td>-M, Z</td><td>add security data (for SELinux)</td></tr>
<tr><td>-O, O</td><td>preloaded with default columns</td></tr>
<tr><td>-o, o</td><td>user defined format</td></tr>
<tr><td>s</td><td>signal format</td></tr>
<tr><td>u</td><td>user-oriented format</td></tr>
<tr><td>v</td><td>virtual memory format</td></tr>
<tr><td>X</td><td>register format</td></tr>
<tr><td>-y</td><td>do not show flags, show rrs vs. addr</td></tr>
</table>

### Thread Display

```
ps --help threads
```
<table class='ps-table'>
<tr><th>OPTIONS</th><th>DESCRIPTION</th></tr>
<tr><td>H</td><td>Show threads as if they were processes.</td></tr>
<tr><td>-L</td><td>Show threads, possibly with LWP and NLWP columns.</td></tr>
<tr><td>m</td><td>Show threads, possibly with SPID column.</td></tr>
<tr><td>-m</td><td>Show threads after processes.</td></tr>
<tr><td>-T</td><td>Show threads after processes.</td></tr>
</table>


### Other Options in PS command

<table class='ps-table'>
<tr><th>OPTIONS</th><th>DESCRIPTION</th></tr>
<tr><td>--help section</td><td>Print a help message.  The section argument can be one of
              simple, list, output, threads, misc or all.  The argument can be
              shortened to one of the underlined letters as in: s|l|o|t|m|a.</td></tr>
<tr><td>--info</td><td>Print debugging info.</td></tr>
<tr><td>L</td><td>List all format specifiers.</td></tr>
<tr><td>V</td><td>Print the procps-ng version.</td></tr>
<tr><td>-V</td><td>Print the procps-ng version.</td></tr>
<tr><td>--version</td><td> Print the procps-ng version.</td></tr>
</table>

## Sort Process by CPU, Memory Usage

```
ps aux --sort=-pcpu,+pmem
```

## Change Column Display

```
ps -e -o pid,uname,pcpu,pmem,comm
```
