﻿#
# DeployPackage.ps1
#

param(
[string]$CrmConnectionString,
[string]$PackageName,
[string]$PackageDirectory,
[string]$LogsDirectory = ''
)

$ErrorActionPreference = "Stop"

Write-Verbose 'Entering DeployPackage.ps1'

#Parameters
Write-Verbose "CrmConnectionString = $CrmConnectionString"
Write-Verbose "PackageName = $PackageName"
Write-Verbose "PackageDirectory = $PackageDirectory"
Write-Verbose "LogsDirectory = $LogsDirectory"

#Script Location
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
Write-Verbose "Script Path: $scriptPath"

#Load XRM Tooling

$crmToolingConnector = $scriptPath + "\Microsoft.Xrm.Tooling.CrmConnector.Powershell.dll"
$crmToolingDeployment = $scriptPath + "\Microsoft.Xrm.Tooling.PackageDeployment.Powershell.dll"

Write-Verbose "Importing: $crmToolingConnector" 
Import-Module $crmToolingConnector
Write-Verbose "Imported: $crmToolingConnector"

Write-Verbose "Importing: $crmToolingDeployment" 
Import-Module $crmToolingDeployment
Write-Verbose "Imported: $crmToolingDeployment"

#Check Logs Directory
if ($LogsDirectory -eq '')
{
    $LogsDirectory = $PackageDirectory
}

#Create Connection

$CRMConn = Get-CrmConnection -ConnectionString $CrmConnectionString -Verbose

#Deploy Package

Import-CrmPackage –CrmConnection $CRMConn –PackageDirectory $PackageDirectory –PackageName $PackageName -LogWriteDirectory $LogsDirectory -Verbose

Write-Verbose 'Leaving DeployPackage.ps1'
