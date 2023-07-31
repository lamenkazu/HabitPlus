//
//  RefreshRequest.swift
//  HabitPlus
//
//  Created by coltec on 30/05/23.
//

import Foundation

struct RefreshRequest: Encodable{
    
    let token: String
    
    enum CodingKeys: String, CodingKey{
        case token = "refresh_token"
    }
}
