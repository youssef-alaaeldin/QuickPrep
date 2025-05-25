//
//  VideoPlayerView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 25/05/2025.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @State private var player = AVPlayer()
    
    var videoURL: String
    
    var body: some View {
        VideoPlayer(player: player)
            .ignoresSafeArea(.all)
            .onAppear {
                player = AVPlayer(url: URL(string: videoURL)!)
                player.play()
                
            }
    }
}

//#Preview {
//    VideoPlayerView()
//}
