# Large Razor String Literals Issue

Investigation related to [dotnet/aspnetcore#21787 Error CS8103 Combined length of user strings used by the program exceeds allowed limit. Try to decrease use of string literals.
](https://github.com/dotnet/aspnetcore/issues/21787)

## Pre-reqs

- .NET 7.0.100-rc.1.* SDK (download from [the installer repo](https://github.com/dotnet/installer))

## To reproduce issue

In repo root:

1. Run script `Generate-Pages.ps1`
1. Run `dotnet build`



## Experimental workaround using C# 11 Utf8 string literals

This repro includes an experiment using C# 11 Utf8 string literals to workaround the literal limit by using a [custom Razor page base class](LargeRazorStringLiterals/Pages/Generated/Utf8LiteralPageBase.cs) that includes a method `WriteUtf8Literal(ReadOnlySpan<byte> buffer)` that can be used to write literals out from their Utf8 byte literals rather than string literals. Updating the Razor compiler to support this natively for all literals might have a number of advantages.

1. Run script `Delete-Pages.ps1` in repo root
1. Uncomment lines **5** and **7** in `LargeRazorStringLiterals/Pages/Generated/PageTemplate.cshtml` around the template placeholder:\

    ```html
    5  @WriteUtf8Literal(@"
    6  ***CONTENT HERE***
    7  "u8);
    ```

1. Run script `Generate-Pages.ps1` in repo root
1. Run `dotnet build` in repo root

