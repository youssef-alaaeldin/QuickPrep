//
//  SplashScreenView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 24/05/2025.
//

import SwiftUI

struct SplashScreenView: View {
    @State var showAppName: Bool = false
    @State var appName: [String] = "QuickPrep".map { String($0)}
    var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    @State var loops: Int = 0
    @State var counter: Int = 0
    @Binding var showLaunchScreen: Bool
    
    var body: some View {
        ZStack {
            Image(.splashBg)
            
            if showAppName {
                HStack {
                    Image(.logo)
                        .resizable()
                        .frame(width: 51, height: 51)
                    
                    HStack(spacing: 0) {
                        ForEach(appName.indices) { char in
                            Text(appName[char])
                                .font(.custom("Aclonica-Regular", size: 48))
                                .foregroundStyle(.warmWhite)
                                .offset(y: counter == char ? -35 : 0)
                        }
                    }
                }
                .transition(AnyTransition.scale.animation(.easeIn))
            }
        }
        .onAppear {
            showAppName.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                let lastIndex = appName.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunchScreen = false
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}

#Preview {
    SplashScreenView(showLaunchScreen: .constant(true))
}
