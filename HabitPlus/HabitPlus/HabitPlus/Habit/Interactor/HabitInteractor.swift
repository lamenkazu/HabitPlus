//
//  HabitInteractor.swift
//  HabitPlus
//
//  Created by coltec on 05/06/23.
//

import Foundation
import Combine

class HabitInteractor{
    private let remote: HabitRemoteDataSource = .shared
    
    func fetchHabits() -> Future<[HabitResponse], AppError>{
        return remote.fetchHabits()
    }
}
