#!/bin/bash

# https://www.piano42.com/blog/pandoc-md-to-pdf/
# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ $# != 2 ]; then
    echo "Usage: md2pdf.sh <input>.md <output>.pdf"
fi

if ! command -v pandoc > /dev/null; then
    echo "pandoc not found, install with apt install pandoc"
    exit 1
fi

# if ! command -v wkhtmltopdf > /dev/null; then
#     echo "wkhtmltopdf not found, install with apt install wkhtmltopdf"
#     exit 1
# fi

# pandoc $1 -o $2 -t html5 -V margin-left=1 -V margin-right=1 -V margin-top=5 -V margin-bottom=5 -s --pdf-engine=wkhtmltopdf

if ! command -v weasyprint > /dev/null; then
    echo "weasyprint not found, install with apt install weasyprint"
    exit 1
fi
if ! command -v pango-view > /dev/null; then
    echo "pango-view not found, install with apt install pango-view"
    exit 1
fi

pandoc $1 -o $2 --pdf-engine=weasyprint
