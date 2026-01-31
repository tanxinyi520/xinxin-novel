$content = Get-Content "index.html" -Raw
$content = $content -replace 'https://picsum.photos/1200/400?random=1', 'images/carousel-1.svg'
$content = $content -replace 'https://picsum.photos/1200/400?random=2', 'images/carousel-2.svg'
$content = $content -replace 'https://picsum.photos/1200/400?random=3', 'images/carousel-3.svg'
$content = $content -replace 'https://picsum.photos/300/400?random=', 'images/novel-cover.svg'
$content = $content -replace 'https://picsum.photos/80/120?random=', 'images/novel-cover-small.svg'
$content = $content -replace 'https://picsum.photos/100/140?random=', 'images/novel-cover-small.svg'
$content = $content -replace 'https://picsum.photos/seed/novel_detail/400/600', 'images/novel-cover.svg'
Set-Content -Path "index.html" -Value $content -NoNewline