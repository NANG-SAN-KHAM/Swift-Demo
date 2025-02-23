//
//  VinylRecordView.swift
//  Demo
//
//  Created by NANG SAN KHAM on 2/18/25.
//

import SwiftUI

// 黑胶唱片
struct VinylRecordView: View {
    
    @State private var isPlaying: Bool = false

    var body: some View {
        VStack {
            
            Spacer()
            
            ZStack {
                
                Color.black.opacity(0.2)
                
                // 唱盘
                HStack {
                    
                    Spacer()
                    
                    TurntableView(isPlaying: $isPlaying, width: 300, height: 300)
                    
                    Spacer()
                    
                    Spacer()
                }
                
                // 唱臂
                HStack {
                    
                    Spacer()
                    
                    TonearmView(isPlaying: $isPlaying, width: 50, height: 320)
                        .padding(.horizontal, 24)
                        .offset(x: -10, y: -70)
                }
            }
            .frame(width: 400, height: 400)
            
            // 播放/暂停按钮
            Button {
                isPlaying.toggle()
            } label: {
                Text(isPlaying ? "Stop" : "Play")
                    .padding()
                    .background(isPlaying ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .background(Color.gray)
        .ignoresSafeArea()
        
    }
}


#Preview {
    VinylRecordView()
}

//🚀 Creating a Vinyl Record Player Animation in SwiftUI 🎶
//
//
//
//I recently had the opportunity to build an interactive tonearm animation in SwiftUI, simulating the smooth, elegant motion of a vinyl record player. The goal was to create a realistic and engaging user experience, with modular components and smooth transitions. Here’s what I worked on:
//
//
//
//✅ Modular Tonearm Assembly – I broke down the tonearm into clear, reusable components like the pivot base, tonearm shape, cartridge, and stylus. This modular approach ensures clean and maintainable code that can be easily extended in the future.
//
//✅ Smooth Rotation Animation – By toggling between play and pause states, I triggered a subtle rotation effect that mimics the motion of a vinyl record player. SwiftUI's animation framework made it easy to achieve lifelike, smooth transitions.
//
//✅ Custom Shape & Realistic Shadows – To capture the organic curvature of the tonearm, I used a custom Shape with a quadratic curve. Additionally, I applied custom view modifiers to add layered shadows, creating a sense of depth and realism.
//
//✅ Precise Pivot Mechanics – Calculated the correct pivot point to ensure the tonearm's movement accurately mimics the precise mechanics of a classic vinyl player.
//
//
//
//💡 Key Challenge: Balancing a modular design with precise, natural movement was crucial for this project. The challenge was calculating the right pivot position and integrating smooth animations, all while keeping the codebase clean and maintainable.
