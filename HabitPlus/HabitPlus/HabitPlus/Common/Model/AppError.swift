//
//  AppError.swift
//  HabitPlus
//
//  Created by coltec on 30/05/23.
//

import Foundation

enum AppError: Error{
    case response(message: String)
    
    public var message: String{
        switch self{
        case .response(let message):
            return message
        }
    }
}
