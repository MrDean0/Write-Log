<#
 .Synopsis
  Writes a time stamped log to a given file


 .Parameter Piped content
  content to be writen to the log

 .Example
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
        $LogFolderName = "Logs"
        $logFolderPath = "$PSScriptRoot\" + "$LogFolderName\"
        $logFileName = "$([io.path]::GetFileNameWithoutExtension($PSCommandPath)).log"
        $LogFilePath = $logFolderPath + $logFileName
  
        if (!(Test-path $logFolderPath)){ new-Item -Path $logFolderPath -ItemType directory }
        if (!(Test-path $LogFilePath)){ New-Item -Path $LogFilePath -ItemType File }
        
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


  
        
  