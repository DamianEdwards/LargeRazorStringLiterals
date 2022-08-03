$pageCount = 500;
$paragraphCountMin = 20;
$paragraphCountMax = 50;

$dictionary = "Lorem ipsum dolor sit amet consectetur adipiscing elit Sed ac est semper ligula efficitur accumsan a ornare ipsum Fusce libero tortor eleifend et accumsan ut molestie quis purus Donec sagittis felis turpis non gravida est hendrerit dapibus Pellentesque eu convallis turpis Class aptent taciti sociosqu ad litora torquent per conubia nostra per inceptos himenaeos Nulla rhoncus ipsum sit amet massa faucibus condimentum Ut vitae tincidunt enim at viverra elit Aenean vitae iaculis sem Cras eu massa quis nibh vestibulum vehicula Mauris vel dolor eu mauris varius porta".Split(' ');
$dictionaryMaxIndex = $dictionary.Length - 1;

function New-Paragraph([string]$Id) {
    $sentenceCount = Get-Random -Minimum 5 -Maximum 10;

    for ($i = 0; $i -lt $sentenceCount; $i++) {
        if ($i -gt 0) { $para += "`n`r" };
        $para += "<p>$Id";
        $para += New-Sentence;
        $para += "</p>"
    }

    return $para;
}

function New-Sentence {
    $wordCount = Get-Random -Minimum 7 -Maximum 20;

    for ($i = 0; $i -lt $wordCount; $i++) {
        $wordIndex = Get-Random -Minimum 0 -Maximum $dictionaryMaxIndex;
        if ($i -gt 0) { $sentence += " " };
        $sentence += $dictionary[$wordIndex];
    }

    $sentence += ".";
    return $sentence;
}

$pagesDir = (Join-Path "." "LargeRazorStringLiterals" "Pages" "Generated");
$cshtmlContentTemplate = Get-Content -Path (Join-Path $pagesDir "PageTemplate.cshtml") -Raw;
$csContentTemplate = Get-Content -Path (Join-Path $pagesDir "PageTemplate.cshtml.cs") -Raw;

for ($i = 1; $i -le $pageCount; $i++) {
    $pageId = $i.ToString('0000');
    $pageModelName = "Page$($pageId)Model";

    Write-Host $pageModelName;

    $paragraphCount = Get-Random -Minimum $paragraphCountMin -Maximum $paragraphCountMax;
    $generatedContent = $null;
    for ($j = 0; $j -lt $paragraphCount; $j++) {
        $generatedContent += (New-Paragraph -Id $pageId);
    }
    
    $cshtmlContent = $cshtmlContentTemplate -replace 'PageTemplateModel', $pageModelName -replace '\*\*\*CONTENT HERE\*\*\*', $generatedContent;
    $csContent = $csContentTemplate -replace 'PageTemplateModel', $pageModelName;
    $cshtmlFile = (Join-Path $pagesDir "Page$pageId.cshtml");
    $csFile = (Join-Path $pagesDir "Page$pageId.cshtml.cs");

    Set-Content -Path $cshtmlFile -Value $cshtmlContent;
    Set-Content -Path $csFile -Value $csContent;
}
