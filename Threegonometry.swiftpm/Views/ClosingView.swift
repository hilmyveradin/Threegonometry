//
//  ClosingView.swift
//  
//
//  Created by Hilmy Veradin on 18/02/24.
//

import SwiftUI

struct ClosingView: View {
    @State private var showTitle = false
    @State private var showDescription = false
    
    var body: some View {

        ZStack {
            Image("main-background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.1)
            
            VStack(spacing:40) {
                Text("Thank You for Playing!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .opacity(showTitle ? 1: 0)
                
                Text("""
                     And that's a wrap!!!
                     
                     Congratulations, you've learned three interesting things about essential trigonometric functions, Cartesian quadrants, and trigonometric graph representation!
                     
                     I hope you learned many things, and more importantly, had fun learning math.
                     
                     This playground is inspired after I taught my little brother high school trigonometry. We had a great time, and hopefully, you did too 😊
                     
                     Attribution:
                     Music by Bensound.com, License code: 7UKJ5SWVJXBVFYHJ
                     """)
                .opacity(showDescription ? 1: 0)
                
            }
            .padding(.horizontal, 80)
        }
        .onAppear(perform: {
            withAnimation(Animation.easeIn(duration: 1)) {
                    showTitle = true
                }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(Animation.easeIn(duration: 1)) {
                        showDescription = true
                    }
                }
        }).navigationBarBackButtonHidden(true)

        
    }
}

#Preview {
    ClosingView()
}
