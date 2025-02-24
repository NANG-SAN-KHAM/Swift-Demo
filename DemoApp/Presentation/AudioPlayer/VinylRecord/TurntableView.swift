//
//  TurntableView.swift
//  Demo
//
//  Created by NANG SAN KHAM on 2/18/25.
//

import SwiftUI

// 唱盘 (包括转盘和驱动系统（电机），负责以恒定速度（33 1/3 RPM、45 RPM 或 78 RPM）旋转唱片。)
struct TurntableView: View {
    
    @Binding var isPlaying: Bool
    @State private var rotationAngle: Double = 0.0
    @State private var timer: Timer? = nil
    
    let width: CGFloat
    let height: CGFloat
    let color: Color
    let numberOfCircles: Int = 15
    
    init(isPlaying: Binding<Bool>, width: CGFloat? = nil, height: CGFloat? = nil, color: Color? = nil) {
        self._isPlaying = isPlaying
        self.width = width ?? 300
        self.height = height ?? 300
        self.color = color ?? .black
    }
    
    var body: some View {
        ZStack {
            // 唱片的底部圆形
            Circle()
                .fill(color)
                .frame(width: width, height: height)
            
            // 创建多个同心圆
            ForEach(0..<numberOfCircles, id: \.self) { i in
                Circle()
                    .strokeBorder(
                        AngularGradient(
                            gradient: Gradient(colors: [.black, .gray, .black, .gray, .black]),
                            center: .center
                        ),
                        lineWidth: 3
                    )
                    .background(
                        Circle()
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: [.black, .gray.opacity(0.5)]),
                                    center: .center,
                                    startRadius: 10,
                                    endRadius: width / 2
                                )
                            )
                    )
                    .overlay(
                        Circle()
                            .fill(.red)
                            .frame(width: width / 5, height: width / 5)
                    )
                    .frame(width: width - CGFloat(i * 10), height: height - CGFloat(i * 10))
                
            }
            
            // 唱片中心的装饰圆形
            Circle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 80, height: 80)
        }
        .rotationEffect(.degrees(rotationAngle))
        .animation(.linear(duration: 2), value: rotationAngle)
        .onChange(of: isPlaying) { newValue in
            newValue ? startRotation() : stopRotation()
        }
        .onDisappear {
            stopRotation()
        }
    }
    
    private func startRotation() {
        timer?.invalidate()
        // 开始：每 0.02 秒更新一次角度
        // 10 秒旋转 360 度 => 每次增加 360 / (10 / 0.02) = 0.72 度
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            rotationAngle += 0.72
        }
    }
    
    private func stopRotation() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    TurntableView(isPlaying: .constant(true),width: 300, height: 300, color: .black)
}
