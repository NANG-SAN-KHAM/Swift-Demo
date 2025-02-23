//
//  TonearmPivotBase.swift
//  Demo
//
//  Created by NANG SAN KHAM on 2/18/25.
//

import SwiftUI

/// 唱臂枢轴
struct TonearmPivotBase: View {
    
    var size: CGSize
    var color: Color

    init(size: CGSize = CGSize(width: 50, height: 250), color: Color = Color(hex: "#494b48")) {
        self.size = size
        self.color = color
    }
    
    var body: some View {
        Capsule()
            .fill(color.opacity(0.9))
            .frame(width: size.width * 0.9, height: size.height * 0.22)
            .padding(.top, size.height * 0.2)
    }
}


/// 唱臂支点
struct TonearmPivotPoint: View {
    
    var size: CGSize
    var color: Color
    
    init(size: CGSize = CGSize(width: 50, height: 250), color: Color = Color.black) {
        self.size = size
        self.color = color
    }
    
    private var scaleSize: CGFloat {
        return size.width * 0.65
    }
    
    private var secondaryScaleSize: CGFloat {
        return size.width * 0.3
    }
    
    private var verticalScale: CGFloat {
        return size.height * 0.25
    }
    
    var body: some View {
        
        ZStack {
            Circle()
                .fill(.white)
                .shadow(color: color.opacity(0.5), radius: 8, x: 8, y: 5)
            
            Circle()
                .stroke(.gray, lineWidth: 0.5)
                .frame(width: secondaryScaleSize, height: secondaryScaleSize)
                .overlay(
                    Circle().stroke(.white.opacity(0.5), lineWidth: 1)
                )
        }
        .frame(width: scaleSize, height: scaleSize)
        .padding(.top, verticalScale)
    }
}
