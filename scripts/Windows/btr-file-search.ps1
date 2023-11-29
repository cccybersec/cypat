$localusers = Get-LocalUser | Where-Object -Property Enabled -eq True | Select-Object -ExpandProperty Name

foreach ($user in $localusers) {
ls -r -include *.jpg,*.png,*.aac,*.ac3,*.avi,*.aiff,*.bat,*.bmp,*.exe,*.flac,*.gif,*.jpeg,*.mov,*.m3u,*.m4p,*.mp2,*.mp3,*.mp4,*.mpeg4,*.midi,*.msi,*.ogg,*.png,*.txt,*.sh,*.wav,*.wma,*.vqf,*.pcap,*.zip,*.pdf,*.json "C:\Users\${user}"
}


$response = (Read-Host "delete all files listed above (y/n)").ToLower()
if ($response -eq 'y') {
        Remove-Item -recurse -Force -Include *.jpg,*.png,*.aac,*.ac3,*.avi,*.aiff,*.bat,*.bmp,*.exe,*.flac,*.gif,*.jpeg,*.mov,*.m3u,*.m4p,*.mp2,*.mp3,*.mp4,*.mpeg4,*.midi,*.msi,*.ogg,*.png,*.txt,*.sh,*.wav,*.wma,*.vqf,*.pcap,*.zip,*.pdf,*.json "C:\Users\${user}"
}
else {
        Write-Host "then do it your self"
}
