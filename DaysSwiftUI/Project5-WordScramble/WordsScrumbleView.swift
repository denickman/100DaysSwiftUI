//
//  WordsScrumbleView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/19/21.
//

import SwiftUI

struct WordsScrumbleView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word",
                          text: $newWord,
                          onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
            }
        }
        .navigationBarTitle(rootWord)
        .onAppear(perform: {
            startGame()
        })
        .alert(isPresented: $showingError, content: {
            Alert.init(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OKE")))
        })
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can`t just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn`t a real word")
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"), let startWords = try? String(contentsOf: startWordsURL) {
                let allWorlds = startWords.components(separatedBy: "\n")
                rootWord = allWorlds.randomElement() ?? "silkworm"
                return
            }
        
        fatalError("Could not load start.txt from Bundle")
    }
    
    func isOriginal(word: String) -> Bool {
        // is the word original (it hasn’t been used already)
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        // is the word possible (they aren’t trying to spell “car” from “silkworm”)
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        // is the word real (it’s an actual English word)
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspellRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspellRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct WordsScrumbleView_Previews: PreviewProvider {
    static var previews: some View {
        WordsScrumbleView()
    }
}
