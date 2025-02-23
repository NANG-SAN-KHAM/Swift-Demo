//
//  CartridgeView.swift
//  Demo
//
//  Created by NANG SAN KHAM on 2/18/25.
//

import SwiftUI

// 唱头（安装在唱臂末端的组件，包含唱针（stylus）和换能器，用于读取唱片沟槽中的振动并将其转换为电信号。）
struct CartridgeView: View {
    
    var size: CGSize
    var color: Color
    
    init(size: CGSize = CGSize(width: 50, height: 250), color: Color = Color(hex: "#565662")) {
        self.size = size
        self.color = color
    }
    
    
    private var scaleSize: CGSize {
        let scaleWidth: CGFloat = size.width * 0.6
        let sacleHeight: CGFloat = size.height * 0.048
        return CGSize(width: scaleWidth, height: sacleHeight)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            // Main body with layered effects
            RoundedRectangle(cornerRadius: 4)
                .fill(color)
                .frame(height: size.height * 0.1)
            
            RoundedRectangle(cornerRadius: 4)
                .stroke(color)
                .frame(height: size.height * 0.1)
            
            // Detail elements
            VStack(spacing: 0) {
                Color.gray
                    .frame(height: 4)
                
                Spacer()
                
                Divider()
                    .frame(height: 1)
                    .background(.white.opacity(0.5))
                    .padding(.bottom, 5)
            }
            .cornerRadius(4, corners: [.topLeft, .topRight])
            .clipped()
        }
        .frame(width: scaleSize.width, height: scaleSize.height)
        .shadow(color: .black.opacity(0.3), radius: 5, x: 3, y: 5)
        .padding(.top, size.height * 0.07)
    }
}

