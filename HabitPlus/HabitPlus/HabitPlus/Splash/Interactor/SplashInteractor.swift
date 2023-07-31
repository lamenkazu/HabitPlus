//
//  SplashInteractor.swift
//  HabitPlus
//
//  Created by coltec on 30/05/23.
//

import Foundation
import Combine

class SplashInteractor{
    private let remote: SplashRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    
    func fetchAuth() -> Future<UserAuth?, Never>{
        return local.getUserAuth()
    }
    
    func insertAuth(userAuth: UserAuth){
        local.insertUserAuth(userAuth: userAuth)
    }
    
    func refreshToken(request: RefreshRequest) -> Future<LogInResponse, AppError>{
        remote.refreshToken(request: request)
    }
}
