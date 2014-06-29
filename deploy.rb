#! /usr/bin/ruby
require 'httparty'

pads = ["faireswebsite"]
layout = <<EOF
<html>
<head>
<title>Faire's Web Site</title>
<meta name="author" content="Faire Soule-Reeves">

<link rel="me" href="https://github.com/FaireBear">
<link rel="me" href="https://www.beeminder.com/faire">
<link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="/css/faireness.css" type="text/css">
<link rel="shortcut icon" href="/favicon.ico" type="image/ico">

</head>
<body>
<div class="container">
%s
</div>
</body>
</html>
EOF


pads.each { |p|
  resp = HTTParty.get("http://expost.padm.us/#{p}?htmlwrap=0") 
  page = layout % resp.parsed_response

  outname = pads.index(p) == 0 ? "index" : p
  File.open("outfiles/#{outname}.html",'w') {|f| f.puts page }
}

`scp -r outfiles/* faire@yootles.com:/var/www/html/faire/`
