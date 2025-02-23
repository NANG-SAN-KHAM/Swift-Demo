//
//  StylusView.swift
//  Demo
//
//  Created by NANG SAN KHAM on 2/18/25.
//

import SwiftUI

/// 唱针 (直接接触唱片沟槽的细小针尖，通常由钻石或其他硬质材料制成。)
struct StylusView: View {
    
    
    var size: CGSize
    var color: Color
    
    init(size: CGSize = CGSize(width: 50, height: 250), color: Color = Color(hex: "#565662")) {
        self.size = size
        self.color = color
    }
    
    var body: some View {
        ZStack {
            // Shadow layer
            Rectangle()
                .fill(color)
                .frame(width: size.width * 0.24, height: size.height * 0.012)
                .offset(x: size.width * 0.3, y: size.height * 0.012)
                .shadow(color: .black.opacity(0.4), radius: 3, x: 3, y: 5)
            
            // Needle body
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white)
                    .frame(width: size.width * 0.36, height: size.height * 0.1)
                
                // Cantilever detail
                Circle()
                    .stroke(.gray, lineWidth: 0.5)
                    .frame(width: size.width * 0.2, height: size.height * 0.04)
                    .offset(y: 3)
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 5)
            }
        }
        .rotationEffect(.degrees(size.width * 0.3))
        .offset(x: -1 * (size.width * 0.2), y: size.height * 0.92)
        .shadow(color: .black.opacity(0.4), radius: 3, x: 3, y: 5)
    }
}
