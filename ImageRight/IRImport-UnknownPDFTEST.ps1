###########################################
#Variables
##########################################
$Path = "\\jmpimg02\IMP-PL_XML$"
$ReviewDir = "\\JMPIMG02\IMP-PL_XML$\Review"
$Limit = (Get-Date).AddDays(-7)
$DelFiles = @()

###########################################
#Parm for emailing failed imports
###########################################

$EmailFrom = "noreply@jminsure.com"  
$EmailTo = "Dwarner@jminsure.com"
$EmailBody = "This document was not imported into Imageright, and we don't know where it belongs  We're hoping you'll know where it goes."
$EmailSubject = "PL imports"
$SMTPServer = "jmicmail.jewelersnt.local"

$MailParms = @{
From = $EmailFrom;
To = $EmailTo;
Subject = $EmailSubject;
BodyAsHtml = $false;
Body = $EmailBody;
SmtpServer = $SMTPServer;
};

#########################################################
#Identifies and emails .PDF that didn't import correctly.
#########################################################
$EmailFiles = Get-Childitem -Path $Path -include *_*.PDF
If ($Null -ne $EmailFiles){
Write-verbose "Files to be emailed $EmailFiles" -Verbose
$EmailFiles | send-mailmessage @MailParms
}

##############################################################
#Moves files to temporary folder before deleting after 1 week.
##############################################################
Foreach ($EmailFile in $EmailFiles) {
	Move-Item -Path $EmailFile -Destination $ReviewDIR
	
	}

###############################################################
#Checks the age of files in $ReviewDIR and removes after $Limit
###############################################################
$DelFiles = Get-ChildItem -Path $ReviewDIR -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } 
Foreach ($DelFile in $DelFiles) {
Write-Verbose "Files Deleted: $DelFile" -Verbose

$DelFile | Remove-Item -Force
}