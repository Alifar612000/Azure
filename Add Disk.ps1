$disks = get-disk | where partitionstyle -eq 'raw' | sort number

        $letters = 70..89 | ForEach-Objct { [char]$_ }
        $count = 0
        $lables = "data1","data2"

        ForEach ($disk in $disks) {
            $driveLetter = $letters[$count].ToString()
            $disk | 
            Initialize-Disk -PartitionStyle MBR -PassThru |
            New-Partition -UseMaximumSize -DriveLetter $driveLetter |
            Format-Volume -FileSystem NTFS _NewFilesystemLabel $lables[$count] -confirm:$false -Force
        $count++
        }