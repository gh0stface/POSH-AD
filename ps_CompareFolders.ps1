#===================================================================================================================
#	Name: ps_CompareFolders.ps1
#	Author: Abrom Douglas III
#	Email: scripts[@]gh0stface.com
#	Date: 12/28/2016
#	Description: 	This will compare two folder structures and create an output file of the differences to the same directory as where this script is running
#	Note:			Depending on the names of the directories you may or may not have to include quotes ("") in the full directory path
#					This can be become extremely memory intensive once you go beyond 20,000+ files or more.  Size of files do not matter, but the number (count) of files do.  If going beyond this limit, I would recommend de-constructing this script to create two sepearate single line commands and output the results.  Then do your compare of the already created files or use something like Excel or Access to compare results.
#===================================================================================================================

Write-Host ""
Write-Host "	Compare two directories"
Write-Host "	Written by Abrom Douglas III"
Write-Host ""
Write-Host "		If you are copying 20,000+ files, it's not recommended to use this"
Write-Host "		If the source/destination directories contain spaces use quotes ("")"
Write-Host "		The results file will be placed in the same directory where this script is being run from"
Write-Host ""

# Gather the directories to compare
$sourcedir=Read-Host 'Source Directory Path'
$destinationdir=Read-Host 'Destination Directory Path'
$source = Get-ChildItem -Path $sourcedir -Recurse
$destination = Get-ChildItem -Path $destinationdir -Recurse

Write-Host ""
Write-Host "Start time: $(get-date)"
Write-Host ""

# Differences
$differentfiles = Compare-Object -ReferenceObject $source -DifferenceObject $destination
$differentfiles = $differentfiles.inputobject.fullname

# Output the differences to a text document 
$differentfiles | Out-File .\CompareFoldersReport.txt -Force

Write-Host "";
Write-Host "Comparison complete.";
Write-Host "Finish time: $(get-date)";
$count=get-content .\CompareFoldersReport.txt |measure-object -line | select Lines;
Write-Host "Number of differences: $count";
Write-Host "Results found here: $(get-Location)\CompareFoldersReport.txt";
Write-Host "";
