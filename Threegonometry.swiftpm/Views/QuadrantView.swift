//
//  ContentView.swift
//  Trigonometry
//
//  Created by Hilmy Veradin on 16/02/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct DraggableItem: Hashable, Identifiable {
    let image: String
    let id: String
    var quadrant: String? = nil
}

struct DraggableRectangle: View {
    let item: DraggableItem

    var body: some View {
        Image(item.image)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: 200)
            .border(Color.black)
            .onDrag {
                return NSItemProvider(object: item.id as NSString)
            }
    }
}


struct QuadrantView: View {
    @State private var items = [
        DraggableItem(image: "quadrant-4", id: "IV"),
        DraggableItem(image: "quadrant-2", id: "II"),
        DraggableItem(image: "quadrant-1", id: "I"),
        DraggableItem(image: "quadrant-3", id: "III")
    ]
    
    @State private var showOverlay = true
    
    @State private var showTitle = false
    @State private var showDescription = false
    @State private var showButton = false
    
    private var allItemsPlaced: Bool {
        !items.contains { $0.quadrant == nil }
    }
    
    var body: some View {
        ZStack {
            Image("main-background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.1)
            
            GeometryReader { geometry in
                VStack (alignment: .center, spacing: 40){
                    VStack(spacing: 10) {
                        Text("Let's put the triangles into it's correct quadrant!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 60)
                        Text("Hold, drag and drop the triangles to it's correct quadrant! (Make sure you see the green indicator while holding the options)")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 60)
                    }.padding(.horizontal, 20)

                    VStack(spacing:30) {
                        VStack(spacing:10) {
                            HStack(spacing:10) {
                                QuadrantSectionView(quadrant: "II", items: $items, size: geometry.size)
                                QuadrantSectionView(quadrant: "I", items: $items, size: geometry.size)
                            }
                            HStack(spacing:10) {
                                QuadrantSectionView(quadrant: "III", items: $items, size: geometry.size)
                                QuadrantSectionView(quadrant: "IV", items: $items, size: geometry.size)
                            }
                        }

                        HStack(spacing:20) {
                            Spacer()
                            ForEach(items.filter { $0.quadrant == nil }, id: \.self) { item in
                                DraggableRectangle(item: item)
                            }
                            Spacer()
                        }.padding(.horizontal, 60)
                    }.padding(10)
                    if allItemsPlaced {
                        VStack(spacing:20) {
                            Text("Congratulations! You have put the right triangles to it's quadrant!")
                                .font(.title2)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 60)
                                .opacity(showTitle ? 1 : 0)
                            Text("Let's move on to the last game, shall we?")
                                .font(.title3)
                                .opacity(showDescription ? 1 : 0)
                            NavigationLink(destination: WaveView()) {
                                Text("Sure, lets goo! 💨")
                                    .padding(.vertical, 20)
                                    .padding(.horizontal, 50)
                                    .foregroundColor(.white)
                                    .background(Color.black)
                                    .clipShape(Capsule())
                                    .fontWeight(.bold)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            }
                            .opacity(showButton ? 1 : 0)
                        }.padding(.bottom, 40)
                            .onAppear(perform: {
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
                            })

                    }
                }
                
            }.padding(.top, 50)
            
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
                        
                        Text("Quadrants in Cartesian Coordinate System")
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .fontWeight(.bold)
                        
                        Text("""
                             The Cartesian coordinate system is essential to trigonometric functions. It can be used to find the corresponding values of other trigonometric functions at different degrees!
                             
                             To start, we should understand the quadrants of the coordinate system.
                             
                             A quadrant is essentially a section that divides the Cartesian coordinate system based on the positive and negative values of the x and y axes.
                             
                             1. The first quadrant has positive values of the x-axis and y-axis. (+X, +Y)
                             2. The second quadrant has negative values of the x-axis and positive values of the y-axis. (-X, +Y)
                             3. The third quadrant has negative values of the x-axis and y-axis. (-X, -Y)
                             4. The fourth quadrant has positive values of the x-axis and negative values of the y-axis. (+X, -Y)
                             """)
                        
                        Text("Take a look at this coordinates!")
                        
                        Image("cartesian-coordinate")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 300)
                            
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

struct QuadrantSectionView: View {
    var quadrant: String
    @Binding var items: [DraggableItem]
    var size: CGSize
    @State private var borderColor: Color = .gray
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .stroke(borderColor, lineWidth: 3)
                    .background(
                        Image("quadrant-background")
                            
                            .resizable()
                            .padding(.vertical, 40)
                            .padding(.horizontal, 10)
                            .scaledToFill()
                    )
                    .frame(width: size.width / 3, height: size.height / 4)
                    .onDrop(of: [UTType.plainText.identifier], isTargeted: nil) { providers in
                        providers.first?.loadObject(ofClass: NSString.self) { (nsString, error) in
                            DispatchQueue.main.async {
                                if let nsString = nsString as? NSString {
                                    let itemId = nsString as String
                                    if let index = items.firstIndex(where: { $0.id == itemId }) {
                                        let isDropAllowed = self.isDropAllowed(itemId: itemId, quadrant: self.quadrant)
                                        
                                        self.borderColor = isDropAllowed ? .green : .red
                                        
                                        if isDropAllowed {
                                            items[index].quadrant = self.quadrant
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            self.borderColor = .gray
                                        }
                                    }
                                }
                            }
                        }
                        return true
                    }
                Text(quadrant)
                    .font(.title)
                ForEach(items.filter { $0.quadrant == quadrant }, id: \.self) { item in
                    DraggableRectangle(item: item)
                        .padding(20)
                }
            }
        }
    }
    
    private func isDropAllowed(itemId: String, quadrant: String) -> Bool {
        if itemId == quadrant {
            return true
        } else {
            return false
        }
    }
}

#Preview {
    QuadrantView()
}
