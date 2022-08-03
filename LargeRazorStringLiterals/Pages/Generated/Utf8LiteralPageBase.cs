using System.Buffers;
using System.Text;
using Microsoft.AspNetCore.Html;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace LargeRazorStringLiterals.Pages.Generated;

public abstract class Utf8LiteralPage : Page
{
    protected HtmlString WriteUtf8Literal(ReadOnlySpan<byte> buffer)
    {
        var chars = ArrayPool<char>.Shared.Rent(Encoding.UTF8.GetMaxCharCount(buffer.Length));
        try
        {
            Encoding.UTF8.GetChars(buffer, chars);
            base.Output.Write(chars);
        }
        finally
        {
            ArrayPool<char>.Shared.Return(chars, clearArray: true);
        }

        return HtmlString.Empty;
    }
}
