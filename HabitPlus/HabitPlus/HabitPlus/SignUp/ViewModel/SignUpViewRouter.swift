//
//  SignUpViewRouter.swift
//  HabitPlus
//
//  Created by coltec on 27/04/23.
//

import Foundation
import SwiftUI

enum SignUpViewRouter{
    static func makeHomeView() -> some View{
        
        let viewModel = HomeViewModel()
        
        return HomeView(viewModel: viewModel)
                      
    }
    
}
