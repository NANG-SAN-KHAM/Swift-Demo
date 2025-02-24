//
//  AudioPlayerView.swift
//  Demo
//
//  Created by NANG SAN KHAM on 2/23/25.
//

import SwiftUI

struct AudioPlayerView: View {
    
    @StateObject private var viewModel = AudioPlayerViewModel()
    
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                VinylRecordView(isPlaying: $viewModel.isPlaying)
                
                // 歌词显示
                Text(viewModel.currentLyric)
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(height: 60)
                    .padding()
                
                
                LyricTextView(
                    lyric: viewModel.currentLyric,
                    progress: viewModel.currentLineProgress
                )
                
                
                // 播放控制按钮
                Button {
                    viewModel.togglePlay()
                } label: {
                    Text(viewModel.isPlaying ? "Stop" : "Play")
                        .padding()
                        .background(viewModel.isPlaying ? Color.red : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 20)
            }
        }
        .onAppear {
            viewModel.setupAudio(audioFileName: "apt", lyricFileName: "apt")
        }
    }
}

#Preview {
    AudioPlayerView()
}
