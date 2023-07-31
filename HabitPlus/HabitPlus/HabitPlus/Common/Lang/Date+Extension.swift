//
//  Date+Extension.swift
//  HabitPlus
//
//  Created by coltec on 05/06/23.
//

import Foundation


extension Date{
    func toString(destPattern dest: String) -> String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = dest
        
        return formatter.string(from: self)
    }
    
}
