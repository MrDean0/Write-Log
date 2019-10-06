<#
 .Synopsis
  wires logs to log folder at root of script
 .Description 
  writes log to folder created at root of script calling function if not called from script then log will be created at the current working directory
 .Parameter pipe
  content to be writen to the log
 .Examples
   $Processes | write-log
   "blahblah" | Write-log
#>
function Write-log {
    Param(
        [Parameter(Mandatory = $true,
        ValueFromPipeline = $true)]
        [String[]]$Log
        )
    try {
        if (($MyInvocation.ScriptName)){ 
            #sets log file name to script name if being called from a script
            $logFileName = "$([io.path]::GetFileNameWithoutExtension($MyInvocation.ScriptName)).log"
        }else{
            $logFileName = "Temp.log"
        }
        $LogFolderName = "Logs"
        $logFolderPath = "$PSScriptRoot\" + "$LogFolderName\"
        $LogFilePath = $logFolderPath + $logFileName
        #creates directorys if needed
        if (!(Test-path $logFolderPath)){ new-Item -Path $logFolderPath -ItemType directory | Out-Null}
        if (!(Test-path $LogFilePath)){ New-Item -Path $LogFilePath -ItemType File | Out-Null}        
        $LogContent = Get-Content $LogFilePath
        $date = Get-Date -Format "d/M/yyyy h:mm:ss tt"
        $Out = $date + " - " +  $Log
        Set-Content $LogFilePath -Value $Out,$LogContent

    }catch{

    Write-Output "Something broke here is the error "
    Write-Output $_
    Write-Output $_.ScriptStackTrace
    }
}
