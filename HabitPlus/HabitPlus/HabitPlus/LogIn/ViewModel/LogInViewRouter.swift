//
//  LogInViewRouter.swift
//  HabitPlus
//
//  Created by coltec on 25/04/23.
//

import Foundation
import SwiftUI
import Combine

enum LogInViewRouter{
    static func makeHomeView() -> some View{
        let viewModel = HomeViewModel()
        
        return HomeView(viewModel: viewModel)
    }
    
    static func makeSignUpView(publisher: PassthroughSubject<Bool, Never>) -> some View{
        let viewModel = SignUpViewModel(interactor: SignUpInteractor())
        viewModel.publisher = publisher
        return SignUpView(viewModel: viewModel)
    }
    
}
