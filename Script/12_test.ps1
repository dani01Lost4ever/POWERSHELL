Add-Type -AssemblyName System.Windows.Forms
Function Show-Menu {
    Clear-Host
    Write-Host "1. Creare una cartella"
    Write-Host "2. Creare un file di testo"
    Write-Host "3. Copiare una cartella contenente dei file"
    Write-Host "4. Copiare un file"
    Write-Host "5. Cancellare una cartella"
    Write-Host "6. Cancellare un file"
    Write-Host "7. Spostare una cartella"
    Write-Host "8. Spostare un file"
    Write-Host "9. Rinominare una cartella"
    Write-Host "10. Rinominare un file"
    Write-Host "11. Comprimere una cartella"
    Write-Host "12. Scomprimere una cartella compressa"
    Write-Host "Q. Exit"
}

function New-Folder {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ParentFolderPath,
        [Parameter(Mandatory=$true)]
        [string]$FolderName
    )
    
    $FolderPath = Join-Path $ParentFolderPath $FolderName
    New-Item -ItemType Directory -Path $FolderPath
    Write-Host "Folder created: $FolderPath"
    Read-Host "Press Enter to continue..."
}

function New-TextFile {
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath,
        [Parameter(Mandatory=$true)]
        [string]$Text
    )
    $fullPath = $FilePath + ".txt"
    Set-Content -Path $fullPath -Value $Text
    Write-Host "File created: $fullPath"
    Read-Host "Press Enter to continue..."
}

function Copy-Folder {
    param (
        [Parameter(Mandatory=$true)]
        [string]$SourceFolder,
        [Parameter(Mandatory=$true)]
        [string]$DestinationFolder
    )
    Copy-Item -Path $SourceFolder -Destination $DestinationFolder -Recurse
    Write-Host "Folder copied from: $SourceFolder to: $DestinationFolder"
    Read-Host "Press Enter to continue..."
}

function Copy-File {
    param (
        [Parameter(Mandatory=$true)]
        [string]$SourceFile,
        [Parameter(Mandatory=$true)]
        [string]$DestinationFile
    )
    
    Copy-Item -Path $SourceFile -Destination $DestinationFile
    Write-Host "File copied from: $SourceFile to: $DestinationFile"
    Read-Host "Press Enter to continue..."
}

function Delete-Folder {
    param (
        [Parameter(Mandatory=$true)]
        [string]$FolderPath
    )
    
    $confirmationMessage = "Are you sure you want to delete the folder:`n$FolderPath"
    $confirmResult = Show-ConfirmationDialog "Delete Folder" $confirmationMessage
    
    if ($confirmResult -eq [System.Windows.Forms.DialogResult]::Yes) {
        Remove-Item -Path $FolderPath -Recurse -Force
        Write-Host "Folder deleted: $FolderPath"
    } else {
        Write-Host "Deletion canceled by user."
    }
    
    Read-Host "Press Enter to continue..."
}

function Delete-File {
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )
    
    $confirmationMessage = "Are you sure you want to delete the file:`n$FilePath"
    $confirmResult = Show-ConfirmationDialog "Delete File" $confirmationMessage
    
    if ($confirmResult -eq [System.Windows.Forms.DialogResult]::Yes) {
        Remove-Item -Path $FilePath -Force
        Write-Host "File deleted: $FilePath"
    } else {
        Write-Host "Deletion canceled by user."
    }
    
    Read-Host "Press Enter to continue..."
}

function Show-ConfirmationDialog($title, $message) {
    $confirmationPrompt = New-Object Windows.Forms.Form
    $confirmationPrompt.Text = $title
    $confirmationPrompt.Size = New-Object Drawing.Size(300, 150)
    $confirmationPrompt.StartPosition = "CenterScreen"

    $messageLabel = New-Object Windows.Forms.Label
    $messageLabel.Text = $message
    $messageLabel.AutoSize = $true
    $messageLabel.Location = New-Object Drawing.Point(20, 20)

    $yesButton = New-Object Windows.Forms.Button
    $yesButton.Text = "Yes"
    $yesButton.Size = New-Object Drawing.Size(80, 30)
    $yesButton.Location = New-Object Drawing.Point(40, 100)

    $noButton = New-Object Windows.Forms.Button
    $noButton.Text = "No"
    $noButton.Size = New-Object Drawing.Size(80, 30)
    $noButton.Location = New-Object Drawing.Point(180, 100)

    $yesButton.Add_Click({
        $confirmationPrompt.DialogResult = [System.Windows.Forms.DialogResult]::Yes
        $confirmationPrompt.Close()
    })

    $noButton.Add_Click({
        $confirmationPrompt.DialogResult = [System.Windows.Forms.DialogResult]::No
        $confirmationPrompt.Close()
    })

    $confirmationPrompt.Controls.Add($messageLabel)
    $confirmationPrompt.Controls.Add($yesButton)
    $confirmationPrompt.Controls.Add($noButton)

    $confirmationPrompt.ShowDialog()

    return $confirmationPrompt.DialogResult
}


