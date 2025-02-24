//
//  VinylRecordView.swift
//  Demo
//
//  Created by NANG SAN KHAM on 2/18/25.
//

import SwiftUI

// 黑胶唱片
struct VinylRecordView: View {
    
    @Binding var isPlaying: Bool

    var body: some View {
        VStack {
            ZStack {
                
                Color.white.opacity(0.2)
                
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
            
        }
        
    }
}


#Preview {
    VinylRecordView(isPlaying: .constant(false))
}
