import strutils,
       random,
       termui,
       sequtils,
       tables

const numbers = @["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
const symbols = @["!", "@", "#", "$", "%", "^", "&", "*"]
const upcase = @["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
const downcase = @["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

randomize()

proc genPasswd(sym, up, nums: bool, length: int): string =
  var allowedChars = downcase
  if sym:
    allowedChars = concat(allowedChars, symbols)
  if nums:
    allowedChars = concat(allowedChars, numbers)
  if up:
    allowedChars = concat(allowedChars, upcase)
  var passwd: seq[string]
  for i in 1..length:
    passwd.add(allowedChars.sample)
  return passwd.join("")
  
let strOpts = termuiSelectMultiple("Select options", @["Uppercase Letters", "Symbols", "Numbers"])
let l = termuiAsk("How long do you want your password? ", defaultValue = "8")
let spinner = termuiSpinner("Generating password...")
var opts = newTable[string, bool]()

if "Uppercase Letters" in strOpts:
  opts["up"] = true
else:
  opts["up"] = false
  
if "Symbols" in strOpts:
  opts["sym"] = true
else:
  opts["sym"] = false
    
if "Numbers" in strOpts:
  opts["nums"] = true
else:
  opts["nums"] = false

let passwd = genPasswd(opts["sym"], opts["up"], opts["nums"], l.parseInt())
spinner.complete("Done")
termuiLabel("Password", passwd) 
