//
//  LyricsParser.swift
//  Demo
//
//  Created by NANG SAN KHAM on 2/23/25.
//

import Foundation

class LyricsParser {
    static func parse(_ content: String) -> [LyricLine] {
        let pattern = "\\[(\\d+):(\\d+\\.?\\d*)\\](.*)"
        let regex = try? NSRegularExpression(pattern: pattern)
        
        return content.components(separatedBy: .newlines).compactMap { line in
            guard let match = regex?.firstMatch(in: line, range: NSRange(location: 0, length: line.utf16.count)),
                  let minuteRange = Range(match.range(at: 1), in: line),
                  let secondRange = Range(match.range(at: 2), in: line),
                  let textRange = Range(match.range(at: 3), in: line) else { return nil }
            
            let minutes = Double(line[minuteRange]) ?? 0
            let seconds = Double(line[secondRange]) ?? 0
            
            return LyricLine(time: minutes * 60 + seconds, text: String(line[textRange]))
        }
    }
}
