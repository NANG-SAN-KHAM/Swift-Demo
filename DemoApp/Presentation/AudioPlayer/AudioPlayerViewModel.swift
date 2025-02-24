//
//  AudioPlayerViewModel.swift
//  Demo
//
//  Created by NANG SAN KHAM on 2/23/25.
//

import AVFoundation
import Combine
import SwiftUI

class AudioPlayerViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var currentLyric = "Lyrics..."
    @Published var isPlaying = false
    
    private var player: AVAudioPlayer?
    private(set) var lyrics = [LyricLine]() // 允许外部读取，但不允许修改
    private var timer: Timer?
    
    // 根据当前播放时间，计算当前歌词行的进度（0~1）
    var currentLineProgress: CGFloat {
        guard let player = player else { return 0.0 }
        let currentTime = player.currentTime
        guard let index = lyrics.lastIndex(where: { $0.time <= currentTime }) else { return 0.0 }
        let startTime = lyrics[index].time
        let endTime = (index < lyrics.count - 1) ? lyrics[index + 1].time : player.duration
        let progress = (currentTime - startTime) / (endTime - startTime)
        return CGFloat(progress)
    }
    
    func setupAudio(audioFileName: String, lyricFileName: String) {
        // 设置音频
        guard let audioPath = Bundle.main.path(forResource: audioFileName, ofType: "mp3"),
              let lyricPath = Bundle.main.path(forResource: lyricFileName, ofType: "lrc") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            player?.delegate = self
        } catch {
            print("音频初始化失败: \(error)")
        }
        
        // 解析歌词
        do {
            let lyricContent = try String(contentsOfFile: lyricPath)
            lyrics = LyricsParser.parse(lyricContent).sorted { $0.time < $1.time }
        } catch {
            print("歌词解析失败: \(error)")
        }
    }
    
    func togglePlay() {
        guard let player = player else { return }
        
        if player.isPlaying {
            player.pause()
            timer?.invalidate()
        } else {
            player.play()
            startLyricUpdateTimer()
        }
        isPlaying = player.isPlaying
    }
    
    private func startLyricUpdateTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self, let player = self.player else { return }
            let currentTime = player.currentTime
            if let currentLyric = self.lyrics.last(where: { $0.time <= currentTime }) {
                self.currentLyric = currentLyric.text
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
        timer?.invalidate()
        currentLyric = ""
    }
}
