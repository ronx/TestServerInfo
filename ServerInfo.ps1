[cmdletbinding()]
[OutputType([pscustomobject])]
param(
    [Parameter(Mandatory)]
    [string[]]$ComputerName,

    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    $Credential
)

process {
    foreach ($name in $ComputerName) {
        $cimSession = New-CimSession -ComputerName $name -Credential $Credential
        $compSys = Get-CimInstance -CimSession $cimSession -ClassName Win32_Computersystem
        Remove-CimSession $cimSession
        [PSCustomObject]@{
            ComputerName = $compSys.Name
            PrimaryOwner = $compSys.PrimaryOwnerName
            RAM = $compSys.TotalPhysicalMemory
            Manufacturer = $compSys.Manufacturer
            Model = $compSys.Model
        }
    }
}
