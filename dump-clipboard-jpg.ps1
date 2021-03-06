Add-Type -Assembly PresentationCore
$img = [Windows.Clipboard]::GetImage()
if ($img -eq $null) {
    Write-Host "Kein Bild in der ZA gefunden."
    Exit
}
Write-Host ("Bild gefunden. {0}x{1} Pixel." -f $img.PixelWidth,$img.PixelHeight)

$stream = [IO.File]::Open(("Clipboard-{0}.jpg" -f ((Get-Date -f s) -replace '[-T:]','')), "OpenOrCreate")
$encoder = New-Object Windows.Media.Imaging.JpegBitmapEncoder
$encoder.QualityLevel = 80
$encoder.Frames.Add([Windows.Media.Imaging.BitmapFrame]::Create($img))
$encoder.Save($stream)
$stream.Dispose()