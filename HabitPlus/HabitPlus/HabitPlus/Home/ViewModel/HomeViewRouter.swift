//
//  HomeViewRouter.swift
//  HabitPlus
//
//  Created by coltec on 05/06/23.
//

import Foundation
import SwiftUI

enum HomeViewRouter{
    static func makeHabitView(viewModel: HabitViewModel) -> some View{
        return HabitView(viewModel: viewModel)
    }
}
