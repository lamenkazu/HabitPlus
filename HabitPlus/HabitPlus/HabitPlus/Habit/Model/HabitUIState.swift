//
//  HabitUIState.swift
//  HabitPlus
//
//  Created by coltec on 05/06/23.
//

import Foundation

enum HabitUIState: Equatable{
    case loading
    case emptyList
    case fullList([HabitCardViewModel])
    case error(String)
}
