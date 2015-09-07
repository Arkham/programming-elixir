dqs = "∂x/∂y"
# "∂x/∂y"
String.length dqs
# 5
byte_size dqs
# 9
String.at(dqs, 0)
# "∂"
String.codepoints(dqs)
# ["∂", "x", "/", "∂", "y"]
String.split(dqs, "/")
# ["∂x", "∂y"]
String.at("∂og", 0)
# "∂"
String.capitalize("è")
# "È"
String.capitalize("ècole")
# "Ècole"
String.codepoints("Josè's ∂øg")
# ["J", "o", "s", "è", "'", "s", " ", "∂", "ø", "g"]
String.downcase("ØRStedD")
# "ørstedd"
String.duplicate("Ho! ", 3)
# "Ho! Ho! Ho! "
String.ends_with? "string", ~w{ elix stri ring }
# true
String.first("∂og")
# "∂"
String.graphemes("∂og")
# ["∂", "o", "g"]
String.codepoints("∂og")
# ["∂", "o", "g"]
