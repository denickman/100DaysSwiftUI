//
//  WorldScrumbleView.swift
//  100DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/19/21.
//

import SwiftUI

struct WordsView: View {
    
    let people = ["Alex", "Victor", "Vasyl", "Roman", "Den"]
    
    var body: some View {
        
//        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt"),
//           let fileContent = try?
//                String(contentsOf: fileURL) {
//                // we loaded file into the string
//        }
        
//        let input = """
//                        a
//                        b
//                        c
//                        """
//
//        let letters = input.components(separatedBy: "\n")
//        let letter = letters.randomElement()
//        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let word = "swift"
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        let allGood = misspelledRange.location == NSNotFound

        
        List(0..<5) {
            Text("Dynamic row \($0)")
        }
        .listStyle(GroupedListStyle())
        
        List(people, id: \.self) {
            Text($0)
        }
        .listStyle(GroupedListStyle())
        
        List {
            ForEach(people, id: \.self) {
                Text($0)
            }
        }
        .listStyle(GroupedListStyle())
        
        List {
            Section(header: Text("Section 1")) {
                Text("Static row 1")
                Text("Static row 2")
                Text("Static row 3")
            }
            
            Section(header: Text("Section 2")) {
                ForEach(0..<5){
                    Text("Dynamic row \($0)")
                }
            }
            
            Section(header: Text("Section 3")) {
                Text("Static row 4")
                Text("Static row 5")
                Text("Static row 6")
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct WorldScrumbleView_Previews: PreviewProvider {
    static var previews: some View {
        WordsView()
    }
}
