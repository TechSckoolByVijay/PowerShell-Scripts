Start-Transcript -Path "C:\automation\logs\notepad++_install.log" -Force


# Source file location
$source = 'https://objects.githubusercontent.com/github-production-release-asset-2e65be/33014811/631fdd8c-a753-409b-8690-985980874723?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20220716%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220716T170410Z&X-Amz-Expires=300&X-Amz-Signature=5e8721c2e835bae03ef51b8c12db36b43f07be99b3cd32df72375245db192cfc&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=33014811&response-content-disposition=attachment%3B%20filename%3Dnpp.8.4.2.Installer.x64.exe&response-content-type=application%2Foctet-stream'

# Destination to save the file
$destination_dir = 'c:\automation\installers\'
$installation_file = "$destination_dir\notepad++.exe"
$softwareName='notepad'



if ( ( Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*).DisplayName -like "$softwareName*"){
    Write-Output "Software is already installed"
    Write-Host "--------> Exiting <--------" -ForegroundColor Red -BackgroundColor Yellow
    Exit;
} else {
    Write-Output "Software not installed. Proceeding with installation"
}



#Download the file at the specified location
if (-not ( Test-Path $installation_file)){

    New-Item $destination_dir -ItemType Directory -Force
    Invoke-WebRequest -Uri $source -OutFile $installation_file -Verbose 
    
}


Write-Output "Installing software: $softwareName"
Start-Process $installation_file /S -NoNewWindow -Wait -PassThru


if ( ( Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*).DisplayName -like "$softwareName*"){
    Write-Output "Software is installed successfully"
}

Stop-Transcript