//
//  TonearmView.swift
//  Demo
//
//  Created by NANG SAN KHAM on 2/18/25.
//

import SwiftUI
import Combine

struct TonearmView: View {
    
    @Binding var isPlaying: Bool
    
    @State private var armRotation: CGFloat = 0
    @State private var timerCancellable: AnyCancellable? = nil
    
    var width: CGFloat
    var height: CGFloat
    var tonearmColor: Color
    var tonearmPivotColor: Color
    var tonearmPivotPointColor: Color
    var cartridgeColor: Color
    
    // 自定义初始化，isPlaying 需要外部传入
    init(isPlaying: Binding<Bool>,
         width: CGFloat = 50,
         height: CGFloat = 250,
         tonearmColor: Color = Color(hex: "#C0C0C0"),
         tonearmPivotColor: Color = .white,
         tonearmPivotPointColor: Color = .black,
         cartridgeColor: Color = Color(hex: "#565662")) {
        self._isPlaying = isPlaying
        self.width = width
        self.height = height
        self.tonearmColor = tonearmColor
        self.tonearmPivotColor = tonearmPivotColor
        self.tonearmPivotPointColor = tonearmPivotPointColor
        self.cartridgeColor = cartridgeColor
    }
    
    private var pivotXPosition: CGFloat {
        return 0.5 // 居中
    }
    
    private var pivotYPosition: CGFloat {
        let extraHeight = height * 0.15
        return (width + extraHeight) / height
    }
    
    var body: some View {
        
        // 唱臂组件
        ZStack(alignment: .top) {
            
            // 唱臂枢轴
            TonearmPivotBase(
                size: CGSize(width: width, height: height),
                color: tonearmPivotColor
            )
            
            ZStack(alignment: .top) {
                
                // 唱臂
                TonearmShape()
                    .stroke(tonearmColor, style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .round,
                        lineJoin: .round
                    ))
                    .frame(width: width, height: height)
                    .shadow(color: .black.opacity(0.5), radius: 3, x: 3, y: 5)
                
                // 唱头
                CartridgeView(
                    size: CGSize(width: width, height: height),
                    color: cartridgeColor
                )
                
                
                // 唱针
                StylusView(
                    size: CGSize(width: width, height: height),
                    color: tonearmColor
                )
            }
            // 旋转动画
            .rotationEffect(.degrees(armRotation), anchor: UnitPoint(x: pivotXPosition, y: pivotYPosition))
            .animation(.easeInOut(duration: 0.5), value: armRotation)
            
            //  唱臂支点
            TonearmPivotPoint(
                size: CGSize(width: width, height: height),
                color: tonearmPivotPointColor
            )
        }
        .onAppear {
            updateRotation()
            if isPlaying {
                startTimer() // 启动定时器
            }
        }
        .onDisappear {
            stopTimer() // 确保视图消失时停止所有定时器
        }
        .onChange(of: isPlaying) { playing in
            if playing {
                startTimer() // 启动定时器并触发抖动
                triggerJitterAnimation()
            } else {
                stopTimer() // 停止定时器并复位
            }
        }
    }
    
    private func updateRotation() {
        armRotation = isPlaying ? 15 : 0
    }
    
    private func startTimer() {
        stopTimer()   // 确保先取消之前的定时器
        timerCancellable = Timer.publish(every: 2, on: .main, in: .common)
            .autoconnect()
            .sink { [self] _ in
                guard isPlaying else { return }
                triggerJitterAnimation()
            }
    }
    
    private func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
        withAnimation {
            armRotation = 0
        }
    }
    
    private func triggerJitterAnimation() {
        // 随机偏移 -2° ~ 2°
        let jitter: CGFloat = CGFloat(Double.random(in: -2.0...2.0))
        withAnimation(.interpolatingSpring(stiffness: 200, damping: 10)) {
            armRotation = 15 + jitter
        }
        // 0.1秒后恢复到 15°
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(Animation.easeInOut(duration: 0.1)) {
                armRotation = 15
            }
        }
    }
}


#Preview {
    ZStack {
        Color.primary
            .ignoresSafeArea()
        
        TonearmView(isPlaying: .constant(true), width: 60, height: 350, tonearmColor: Color.red)
    }
    
}
