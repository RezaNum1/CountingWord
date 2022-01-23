import Foundation

func filteringContent(url: String) -> String {
  var fullString = ""
  let avoidedString = ["<p>", "</p>", "<em>", "</em>", "â€", "<strong>", "</strong>", "œ"]
  
  guard let url = URL(string: url) else { return "" }
  
  do {
    let contents = try String(contentsOf: url)
    
    let contentsArr = contents.components(separatedBy: "<p>")
    
    for i in 1...12 {
      if contentsArr[i].contains("<div") {
        fullString += contentsArr[i].components(separatedBy: "<div")[0]
      } else {
        fullString += contentsArr[i]
      }
    }
    

    for i in avoidedString {
      fullString = fullString.replacingOccurrences(of: i, with: "")
    }
    
    fullString = fullString.replacingOccurrences(of: "[^A-Za-z]", with: "", options: .regularExpression, range: nil).uppercased()
  } catch {
    print(error)
  }
  
  return fullString
}

func countingLetters() {
  let letters = filteringContent(url: "https://klasika.kompas.id/baca/inspiraksi-kemilau-perayaan-hut-ke-50-kompas/")
  let counts = letters.reduce(into: [:]) { counts, letter in counts[letter, default: 0] += 1}
  let sorted = counts.sorted(by: { $0.key < $1.key })
  for i in sorted {
    print("\(i.key): \(i.value)")
  }
}

countingLetters()
