Function main { Param ( [Parameter(Mandatory=$true)] [string]$declaration )

$SoManyAbibases = Get-ChildItem -Path $PSScriptRoot -File -Name | where { ($_ -match "^abibas") -and ($_ -match "$xml") } 

foreach ( $abibasik in $SoManyAbibases ){

    [xml]$X = Get-Content -Path ( Join-Path $PSScriptRoot $abibasik )
    
    if ( (EmitterIP -site $x.ini.FTP_Sever.IP_FTP -ErrorAction Stop) -eq $false ){ 
        Write-Output ( "{0} {1} {2} {3} {4}" -f  "`n`t","Пинг с сервером", $x.ini.FTP_Sever.IP_FTP, "не проходит,", "сообщите об этом своему администратору." )
        Read-Host ("{0} {1}" -f "`n`t`t`t", "Закрыть окно - нажмите Enter") | Out-Null
        return 
    }

    Write-Output ( "{0} {1}{2} {3}" -f  "`n", $x.ini.DisplayName, ":", "`n")
    if ( ($X.ini.FinanceClient.Activate).ToUpper() -eq "ON" ) { Relay_Fi ( $x ) }
    if ( ($X.ini.TreasuryClient.Activate).ToUpper() -eq "ON" ) { Relay_Tr ( $x ) }
    if ( ($X.ini.TreasuryClient.Activate).ToUpper() -eq "OFF" -and ($X.ini.FinanceClient.Activate).ToUpper() -eq "OFF"  ) { Write-host ("Ик! Все блоки в абибасе выключены...") }
}

Write-host ("`n"+">>>> SOKOL-SOFT >>>>") -NoNewline
Read-Host ("{0} {1}" -f "`t", "Закрыть окно - нажмите Enter") | Out-Null

}

main -declaration ХуйВойне!