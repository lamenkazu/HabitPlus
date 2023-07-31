//
//  HabitRemoteDataSource.swift
//  HabitPlus
//
//  Created by coltec on 05/06/23.
//

import Foundation
import Combine

class HabitRemoteDataSource{
    static var shared: HabitRemoteDataSource = HabitRemoteDataSource()
    
    private init(){}
    
    func fetchHabits() -> Future<[HabitResponse], AppError>{
        
        return Future<[HabitResponse], AppError> { promise in
            WebService.call(path: .habits, method: .get) { result in
              switch result {
                case .failure(_, let data):
                  if let data = data {
                      let decoder = JSONDecoder()
                        let response = try? decoder.decode(LogInErrorResponse.self, from: data)
                        promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                  }
                  break
                case .success(let data):
                  let decoder = JSONDecoder()
                  let response = try? decoder.decode([HabitResponse].self, from: data)
                  
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
