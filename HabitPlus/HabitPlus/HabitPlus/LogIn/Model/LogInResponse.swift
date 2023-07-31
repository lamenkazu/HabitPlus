//
//  LogInResponse.swift
//  HabitPlus
//
//  Created by coltec on 25/05/23.
//

import Foundation

struct LogInResponse: Decodable{
    let accessToken: String
    let refreshToken: String
    let expires: Int
    let tokenType: String
    
    enum CodingKeys: String, CodingKey{
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expires
        case tokenType = "token_type"
    }
}
