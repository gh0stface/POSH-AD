#===========================================================================================================================
#	Name: ps_GetRemoteUsers.ps1
#	Author: Abrom Douglas III
#	Email: scripts[@]gh0stface.com
#	Date: 06/30/2017
#	Description: 	This will return all local users and groups from machines listed in the "servers.txt" file and then will create a LocalUsersReport.csv report of all what local accounts on what servers
#	Note: 			Ensure that the "servers.txt" file does in fact exist in the same directory as where this script is running from, otherwise this script will throw an error. The input file must be one server per line.
#					You must run this script with credntials that has access to the servers/computers you are trying to access.
#===========================================================================================================================

get-content "servers.txt" | foreach-object { 
    $Comp = $_ 
    if (test-connection -computername $Comp -count 1 -quiet) 
{ 
                    ([ADSI]"WinNT://$comp").Children | ?{$_.SchemaClassName -eq 'user'} | %{ 
                    $groups = $_.Groups() | %{$_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null)} 
                    $_ | Select @{n='Server';e={$comp}}, 
                    @{n='UserName';e={$_.Name}}, 
                    @{n='Active';e={if($_.PasswordAge -like 0){$false} else{$true}}}, 
                    @{n='PasswordExpired';e={if($_.PasswordExpired){$true} else{$false}}}, 
                    @{n='PasswordAgeDays';e={[math]::Round($_.PasswordAge[0]/86400,0)}}, 
                    @{n='LastLogin';e={$_.LastLogin}}, 
                    @{n='Groups';e={$groups -join ';'}}, 
                    @{n='Description';e={$_.Description}} 
   
                 }  
           } Else {Write-Warning "Server '$Comp' is Unreachable hence Could not fetch data"} 
     }|Export-Csv -NoTypeInformation .\LocalUsersReport.csv 
