$serviceName = "Print Spooler";
Stop-Service -Name $serviceName;
$spoolDir = "C:\Windows\System32\spool\PRINTERS";
Get-ChildItem -Path $spoolDir -File | ForEach-Object { $_.Delete(); }
Start-Service -Name $serviceName;
Read-Host -Prompt "Press enter to exit";