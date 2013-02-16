require 'nokogiri'

# script which will turn http://www.emoji-cheat-sheet.com/ into an osx plist

doc = Nokogiri::HTML(File.read("Emoji.html"))
out = File.open("Emoticons.plist", "w")

out.puts("<?xml version=\"1.0\" encoding=\"UTF-8\"?>")
out.puts("<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">")
out.puts("<plist version=\"1.0\">")
out.puts("<dict>")
out.puts("\t<key>AdiumSetVersion</key>")
out.puts("\t<integer>1</integer>")
out.puts("\t<key>Emoticons</key>")
out.puts("\t<dict>")

doc.xpath("//span").each do |e|
  data_src = e.attribute("data-src").to_s

  if !data_src.empty?
    out.puts("\t\t<key>#{data_src.split("/").last}</key>")
    out.puts("\t\t<dict>")
  else
    out.puts("\t\t\t<key>Equivalents</key>")
    out.puts("\t\t\t<array>")
    out.puts("\t\t\t\t<string>:#{e.content}:</string>")
    out.puts("\t\t\t</array>")
    out.puts("\t\t\t<key>Name</key>")
    out.puts("\t\t\t<string>#{e.content}</string>")
    out.puts("\t\t</dict>")
  end
end

out.puts("\t</dict>")
out.puts("\t<key>Service Class</key>")
out.puts("\t<string>Google Talk</string>")
out.puts("</dict>")
out.puts("</plist>")
out.close
