:: author - Thomas Underwood
:: date   - 2020/03/15
:: call readvers.bat, which reads vers.php in this directory
:: this is then used to create a tag under that version number
:: read_vers.bat 2020 © Thomas Underwood
::
:: reads the file vers.php in the same directory and echoes the version number
:: this assumes that the file follow the following expected format
:: <?php
::     $vers = 1.1.1.1;
:: ?>
@echo off
SETLOCAL EnableDelayedExpansion
:: expects verion file to be named vers.php by default
:: if using default value vers.php, it will be looked for
:: in the directory from which this script is called.
:: e.g if doing CALL somedir/read_vers.bat, vers.php
:: should be one level up, etc.
SET versfile=vers.php
:: find the line that doesn't have a ? and put it in text.txt
ECHO Detecting version number in %versfile%..
FOR /F "delims=" %%a in ('findstr /v "?" %versfile% ') DO SET var=%%a
:: remove the $vers
SET newvar=!var:$vers=!
:: remove the whitespace
SET newvar=!newvar: =! 
:: echo what we have into the temp file
ECHO !newvar! > temp1.txt
:: hide the temp file
ATTRIB +H temp1.txt
:: read the file using = as a delimeter to remove it
FOR /F "delims==;" %%b in (temp1.txt) DO SET endvar=%%b
:: endvar is now version number, output to version.txt
ECHO !endvar! > temp_version.txt
:: hide the temp file
ATTRIB +H temp_version.txt
:: tidy up, unhide temp file first
ATTRIB -H temp1.txt
DEL temp1.txt
:: return to where this sr was called
EXIT /B