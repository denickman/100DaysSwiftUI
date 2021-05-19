//
//  CountriesView.swift
//  WeSplit
//
//  Created by Denis Yaremenko on 5/15/21.
//

import SwiftUI

struct FlagsView: View {
    
    @State private var countries = ["estonia", "germany", "italy", "poland", "france", "ireland"].shuffled()
    
    @State private var correctAnswerNumber = Int.random(in: 0...2)
    
    @State private var isShowingScore = false
    @State private var scoreTitle = ""
    
    @State private var currentScore = 0
    
    var body: some View {
        
        ZStack {
            //            Color.blue.edgesIgnoringSafeArea(.all)
            LinearGradient(gradient: Gradient(colors: [.green, .blue, .yellow]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            //            RadialGradient.init(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 500).edgesIgnoringSafeArea(.all)
            
            //            AngularGradient.init(gradient: Gradient.init(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the country")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                    
                    Text(countries[correctAnswerNumber].uppercased())
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    Text("Current score: \(currentScore)")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
                
                ForEach(0 ..< countries.count) { number in
                    Button(action: {
                        // flag was tapped
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            //                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 128.0, height: 72.0, alignment: .center)
                            .clipShape(Capsule())
                            .overlay(Capsule()
                                        .stroke(
                                            Color.orange,
                                            lineWidth: 1))
                            .shadow(color: .green, radius: 10)
                    }
                }
                
                Spacer()
            }
        }
        .alert(isPresented: $isShowingScore, content: {
            Alert(title: Text(scoreTitle),
                  message: Text("Your score is \(currentScore)"),
                  dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                  })
        })
    }
    
    func flagTapped(_ number: Int) {
        let isCorrectAnswer = number == correctAnswerNumber
        
        scoreTitle = isCorrectAnswer ? "Correct answer \(countries[correctAnswerNumber].uppercased())" :
            "Wrong, this is a \(countries[number].uppercased())"
        
        currentScore += isCorrectAnswer ? 1 : -1
        isShowingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswerNumber = Int.random(in: 0...countries.count-1)
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        FlagsView()
    }
}
