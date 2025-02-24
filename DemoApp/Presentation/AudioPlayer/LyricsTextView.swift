//
//  LyricsTextView.swift
//  Demo
//
//  Created by NANG SAN KHAM on 2/23/25.
//

import SwiftUI

//struct LyricTextView: View {
//    let lyric: String
//    let progress: CGFloat  // 0.0 表示未唱到，1.0 表示全部唱完
//
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            Text(lyric)
//                .font(.title3)
//                .foregroundStyle(
//                    LinearGradient(
//                        gradient: Gradient(stops: [
//                            .init(color: .green, location: 0.0),
//                            .init(color: .green, location: progress),
//                            .init(color: .gray, location: progress),
//                            .init(color: .gray, location: 1.0)
//                        ]),
//                        startPoint: .leading,
//                        endPoint: .trailing
//                    )
//                )
//                // 确保文本保持单行并自然扩展宽度
//                .fixedSize(horizontal: true, vertical: false)
//                // 保持与原来一致的垂直间距
//                .padding(.vertical, 8)
//        }
//        // 保持原有布局参数
//        .frame(height: 60)
//        .padding(.horizontal)
//    }
//}
//

// 文本宽度监测工具
private struct TextWidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct LyricTextView: View {
    let lyric: String
    let progress: CGFloat
    
    @State private var textWidth: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    Text(lyric)
                        .font(.title3)
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: .green, location: 0.0),
                                    .init(color: .green, location: progress),
                                    .init(color: .gray, location: progress),
                                    .init(color: .gray, location: 1.0)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .fixedSize(horizontal: true, vertical: false)
                        .background(GeometryReader { textProxy in
                            Color.clear
                                .preference(
                                    key: TextWidthPreferenceKey.self,
                                    value: textProxy.size.width
                                )
                        })
                        .id("lyricAnchor")
                }
                .padding(.vertical, 8)
                .onPreferenceChange(TextWidthPreferenceKey.self) { width in
                    textWidth = width
                }
            }
            .content.offset(x: calculateScrollOffset(geometry: geometry))
            .animation(.linear(duration: 0.2), value: progress)
        }
        .frame(height: 60)
        .padding(.horizontal)
    }
    
    private func calculateScrollOffset(geometry: GeometryProxy) -> CGFloat {
        let availableWidth = geometry.size.width
        let maxOffset = max(0, textWidth - availableWidth)
        return -maxOffset * progress + (availableWidth / 2) - (textWidth / 2)
    }
}