function Move-Folder {
    param (
        [Parameter(Mandatory=$true)]
        [string]$SourceFolder,
        [Parameter(Mandatory=$true)]
        [string]$DestinationFolder
    )
    
    Move-Item -Path $SourceFolder -Destination $DestinationFolder
    Write-Host "Folder moved from: $SourceFolder to: $DestinationFolder"
    Read-Host "Press Enter to continue..."
}

function Move-File {
    param (
        [Parameter(Mandatory=$true)]
        [string]$SourceFile,
        [Parameter(Mandatory=$true)]
        [string]$DestinationFolder
    )
    
    $DestinationPath = Join-Path $DestinationFolder (Split-Path -Leaf $SourceFile)
    Move-Item -Path $SourceFile -Destination $DestinationPath
    Write-Host "File moved from: $SourceFile to: $DestinationPath"
    Read-Host "Press Enter to continue..."
}

function Rename-Folder {
    param (
        [Parameter(Mandatory=$true)]
        [string]$FolderPath,
        [Parameter(Mandatory=$true)]
        [string]$NewName
    )
    
    $NewFolderPath = Join-Path (Split-Path -Parent $FolderPath) $NewName
    Rename-Item -Path $FolderPath -NewName $NewName -Force
    Write-Host "Folder renamed from: $FolderPath to: $NewFolderPath"
    Read-Host "Press Enter to continue..."
}

function Rename-File {
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath,
        [Parameter(Mandatory=$true)]
        [string]$NewName
    )
    
    $NewFilePath = Join-Path (Split-Path -Parent $FilePath) $NewName
    Rename-Item -Path $FilePath -NewName $NewName -Force
    Write-Host "File renamed from: $FilePath to: $NewFilePath"
    Read-Host "Press Enter to continue..."
}

function Compress-Folder {
    param (
        [Parameter(Mandatory=$true)]
        [string]$FolderPath
    )
    
    $ZipFilePath = $FolderPath + ".zip"
    Compress-Archive -Path $FolderPath -DestinationPath $ZipFilePath
    Write-Host "Folder compressed to: $ZipFilePath"
    Read-Host "Press Enter to continue..."
}

function Decompress-Folder {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ZipFilePath
    )
    
    $DestinationPath = Split-Path -Parent $ZipFilePath
    Expand-Archive -Path $ZipFilePath -DestinationPath $DestinationPath
    Write-Host "Folder decompressed to: $DestinationPath"
    Read-Host "Press Enter to continue..."
}

$exit = $false
do {
    Show-Menu
    $choice = Read-Host "Enter your choice"
    switch ($choice) {
        "1" { 
            $parentFolderPath = Read-Host "Enter the parent folder path"
            $folderName = Read-Host "Enter the new folder name"
            New-Folder -ParentFolderPath $parentFolderPath -FolderName $folderName
        }
        "2" { 
            $filePath = Read-Host "Enter the file path"
            $text = Read-Host "Enter the text"
            New-TextFile -FilePath $filePath -Text $text
        }
        "3" { 
            $sourceFolder = Read-Host "Enter the source folder path"
            $destinationFolder = Read-Host "Enter the destination folder path"
            Copy-Folder -SourceFolder $sourceFolder -DestinationFolder $destinationFolder
        }
        "4" { 
            $sourceFile = Read-Host "Enter the source file path"
            $destinationFile = Read-Host "Enter the destination file path"
            Copy-File -SourceFile $sourceFile -DestinationFile $destinationFile
        }
        "5" { 
            $folderPath = Read-Host "Enter the folder path to delete"
            Delete-Folder -FolderPath $folderPath
        }
        "6" { 
            $filePath = Read-Host "Enter the file path to delete"
            Delete-File -FilePath $filePath
        }
        "7" { 
            $sourceFolder = Read-Host "Enter the source folder path"
            $destinationFolder = Read-Host "Enter the destination folder path"
            Move-Folder -SourceFolder $sourceFolder -DestinationFolder $destinationFolder
        }
        "8" { 
            $sourceFile = Read-Host "Enter the source file path"
            $destinationFolder = Read-Host "Enter the destination folder path"
            Move-File -SourceFile $sourceFile -DestinationFolder $destinationFolder
        }
        "9" { 
            $folderPath = Read-Host "Enter the folder path"
            $newName = Read-Host "Enter the new folder name"
            Rename-Folder -FolderPath $folderPath -NewName $newName
        }
        "10" { 
            $filePath = Read-Host "Enter the file path"
            $newName = Read-Host "Enter the new file name"
            $extension = [System.IO.Path]::GetExtension($filePath)  
            $fullName = "$newName$extension"
            Rename-File -FilePath $filePath -NewName $fullName
        }
        "11" { 
            $folderPath = Read-Host "Enter the folder path to compress"
            Compress-Folder -FolderPath $folderPath
        }
        "12" { 
            $zipFilePath = Read-Host "Enter the zip file path to decompress"
            Decompress-Folder -ZipFilePath $zipFilePath
        }
        "Q" { 
            $exit = $true
        }
        default {
            Write-Host "Invalid choice"
        }
    }
} until ($exit)