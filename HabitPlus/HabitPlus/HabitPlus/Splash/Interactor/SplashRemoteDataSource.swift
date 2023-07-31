//
//  SplashRemoteDataSource.swift
//  HabitPlus
//
//  Created by coltec on 30/05/23.
//

import Foundation
import Combine

class SplashRemoteDataSource{
    

    static var shared: SplashRemoteDataSource = SplashRemoteDataSource()

    private init(){
        
    }
    
    func refreshToken(request: RefreshRequest) -> Future<LogInResponse, AppError>{
        
        return Future<LogInResponse, AppError> { promise in
            
                WebService.call(path: .refreshToken, method: .put, body: request){ result in
                    switch result {
                      case .failure(let error, let data):
                        if let data = data {
                          if error == .unauthorized {
                              let decoder = JSONDecoder()
                              let response = try? decoder.decode(LogInErrorResponse.self, from: data)
                              promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                          }
                        }
                        break
                      case .success(let data):
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(LogInResponse.self, from: data)
                        
                        guard let response = response else {
                          print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                          return
                        }
                        
                        promise(.success(response))
                        
                        break
                    }
                }
            }
        }
}


