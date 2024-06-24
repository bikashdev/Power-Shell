# Set-ExecutionPolicy RemoteSigned -Scope Process
# Define the source and destination paths
$sourcePaths = @(
    "C:\Users\bikash.goshai\Downloads\Latest\bin",
    "C:\users\bikash.goshai\Downloads\Latest\Views",
    "C:\users\bikash.goshai\Downloads\Latest\Areas",
   "C:\Users\bikash.goshai\Downloads\Latest\Scripts"
)
$destinationPath = "\\192.168.1.11\EduconnectFeature"

# Create the destination path if it doesn't exist
if (-not (Test-Path $destinationPath)) {
    New-Item -ItemType Directory -Path $destinationPath
}

# Copy each folder with progress bar
$totalFolders = $sourcePaths.Length
$currentFolder = 0

foreach ($sourcePath in $sourcePaths) {
    # Get the folder name from the source path
    $folderName = Split-Path $sourcePath -Leaf

    # Define the full destination path for this folder
    $fullDestinationPath = Join-Path $destinationPath $folderName

	 # Display progress bar
     $percentComplete = ($currentFolder / $totalFolders) * 100
     Write-Progress -Activity "Copying folders" -Status "Copying $folderName" -PercentComplete $percentComplete

    # Delete the existing folder if it exists
    if (Test-Path $fullDestinationPath) {
        Remove-Item -Path $fullDestinationPath -Recurse -Force
    }

    # Copy the folder
    Copy-Item -Path $sourcePath -Destination $fullDestinationPath -Recurse

# Display completion message for current folder
    Write-Host "Finished copying $folderName"
}
