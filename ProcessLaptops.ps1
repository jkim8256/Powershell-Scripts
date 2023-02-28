$username = Read-Host "Please enter Username: "
#$path = Join-Path -Path '\\dcmpfp8\e$\NAS\Archived_User_Profiles\' -ChildPath $username
$user = ''
$temp = 'C:\Users\jason.kim\Desktop\testingSC'
New-Item -Path $temp -ItemType Directory #creating folder into destination

if(Test-Path D:\Users) {
   $user = Join-Path -Path 'D:\Users\' -ChildPath $username
}else {
   $user = Join-Path -Path 'C:\Users\' -ChildPath $username
}

$desktop = Join-Path -Path $user -ChildPath '\Desktop'
$documents = Join-Path -Path $user -ChildPath '\Documents'
$pictures = Join-Path -Path $user -ChildPath '\Pictures'
$outlook = Join-Path -Path $user -ChildPath '\AppData\Local\Microsoft\Outlook'

$files = Get-ChildItem $outlook #get all files/folders in outlook
foreach ($file in $files) {
    $extn = [IO.Path]::GetExtension($file)
    if ($extn -eq ".ost" ){
        $fp = Join-Path -Path $outlook -ChildPath $file.Name
        Copy-Item $fp -Destination $temp -Recurse #copying .pst file into destination
    }
}
Copy-Item $pictures -Destination $temp -Recurse #to be deleted
Copy-Item $documents -Destination $temp -Recurse # to be deleted. testing purpose
#Copy-Item $pictures -Destination $path -Recurse #copying pictures to destination
#Copy-Item $desktop -Destination $path -Recurse #copying desktop to destination
#Copy-Item $documents -Destination $path -Recurse #copying documents to destination
Write-Output 'done'
Read-Host -Prompt "Press Enter to exit"