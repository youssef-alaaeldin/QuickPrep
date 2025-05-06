//
//  NetworkProviderContainerDI.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 06/05/2025.
//

import Foundation
import Factory

extension Container {
    var networkProvider: Factory<NetworkProvider> {
        Factory(self) { NetworkProvider() }
    }
}
