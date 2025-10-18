# Script to create project archive
$projectPath = "D:\Downloads\Obninsk-spectral-index-research-main\Obninsk-spectral-index-research-main"
$outputPath = "D:\Downloads\AgroSky_AI_Agronomist_FULL.zip"

Write-Host "Creating archive..." -ForegroundColor Green
Write-Host "Source: $projectPath"
Write-Host "Output: $outputPath"

# Remove old archive if exists
if (Test-Path $outputPath) {
    Remove-Item $outputPath -Force
}

# Create archive
Compress-Archive -Path "$projectPath\*" -DestinationPath $outputPath -CompressionLevel Optimal -Force

# Show result
if (Test-Path $outputPath) {
    $file = Get-Item $outputPath
    $sizeMB = [math]::Round($file.Length / 1MB, 2)
    Write-Host "Archive created successfully!" -ForegroundColor Green
    Write-Host "Size: $sizeMB MB"
    Write-Host "Location: $($file.FullName)"
} else {
    Write-Host "Archive creation failed!" -ForegroundColor Red
}

