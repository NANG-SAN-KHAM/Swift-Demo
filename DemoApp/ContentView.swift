//
//  ContentView.swift
//  Demo
//
//  Created by NANG SAN KHAM on 2/23/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VinylRecordView(isPlaying: .constant(false))
    }
}

#Preview {
    ContentView()
}
