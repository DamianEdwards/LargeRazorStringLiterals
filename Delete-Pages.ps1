$pagesDir = (Join-Path "." "LargeRazorStringLiterals" "Pages" "Generated");

Get-ChildItem -Path $pagesDir `
    -Include Page*.cshtml, Page*.cshtml.cs -Recurse `
    -Exclude PageTemplate.cshtml,PageTemplate.cshtml.cs | Remove-Item -Force;