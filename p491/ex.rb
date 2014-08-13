require 'win32ole'

html = <<EOF
<html>
<head><title>OMG</title></head>
<body>
<h1 color=red>THIS FILE DOES NOT EXIST</h1>
</body>
</html>
EOF

ie = WIN32OLE.new "InternetExplorer.Application"

ie.left = 150
ie.top = 150
ie.height = 200
ie.width = 300
ie.menubar = 0
ie.toolbar = 0
ie.navigate "about:blank"

ie.visible = true

ie.document.open
ie.document.write html
ie.document.close
sleep 5
ie.quit