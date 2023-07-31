//
//  LogInInteractor.swift
//  HabitPlus
//
//  Created by coltec on 30/05/23.
//

import Foundation
import Combine

class LogInInteractor{
    private let remote: LogInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared

    func authLogin(request: LogInRequest) -> Future<LogInResponse, AppError>{
        
        return remote.authLogin(request: request)
        
    }
    
    func insertAuth(userAuth: UserAuth){
        local.insertUserAuth(userAuth: userAuth)
    }
    
    func fetchAuth() -> Future<UserAuth?, Never>{
        return local.getUserAuth()
    }
}
