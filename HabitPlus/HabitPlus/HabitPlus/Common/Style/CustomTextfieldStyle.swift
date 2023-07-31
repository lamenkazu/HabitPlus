//
//  CustomTextfieldStyle.swift
//  HabitPlus
//
//  Created by coltec on 02/05/23.
//

import Foundation
import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle{
    
    public func _body(configuration: TextField<Self._Label>) -> some View{
        
        configuration
            .padding(.vertical, 7)
        //Arredondamento - Overlay
            .overlay(
                RoundedRectangle(cornerRadius:  8.0)
                    .stroke(Color.mint, lineWidth: 0.8)
            ).padding(.horizontal, 100)
        
    }
    
}
