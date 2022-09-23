import strutils,
       random

randomize()

let chars: seq[string]

for char in AllChars:
  chars.add(char.string())

sample(chars)
