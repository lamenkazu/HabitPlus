//
//  SignUpRequest.swift
//  HabitPlus
//
//  Created by coltec on 18/05/23.
//

import Foundation

//Sera transformado em Json, por isso Encodable
struct SignUpRequest: Encodable{
    let fullName: String
    let email: String
    let password: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    //mapeamento de chave e valor igual ao json
    enum CodingKeys: String, CodingKey{
        
        //Na API é name, então modifica o valor pelo nome no Banco de Dados aqui
        case fullName = "name"
        case email
        case password
        case document
        case phone
        case birthday
        case gender
        
    }
    
}
