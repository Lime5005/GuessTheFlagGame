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
    @State private var correct = false
    @State private var selectedNumber = 0
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
                        withAnimation {
                            self.flagTapped(number)
                        }
                    }) {
                        FlagImage(text: self.countries[number])
                    }
                    .rotation3DEffect(.degrees(self.correct && selectedNumber == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
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
        selectedNumber = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            triedScore += 1
            correct = true
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
            triedScore -= 1
            correct = false
        }
        // DispatchQueue makes the alert appears later than the animation: showScore is later, so the alert is later
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            showScore = true
        }
        totalTried += 1
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        correct = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
