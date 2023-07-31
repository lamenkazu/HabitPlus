//
//  RemoteDataSource.swift
//  Habit
//
//  Created by Virginia Mota on 14/05/22.
//

import Foundation
import Combine

class LogInRemoteDataSource{
    
    //padrão singleton - é instanciado apenas uma vez em todo o projeto

    //para garantir que temos apenas 1 único objeto vivo dentro da aplicação
    static var shared: LogInRemoteDataSource = LogInRemoteDataSource()

    //seu construtor é privado para que ninguém no projeto possa instanciá-lo
    private init(){
        
    }
    
    func authLogin(request: LogInRequest) -> Future<LogInResponse, AppError>{
        
        return Future<LogInResponse, AppError> { promise in
            WebService.call(path: .login, params: [
              URLQueryItem(name: "username", value: request.email),
              URLQueryItem(name: "password", value: request.password)
            ]) { result in
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


