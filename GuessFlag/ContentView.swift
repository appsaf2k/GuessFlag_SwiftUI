//
//  ContentView.swift
//  GuessFlag
//
//  Created by @andreev2k on 27.08.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [.black, .red, .orange, .black], center: .topLeading, startRadius: 60, endRadius: 200)
            
            VStack {
                Spacer()
                Spacer()
                Text("Выбери флаг")
                    .foregroundStyle(.white)
                    .font(.title2.bold())
                    .padding()
                VStack(spacing: 20) {
                    
                    VStack {
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.title.bold())
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                .alert(scoreTitle, isPresented: $showingScore) {
                    if score == 10 || score == 20 || score == 30 {
                        Button("Обнулить", action: reset)
                    }
                    Button("Продолжить", action: askQuestion)
                } message: {
                    if score == 10 || score == 20 || score == 30{
                        Text("Ты выиграл, твой счет: \(score)")
                    } else {
                    Text("Твой счет: \(score)")
                    }
                }
                Spacer()
                Text("Счет: \(score)")
                    .foregroundStyle(.white)
                    .font(.title)
                    .padding(.top)
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
    
    func flagTapped(_ number: Int) {
         if number == correctAnswer {
            scoreTitle = "Правильно"
             score += 1
         } else {
             scoreTitle = "Не правильно, это флаг \(countries[number])"
             if score != 0 {
                 score -= 1
             }
         }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
