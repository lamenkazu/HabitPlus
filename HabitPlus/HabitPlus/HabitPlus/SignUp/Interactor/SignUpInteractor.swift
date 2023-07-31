//
//  SignUpInteractor.swift
//  HabitPlus
//
//  Created by coltec on 30/05/23.
//

import Foundation
import Combine

class SignUpInteractor{

    private let remoteSignUp: SignUpRemoteDataSource = .shared//Ficará em Common -> Network
    private let remoteSignIn: LogInRemoteDataSource = .shared//Ficará em Common -> Network
    //private let local: LocalDataSource //Faremos depois :)
    
    
    func postUser(request: SignUpRequest) -> Future<Bool, AppError>{
        return remoteSignUp.postUser(request: request)
    }
    
    func authLogin(request: LogInRequest) -> Future<LogInResponse, AppError>{
        return remoteSignIn.authLogin(request: request)
    }
}

