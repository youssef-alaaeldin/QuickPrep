//
//  NavigationHandler+Sheet.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 05/05/2025.
//

import SwiftUI

//MARK: - Sheet builder -

extension NavCoordinator {
    @ViewBuilder
    public func build(sheet: Sheet) -> some View {
        switch sheet {
            case .videoPlayer(let videoURL):
                VideoPlayerView(videoURL: videoURL)
            default:
                EmptyView()
        }
    }
}
