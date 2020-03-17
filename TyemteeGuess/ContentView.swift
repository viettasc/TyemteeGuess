//
//  ContentView.swift
//  TyemteeGuess
//
//  Created by Viettasc on 2/12/20.
//  Copyright © 2020 Viettasc. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["tyemtee1", "tyemtee2", "tyemtee3", "tyemtee4", "tyemtee5", "tyemtee6"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...5)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    func tap(_ number: Int) -> Void {
        scoreTitle = number == correctAnswer ? "Correct" : "Wrong"
        showingScore = true
        if scoreTitle == "Correct" {
            score += 1
        }
    }
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.75), Color.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0...5, id: \.self) { number in
                    Button(action: {
                        print("number: \(number)")
                        self.tap(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue"), action: {
                self.question()
            }))
        }
        .onAppear {
            print("correctAnswer: \(self.correctAnswer)")
        }
    }
    func question() -> Void {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...5)
        print("correctAnswer: ", correctAnswer)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
