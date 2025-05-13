//
//  StretchyHeaderViewModeifier.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 13/05/2025.
//

import SwiftUI

struct StetchyHeaderViewModifier: ViewModifier {
    
    var startingHeight: CGFloat = 300
    var coordinateSpace: CoordinateSpace = .global
    
    func body(content: Content) -> some View {
        GeometryReader(content: { geometry in
            content
                .frame(width: geometry.size.width, height: stretchedHeight(geometry))
                .clipped()
                .offset(y: stretchedOffset(geometry))
        })
        .frame(height: startingHeight)
    }
    
    private func yOffset(_ geo: GeometryProxy) -> CGFloat {
        geo.frame(in: coordinateSpace).minY
    }
    
    private func stretchedHeight(_ geo: GeometryProxy) -> CGFloat {
        let offset = yOffset(geo)
        return offset > 0 ? (startingHeight + offset) : startingHeight
    }
    
    private func stretchedOffset(_ geo: GeometryProxy) -> CGFloat {
        let offset = yOffset(geo)
        return offset > 0 ? -offset : 0
    }
}

public extension View {
    
    func asStretchyHeader(startingHeight: CGFloat) -> some View {
        modifier(StetchyHeaderViewModifier(startingHeight: startingHeight))
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        
        ScrollView {
            VStack {
                Rectangle()
                    .fill(Color.green)
                    .overlay(
                        ZStack {
                            if #available(iOS 15.0, *) {
                                AsyncImage(url: URL(string: "https://picsum.photos/800/800"))
                            }
                        }
//                        Image(systemName: "heart.fill")
//                            .resizable()
//                            .scaledToFill()
//                            .padding(100)
                    )
                    .asStretchyHeader(startingHeight: 300)
            }
        }
    }
}
