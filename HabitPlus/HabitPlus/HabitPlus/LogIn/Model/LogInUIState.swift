//
//  LogInUIState.swift
//  HabitPlus
//
//  Created by coltec on 25/04/23.
//

import Foundation

enum LogInUIState: Equatable {
    case none
    case loading
    case goToHomeScreen
    case error(String)
}
