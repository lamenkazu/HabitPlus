//
//  HabitPlusApp.swift
//  HabitPlus
//
//  Created by coltec on 11/04/23.
//

import SwiftUI

@main
struct HabitPlusApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        }
    }
}
