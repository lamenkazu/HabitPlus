//
//  Gender.swift
//  HabitPlus
//
//  Created by coltec on 27/04/23.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable{
    case female = "Feminino"
    case male = "Masculino"
    case other = "Outro"
    case notInformed = "Prefiro não dizer"
    
    var id: String{
        self.rawValue
    }
    
    //Retorna o valor do indice
    var index: Self.AllCases.Index{
        return Self.allCases.firstIndex{self == $0} ?? 0
    }
}
