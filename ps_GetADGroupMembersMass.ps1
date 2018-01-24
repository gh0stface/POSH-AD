#===========================================================================================================================
#	Name: ps_GetADGroupMembersMass.ps1
#	Author: Abrom Douglas III
#	Email: scripts[@]gh0stface.com
#	Date: 07/05/2017
#	Description: 	This imports a list of AD security groups and runs a foreach to gather the group members.
#					The input file must be named "securitygroups.csv" and located in the same directory as this script
#					The result file will be a CSV file, saved to the same location as where you're running the script from.
#					This does not handle nesting, however the ObjectClass is included in the results
#					This script runs an Get-ADGroupMember CMDlet per group in a series manner, therefore timeouts should not happen, unless the group membership is massive.
#===========================================================================================================================

#	Local date/time the script starts
$StartTime = Get-Date
Write-host ""
Write-host "	Start Time: $StartTime"  -foregroundcolor green
Write-host ""

#	Update the below file to the location of your flat text file if you wish
$Groups = Get-Content ".\securitygroups.csv"

#	Runs a get-adgroupmember CMDlet against all groups in above defined file. Output file is date/time appended
foreach($Group in $Groups) {
	Get-ADGroupMember -Identity $Group |
	select @{Expression={$Group};Label="Group Name"},SamAccountName,distinguishedName,objectClass |
	Export-CSV ".\ADGroupMembership_$(get-date -f yyyy-MM-dd).csv" -NoType -Append
}

#	This is to aid the user in knowing how long the script took to run
Write-host ""
Write-host "	Start Time: $StartTime"  -foregroundcolor green
Write-host ""
$FinishTime = Get-Date
Write-host "	Finish Time: $FinishTime"  -foregroundcolor red
Write-host ""
