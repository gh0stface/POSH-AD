#===========================================================================================================================
#	Name: ps_GetIdentity.ps1
#	Author: Abrom Douglas III
#	Email: scripts[@]gh0stface.com
#	Date: 06/30/2017
#	Description: 	This will gather core identity information on a user within AD and export a CSV file to the same location the script is being run from
#===========================================================================================================================

Write-Host ""
Write-Host "	Get Identity Data from AD"
Write-Host ""
Write-Host "		The results file will be placed in the same directory where this script is being run from"
Write-Host ""

# Get the AD account from the user
$identity=Read-Host 'What is users AD account?'

Write-Host ""
Write-Host "Start time: $(get-date)"
Write-Host ""

# Primary script to gather info
$identitydata = get-aduser $identity -properties * | select SamAccountName,EmployeeID,mail,UserPrincipalName,DisplayName,DistinguishedName,GivenName,sn,Company,Department,Division,employeeType,Created,Description,Manager,City,Country,whenCreated

# Output the differences to a text document 
$identitydata | export-csv ".\${identity}_identitydata_$(get-date -f yyyy-MM-dd).txt" -delimiter '|' -notype

Write-Host "";
Write-Host "Report complete";
Write-Host "Finish time: $(get-date)";
Write-Host "Results found here: $(get-Location)\";
Write-Host "";
