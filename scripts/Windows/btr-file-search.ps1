cur_users = Get-LocalUser | Select-Object Name | ForEach-Object { $_.Name } | Select-Object -Skip 1
gci -r -include *.jpg,*.png,*.aac,*.ac3,*.avi,*.aiff,*.bat,*.bmp,*.exe,*.flac,*.gif,*.jpeg,*.mov,*.m3u,*.m4p,*.mp2,*.mp3,*.mp4,*.mpeg4,*.midi,*.msi,*.ogg,*.png,*.txt,*.sh,*.wav,*.wma,*.vqf,*.pcap,*.zip,*.pdf,*.json 'C:\Users\${cur_users}'
