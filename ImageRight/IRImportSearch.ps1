##########################################################################
#  Script designed to read strings of text in .WDX and .NDX files
#  and return the location.
##########################################################################


###########################################
#Load Assembly
###########################################
Add-Type -AssemblyName Microsoft.VisualBasic

######################################################
#Input box for search string.  
######################################################
$Path = "\\JMPIMG02\imp-pl_xml$\BackupNDX\"
$PolicyNumber = [string] [Microsoft.VisualBasic.Interaction]::InputBox("Please provide the policy number or the Customer Name your trying to locate", "Imageright Import Lookup")
$PathArray = @()

###########################################################################
# This code snippet gets all the files in $Path that end in ".NDX or .WDX".
###########################################################################
Get-ChildItem $Path -include *.WDX, *.NDX -Recurse | 
   Where-Object { $_.Attributes -ne "Directory"} | 
      ForEach-Object { 
         If (Get-Content $_.FullName | Select-String -Pattern $PolicyNumber) {
            $PathArray += $_.FullName
           
         }
      }
	  
########################################
#If no search results are found
########################################
 If ($PathArray.count -eq 0) {Write-verbose "No Matches for this Search: $PolicyNumber" -Verbose}

##########################################################################################
#Search results are found and automatically opened in the parent folder.
#########################################################################################
	elseif ($PathArray.count -gt 0) {
		$PathArray | ForEach-Object {Invoke-item (Split-Path $_ -Parent)
		Write-Verbose "The Following Match(s)have been Found and the Location is: $_" -Verbose
		}
}