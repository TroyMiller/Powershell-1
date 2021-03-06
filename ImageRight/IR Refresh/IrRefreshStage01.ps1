#--------------------------------------
# PL Import folder variables
$PL_NDX="F:\imports\plxml\backupNDX\*"
$PL_WDX="F:\imports\plxml\backupWDX\*"
$PL_Errors="F:\imports\plxml\errors\*"
$PL_Temp="F:\imports\plxml\errors\*"
#--------------------------------------
# CL Import folder variables
$CL_LDX="F:\imports\clxml\backupLDX\*"
$CL_NDX="F:\imports\clxml\backupNDX\*"
$CL_Errors="F:\imports\clxml\errors\*"
$CL_Temp="F:\imports\clxml\errors\*"
#--------------------------------------
$server = "JMSIMG01"


#Stop all Imageright services	
	Write-Host "Stopping Imageright Services"
	Get-Service -DisplayName imageright* | Stop-Service 
	Write-Host
#Pause for DBAs to Apply Gold Image	
	Write-Host "After Gold Image has been applied ..."
	Write-Host "Press any key to continue..."
	$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

	Write-Host


# Pause to reconfigure EMC	
	Write-Host
	Write-Host "Primary Device Storage and Import folders are clean..."
	Write-Host "Press any key to reset Cold Import in EMC..."
	$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	Write-Host

#	Start Imageright Services up
	Write-Host
	Write-host "Starting Imageright Services..."
	Get-Service -DisplayName imageright* | Start-Service
	
	
	Write-Host
	Write-Host 
	Write-Host "Refresh Complete"