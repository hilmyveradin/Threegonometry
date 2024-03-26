//
//  WaveView.swift
//  Trigonometry
//
//  Created by Hilmy Veradin on 17/02/24.
//

import SwiftUI
import Charts

struct SineWavePoint: Identifiable {
    let id = UUID()
    let xValue: Double
    let yValue: Double
}

struct WaveView: View {
    @State private var isGraphGenerated: Bool = false
    @State private var tempAmplitude: String = ""
    @State private var tempFrequency: String = ""
    @State private var tempPhaseShift: String = ""

    @State private var amplitude: Double = 2
    @State private var frequency: Double = 1
    @State private var phaseShift: Double = 1
    
    @State private var dataPoints: [SineWavePoint] = []
    
    @State private var equationString: String = ""
    
    @State private var showOverlay: Bool = true
    
    @State private var showButton = false
    @State private var showEquation = false
    @State private var showGraph = false
    
    var body: some View {
        ZStack {
            Image("main-background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.1)
            
            VStack(alignment: .center, spacing: 40) {
                Text("Let's make a sine graph!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                VStack {
                    Text("What's your desired amplitude?")
                    TextField("1", text:  $tempAmplitude)
                        .padding()
                        .frame(height: 50)
                        .frame(width: 100)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .padding(.horizontal, 20)

                    Text("What's your desired frequency?")
                    TextField("1", text: $tempFrequency)
                        .padding()
                        .frame(height: 50)
                        .frame(width: 100)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .padding(.horizontal, 20)
                    Text("What's your desired phase shift? (in Pi)")
                    TextField("1", text: $tempPhaseShift)
                        .padding()
                        .frame(height: 50)
                        .frame(width: 100)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .padding(.horizontal, 20)
                }
                Button(isGraphGenerated ? "Regenerate Graph" : "Generate Graph") {
                    isGraphGenerated = true
                    amplitude = Double(tempAmplitude) ?? 1
                    frequency = Double(tempFrequency) ?? 1
                    phaseShift = Double(tempPhaseShift) ?? 1
                    updateEquationString()
                    generateGraph()
                    
                    withAnimation(Animation.easeIn(duration: 1)) {
                            showEquation = true
                        }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(Animation.easeIn(duration: 1)) {
                                showGraph = true
                            }
                        }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation(Animation.easeIn(duration: 1)) {
                                showButton = true
                            }
                        }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 50)
                .foregroundStyle(.white)
                .background(
                    .black
                    )
                .clipShape(.capsule)
                .fontWeight(.bold)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                
                if isGraphGenerated {
                    VStack(spacing:4) {
                        Text("Your final equation: ")
                            .font(.title2)
                        Text(equationString)
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .opacity(showEquation ? 1 : 0)

                    VStack {
                        Text("Graph Result here! (you can swipe left to see the complete graph!)")
                            .font(.title3)
                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                        
                        ScrollView(.horizontal) {
                            VStack(alignment: .center) {
                            Chart(dataPoints) { point in
                                LineMark(
                                    x: .value("X", point.xValue),
                                    y: .value("Sine", point.yValue)
                                )
                            }
                            .chartYScale(domain: -amplitude...amplitude)
                            .padding(20)
                            .frame(width: 1500, height: 200)
                            }.padding(10)
                        }
                        .border(Color.gray.opacity(0.5))
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(20)
                    }.opacity(showGraph ? 1 : 0)
                    NavigationLink(destination: ClosingView()) {
                        Text("Okay, I'm done 🙂")
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
            .padding(10)
            .onAppear {
                updateEquationString()
                generateGraph()
            }
            
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
                        
                        Text("Trigonometric Graph")
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .fontWeight(.bold)
                            .layoutPriority(1)
                        
                        Text("""
                             Trigonometric functions can be described with many forms, one of the most useful representation is through graph

                             These graphs are a powerful way to depict and solve real-world problems with repeating patterns. Think of how you pedal a bicycle – that up-and-down motion can be perfectly captured using a sine graph!

                             The sine graph, one of the simplest yet most illustrative trigonometric graphs, helps us understand three key concepts: amplitude, frequency, and phase shift.
                             
                             1. Amplitude tells us how far up or how far down the graph goes, like the height of your pedal from the ground at its highest and lowest points.
                             2. Frequency shows how often the cycle repeats in a given period, similar to how many times you complete a pedal cycle on your bike in a second.
                             3. Phase Shift indicates the starting point of the cycle, or in biking terms, where your foot starts on the pedal.

                             """)
                        .layoutPriority(1)
                        
                        Text("Take a look at this equation and sine graph representation examples:")
                        
                        Image("wave-graph-equation")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 200)
                        
                        Image("wave-graph-examples")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 400)
                            
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
                    .padding(20)
                }
                .ignoresSafeArea(.container)
                .padding(50)
                
            }
            .opacity(showOverlay ? 1 : 0)
        }.navigationBarBackButtonHidden(true)

    }
    

    private func generateGraph() {
        let range = 0..<1000
        let step = 0.1
        
        dataPoints = range.map { i in
            let xValue = Double(i) * step
            let yValue = amplitude * sin(frequency * xValue + phaseShift)
            return SineWavePoint(xValue: xValue, yValue: yValue)
        }
    }
    
    private func calculateXOffset(forValue value: Double, totalWidth: CGFloat) -> CGFloat {
        let graphMinX = 0.0
        let graphMaxX = 1 * Double.pi
        let graphWidth = graphMaxX - graphMinX
        
        
        let position = (value - graphMinX) / graphWidth
        
        
        return position * totalWidth
    }
    
        private func updateEquationString() {
            let formattedPhaseShift = String(format: "%.2f", phaseShift)
            equationString = "\(amplitude) sin(\(frequency)x \(phaseShift > 0 ? "+" : "") \(formattedPhaseShift)π)"
        }
}

#Preview {
    WaveView()
}
