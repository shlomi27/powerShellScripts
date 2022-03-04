Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
$gameProcess = Get-Process 'eldenring' -ErrorAction SilentlyContinue
Write-Host $gameProcess
if ($gameProcess) {
    $desFoldr = "D:\BackUps\eldenRing\"
    If(!(test-path $desFoldr))
    {
      New-Item -ItemType Directory -Force -Path $desFoldr
    }
    $TimeStamp = (Get-Date).ToString('ddMMyyyyHHmmss')
    
    Compress-Archive -Path 'C:\Users\<WinUserName>\AppData\Roaming\EldenRing\76561197960267366\*' -DestinationPath "$($desFoldr)eldenRingSave_$($TimeStamp).zip"
    $countFiles = (Get-ChildItem $desFoldr | Measure-Object ).Count
    
    IF( $countFiles -gt 50 ){
        Get-ChildItem $desFoldr  -Recurse| Where-Object{-not $_.PsIsContainer}| Sort-Object CreationTime -desc| Select-Object -Skip 50| Remove-Item -Force
    }
}
