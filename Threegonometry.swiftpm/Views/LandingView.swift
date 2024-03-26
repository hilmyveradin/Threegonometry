//
//  LandingView.swift
//  Trigonometry
//
//  Created by Hilmy Veradin on 16/02/24.
//

import SwiftUI
import AVFoundation

struct LandingView: View {
    @State private var audioPlayer: AVAudioPlayer?
    
    @State private var showTitle = false
    @State private var showImage = false
    @State private var showButton = false
    
    var body: some View {
        ZStack {
            Image("main-background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.1)
            
            VStack(spacing:100){
                VStack(spacing:10) {
                    Text("Three-gonometry")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Learn trigonometry with three awesome mini-games!")
                        .font(.title3)
                }.opacity(showTitle ? 1 : 0)

                
                Image("landing-image")
                    .resizable()
                    .scaledToFit()
                    .frame(width:400)
                    .opacity(showImage ? 1 : 0)

                NavigationLink(destination: QuizIntroView()) {
                    Text("Let's get Started! 😁")
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
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            playMusic()
            withAnimation(Animation.easeIn(duration: 1)) {
                    showTitle = true
                }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(Animation.easeIn(duration: 1)) {
                        showImage = true
                    }
                }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation(Animation.easeIn(duration: 1)) {
                        showButton = true
                    }
                }
        })

    }
    
    private func playMusic() {
        guard let url = Bundle.main.path(forResource: "creativeminds.mp3", ofType: nil) else {
            print("Music file not found")
            return
        }
        let musicUrl = URL(fileURLWithPath: url)

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            audioPlayer = try AVAudioPlayer(contentsOf: musicUrl)
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
            audioPlayer?.volume = 0.2
            audioPlayer?.play()
        } catch {
            print("Error in playing music: \(error.localizedDescription)")
        }
    }
}

#Preview {
    LandingView()
}
