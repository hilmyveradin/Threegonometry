//
//  QuizIntroView.swift
//  Trigonometry
//
//  Created by Hilmy Veradin on 17/02/24.
//

import SwiftUI

struct QuizIntroView: View {
    let introTexts =
        [
            "Hey there! Welcome to Three-gonometry! Get ready to learn trigonometry in a super fun way with three awesome mini-games.",
            "First up, we're diving into the world of trigonometric functions. Ever wonder how the angles and sides of a triangle are related? You're about to find out!",
            "Next, we'll tackle the Cartesian coordinate system, we'll look into quadrant system. Sounds fancy, right? It's all about plotting points and trigonometric functions, and it's key to getting trigonometry down.",
            "Last but not least, we're surfing the waves with sine waves in trigonometry!",
            "Ready to get started? Let's jump right in!"
        ]
    @State private var text = ""
    @State private var opacity = 0.0
    @State private var showButton = false

    var body: some View {
        ZStack {
            Image("main-background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.1)
            VStack(spacing:40) {
                Text(text)
                    .padding(.horizontal, 80)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .opacity(opacity)
                    .onAppear {
                        animateTextsSequentially(texts: introTexts, currentIndex: 0)
                    }
                
                if showButton {
                    NavigationLink(destination: QuizView()) {
                        Text("Let's go! 😁")
                            .font(.title)
                            .padding(.vertical, 20)
                            .padding(.horizontal, 50)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Capsule())
                            .fontWeight(.bold)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    }
                }
            }

        }.navigationBarBackButtonHidden(true)


        
    }
    private func animateTextsSequentially(texts: [String], currentIndex: Int) {
        guard texts.indices.contains(currentIndex) else { return }
        
        let currentText = texts[currentIndex]
        let nextIndex = currentIndex + 1

        self.text = currentText
        
        withAnimation(.easeIn(duration: 0.5)) {
            self.opacity = 1.0
            
            
            if currentIndex == texts.count - 1  {
                self.showButton = true
            }
        }


        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            
            if currentIndex != texts.count - 1 {
                withAnimation(.easeOut(duration: 0.5)) {
                    self.opacity = 0.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    animateTextsSequentially(texts: texts, currentIndex: nextIndex)
                }
            }

        }
    }
}


#Preview {
    QuizIntroView()
}
