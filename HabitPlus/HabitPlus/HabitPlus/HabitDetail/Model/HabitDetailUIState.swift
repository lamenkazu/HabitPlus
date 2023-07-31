//
//  HabitDetailUIState.swift
//  HabitPlus
//
//  Created by coltec on 06/06/23.
//

import Foundation

enum HabitDetailUIState: Equatable{
    case none
    case loading
    case success
    case error(String)
}
