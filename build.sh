#!/bin/sh
# Builds index.html (the GitHub Pages version) from app.html (the artifact version).
# Everything up to the first </style> goes in <head>, the rest in <body>.
cd "$(dirname "$0")"
END=$(grep -n '</style>' app.html | head -1 | cut -d: -f1)
{
  printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n<meta name="apple-mobile-web-app-capable" content="yes">\n<meta name="mobile-web-app-capable" content="yes">\n<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">\n<meta name="apple-mobile-web-app-title" content="Myth Reviewer">\n<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}[hidden]{display:none!important}</style>\n'
  head -n "$END" app.html
  printf '</head>\n<body>\n'
  tail -n +"$((END+1))" app.html
  printf '\n</body>\n</html>\n'
} > index.html
