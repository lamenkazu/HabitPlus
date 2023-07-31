//
//  HabitDetailinteractor.swift
//  HabitPlus
//
//  Created by coltec on 06/06/23.
//

import Foundation
import Combine

class HabitDetailInteractor{
    private let remote: HabitDetailRemoteDataSource = .shared
}

extension HabitDetailInteractor{
    func save(habitId: Int, habitValueRequest request: HabitValueRequest) -> Future<Bool, AppError> {
      return remote.save(habitId: habitId, request: request)
    }
}
