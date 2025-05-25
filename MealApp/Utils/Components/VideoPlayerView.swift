//
//  VideoPlayerView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 25/05/2025.
//

import SwiftUI
import AVKit
import Combine

struct VideoPlayerView: View {
    @State private var player = AVPlayer()
    @State private var isLoading = true
    @State private var foundVid = true
    @State private var playerItemObserver: AnyCancellable?
    
    var videoURL: String

    var body: some View {
        Group {
            if foundVid {
                ZStack {
                    VideoPlayer(player: player)
                        .ignoresSafeArea(.all)
                    
                    if isLoading {
                        ProgressView("Loading video...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .padding()
                            .background(Color.black.opacity(0.6))
                            .cornerRadius(10)
                    }
                }
                .onAppear {
                    guard let url = URL(string: videoURL) else {
                        foundVid = false
                        return
                    }
                    
                    let item = AVPlayerItem(url: url)
                    player.replaceCurrentItem(with: item)
                    player.play()

                    playerItemObserver = item.publisher(for: \.status)
                        .receive(on: RunLoop.main)
                        .sink { status in
                            if status == .readyToPlay {
                                isLoading = false
                            } else if status == .failed {
                                foundVid = false
                                isLoading = false
                            }
                        }
                }
                .onDisappear {
                    player.pause()
                    player.replaceCurrentItem(with: nil)
                    playerItemObserver = nil
                }
            } else {
                Text("Sorry, no video available.")
                    .font(.headline)
                    .foregroundStyle(.black)
            }
        }
    }
}
