//
//  LogInErrorResponse.swift
//  HabitPlus
//
//  Created by coltec on 25/05/23.
//

import Foundation

struct LogInErrorResponse: Decodable{
    let detail: LogInDetailErrorResponse
    
    enum CodingKeys: String, CodingKey{
        case detail
    }
}

struct LogInDetailErrorResponse: Decodable{
    let message: String
    
    enum CodingKeys: String, CodingKey{
        case message
    }
}
