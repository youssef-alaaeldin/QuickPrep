//
//  OnboardingView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 05/05/2025.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var navCoordinator: NavCoordinator
    var body: some View {
        VStack {
            Spacer()
            
            imageView
                .padding(.horizontal, 13)
            
            Spacer()
            
            welcomeMessage
                .padding(.horizontal, 32)
                .padding(.bottom, 80)
            
            getStartedBtn
                .padding(.horizontal, 24)
                .padding(.bottom, 93)
        }
    }
    
}

// MARK: - Compontents
extension OnboardingView {
    private var imageView: some View {
        Image(.onboarding)
            .resizable()
            .frame(width: 402, height: 268)
        
    }
    
    private var welcomeMessage: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("Welcome to QuickPrep!")
                .font(.heading2)
            
            Text("Effortless cooking starts here. Get fresh ingredients delivered and cook amazing meals in minutes.")
                .font(.text2)
                .foregroundStyle(.customGrey)
                .multilineTextAlignment(.center)
        }
        
    }
    
    private var getStartedBtn: some View {
        CustomButton(title: "Get Started") {
            navCoordinator.push(.main)
        }
    }
}

#Preview {
    OnboardingView()
}
