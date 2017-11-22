import Foundation

let transformations = [
    "\\": "back_slash",
    "/": "forward_slash",
    "+": "plus",
    "=": "equals",
    " ": "space",
    "(": "paren_left",
    ")": "paren_right",
    ":": "colon",
    ",": "comma",
    ".": "dot"
]

public func obfuscate(_ str: String) -> String {
    return str.characters.reduce("Obfuscated") {
        guard let transformation = transformations[String($1)] else {
            switch $1 {
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                return $0 + "._\($1)"
            default:
                return $0 + ".\($1)"
            }
        }
        return $0 + "." + transformation
    }
}
