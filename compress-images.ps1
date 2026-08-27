Add-Type -AssemblyName System.Drawing

$imagePath = 'c:\Users\LENOVO\Documents\OrivoxPortfolio\images'
$files = Get-ChildItem $imagePath -Include *.png, *.jpg

Write-Host "Compression en cours..."

foreach ($file in $files) {
    try {
        $img = [System.Drawing.Image]::FromFile($file.FullName)
        $newWidth = [int]($img.Width * 0.6)
        $newHeight = [int]($img.Height * 0.6)
        
        $newImg = New-Object System.Drawing.Bitmap($newWidth, $newHeight)
        $graphics = [System.Drawing.Graphics]::FromImage($newImg)
        $graphics.DrawImage($img, 0, 0, $newWidth, $newHeight)
        
        $quality = New-Object System.Drawing.Imaging.EncoderParameters(1)
        $quality.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, 75)
        
        $jpegCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' } | Select-Object -First 1
        
        $newImg.Save($file.FullName, $jpegCodec, $quality)
        $newImg.Dispose()
        $graphics.Dispose()
        $img.Dispose()
    } catch {
        Write-Host "Erreur: $($file.Name)"
    }
}

Write-Host "Compression terminee!"
Get-ChildItem $imagePath -Include *.png, *.jpg | Sort-Object -Property Length -Descending | Select-Object Name, @{Name="Size(MB)";Expression={[math]::Round($_.Length/1MB,2)}} | Select-Object -First 5
