//
//  ContentView.swift
//  GuessFlag
//
//  Created by Liping Mechling on 23/12/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["France", "UK", "Italy", "US", "Ireland", "Russia"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showScore = false
    @State private var scoreTitle = ""
    @State private var triedScore = 0
    @State private var totalTried = 0
    
    struct FlagImage: View {
        var text: String
        var body: some View {
            Image(text)
                .renderingMode(.original)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.gray, lineWidth: 1))
                .shadow(color: .gray, radius: 3)
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .green]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(text: self.countries[number])
                    }
                }
                Section {
                    Text("You have correct answers: \(triedScore)/\(totalTried)")
                }
                Spacer()
            }
        }
        .alert(isPresented: $showScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(triedScore)/\(totalTried)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            triedScore += 1
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
            triedScore -= 1
        }
        
        showScore = true
        totalTried += 1
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
