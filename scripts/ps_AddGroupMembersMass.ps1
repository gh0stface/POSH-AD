#===================================================================================================================
#   Name: ps_CompareFolders.ps1
#   Author: Abrom Douglas III
#	Email: scripts[@]gh0stface.com
#	Date: 12/28/2016
#===================================================================================================================
import-module ActiveDirectory
#	Obtain the file location where accounts are listed out
Write-host ""
$filelocation=Read-host "	Location of file (enter entire directory path, including filename"
Write-host ""

#   Define the security group that mass users need to be added to
Write-host ""
$securitygroup=Read-host "	Security group to add users to, distinguishedname is recommended"
Write-host ""

#   Do the work....
$StartTime = Get-Date
Write-host ""
Write-host "	Start Time: $StartTime"  -foregroundcolor green
Write-host ""

#	Get file with users and begin processing it
$users = Get-Content $filelocation

#	Runs an Add-ADGroupMember CMDlet against all acounts in above defined file and adds them to the defined security group
foreach($user in $users) {
    Add-ADGroupMember $securitygroup -Members $user
}

#	This is to aid the user in knowing how long the script took to run
Write-host ""
$FinishTime = Get-Date
Write-host "	Finish Time: $FinishTime"  -foregroundcolor red
Write-host ""
Clear-Variable -Name filelocation
Clear-Variable -Name securitygroup
Clear-Variable -Name StartTime
Clear-Variable -name users
Clear-Variable -name user
Clear-Variable -name FinishTime
Write-host "    Have a great day!"
Start-Sleep -s 2
