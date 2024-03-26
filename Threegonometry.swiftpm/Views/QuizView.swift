//
//  QuizView.swift
//  Trigonometry
//
//  Created by Hilmy Veradin on 17/02/24.
//

import SwiftUI

struct Question {
    let text: String
    let options: [String]
    let correctAnswer: String
    let wrongAnswerPrompt: String
}

struct QuizView: View {
    let questions = [
        Question(text: "What is the value of sine α?", options: ["4/5", "3/5"], correctAnswer: "4/5", wrongAnswerPrompt: "Remember, sine is opposite divided by hypotenuse 😉"),
        Question(text: "What is the value of cosine α?", options: ["4/5", "3/5"], correctAnswer: "3/5", wrongAnswerPrompt: "Remember, cosine is adjacent divided by hypotenuse 😉"),
        Question(text: "What is the value of tangent α?", options: ["3/4", "4/3"], correctAnswer: "4/3", wrongAnswerPrompt: "Remember, tangent is opposite divided by adjacent 😉")
    ]

    @State private var showOverlay = true
    @State private var currentQuestionIndex = 0
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var isQuizFinished = false
    
    @State private var showTitle = false
    @State private var showDescription = false
    @State private var showButton = false
    
    var body: some View {
        ZStack {
            
            Image("main-background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.1)
            
                VStack(spacing: 40) {
                    if (!isQuizFinished) {
                        Text("Let's do some quiz!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Image("quiz-clue")
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 100)
                        VStack {
                            Text(questions[currentQuestionIndex].text)
                                .font(.title)
                            
                            Image("quiz-question")
                                .resizable()
                                .scaledToFit()
                                .padding(10)
                        }

                        VStack(spacing:20) {
                            ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                                Button(action: {
                                    if option == questions[currentQuestionIndex].correctAnswer {
                                        if currentQuestionIndex < questions.count - 1 {
                                            currentQuestionIndex += 1
                                        } else {
                                            isQuizFinished = true
                                            withAnimation(Animation.easeIn(duration: 1)) {
                                                    showTitle = true
                                                }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                    withAnimation(Animation.easeIn(duration: 1)) {
                                                        showDescription = true
                                                    }
                                                }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                                    withAnimation(Animation.easeIn(duration: 1)) {
                                                        showButton = true
                                                    }
                                                }
                                        }
                                    } else {
                                        alertTitle = questions[currentQuestionIndex].wrongAnswerPrompt
                                        showingAlert = true
                                    }
                                }) {
                                    Text(option)

                                }
                                .alert(isPresented: $showingAlert) {
                                    Alert(title: Text(alertTitle), dismissButton: .default(Text("OK")))
                                }                .padding(.vertical, 30)
                                    .padding(.horizontal, 80)
                                    .foregroundStyle(.white)
                                    .font(.title)
                                    .background(
                                        .black
                                        )
                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                                    .fontWeight(.bold)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            }
                        }
                        .padding(.bottom, 60)
                    } else {
                        Text("Congratulations! You have answered all the question correctly!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .opacity(showTitle ? 1 : 0)
                        Text("Let's move on to the next game, shall we?")
                            .font(.title3)
                            .opacity(showDescription ? 1 : 0)
                        NavigationLink(destination: QuadrantView()) {
                            Text("Sure, lets goo! 💨")
                                .padding(.vertical, 20)
                                .padding(.horizontal, 50)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .clipShape(Capsule())
                                .fontWeight(.bold)
                                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                        }.opacity(showButton ? 1 : 0)
                    }


                }
                .padding(.top, 50)
            
            GeometryReader { geometry in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.showOverlay.toggle()
                    }
                }) {
                    Image(systemName: "info.circle")
                        .imageScale(.large)
                }
                .position(x: geometry.size.width - 100, y: 40)
            }

        
                ZStack {
                    Color.black.opacity(0.8)
                        .transition(.opacity)
                        .animation(.easeInOut, value: showOverlay)
                        .ignoresSafeArea(.container)
                    
                    ZStack {
                        Color.white
                            .cornerRadius(10)
                            .edgesIgnoringSafeArea(.all)

                        VStack(spacing: 20) {
                            Text("Trigonometric Functions")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text("""
                                 In trigonometry, we primarily discuss the angles and sides of a triangle, which can have many applications.
                                 
                                 There are three fundamental ratios: sine, cosine, and tangent. Each one is calculated differently:
                                 
                                 1. For sine, we calculate the ratio of the side opposite the angle to the hypotenuse.
                                 
                                 2. For cosine, we calculate the ratio of the side adjacent to the angle to the hypotenuse.
                                 
                                 3. For tangent, we calculate the ratio of the side opposite the angle to the side adjacent to the angle.
                                 """)
                            
                            Text("You can remember these calculations with these!")
                            
                            Image("quiz-triangle-info")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 200)

                            Image("quiz-triangle-equation")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 100)
                                
                            Button("I Understand!") {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    self.showOverlay.toggle()
                                }
                            }
                            .padding(.vertical, 20)
                            .padding(.horizontal, 50)
                            .foregroundStyle(.white)
                            .background(.black)
                            .clipShape(Capsule())
                            .fontWeight(.bold)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                        }
                        .padding(50)
                    }
                    .ignoresSafeArea(.container)
                    .padding(50)
                    
                }
                .opacity(showOverlay ? 1 : 0)
            


        }.navigationBarBackButtonHidden(true)
    }
}


#Preview {
    QuizView()
}
