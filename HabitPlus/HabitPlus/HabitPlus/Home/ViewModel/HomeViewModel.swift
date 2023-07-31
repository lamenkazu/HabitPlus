//
//  HomeViewModel.swift
//  HabitPlus
//
//  Created by coltec on 25/04/23.
//

import Foundation
import SwiftUI

class HomeViewModel : ObservableObject{
    
    let viewModel = HabitViewModel(interactor: HabitInteractor())
    
}

extension HomeViewModel{
    func habitView() -> some View{
        return HomeViewRouter.makeHabitView(viewModel: viewModel)
    }
}
