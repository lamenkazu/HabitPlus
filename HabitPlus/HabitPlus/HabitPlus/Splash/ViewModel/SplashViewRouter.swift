//
//  SplashViewRouter.swift
//  HabitPlus
//
//  Created by coltec on 13/04/23.
//

import Foundation
import SwiftUI

enum SplashViewRouter {
    
    static func makeLogInView() -> some View{
        
        let viewModel = LogInViewModel(interactor: LogInInteractor())
        
        return LogInView(viewModel: viewModel)
        
    }
    
    static func makeHomeView() -> some View{
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
