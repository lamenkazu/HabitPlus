//
//  ButtonStyle.swift
//  HabitPlus
//
//  Created by coltec on 05/06/23.
//

import Foundation
import SwiftUI

struct ButtonStyle: ViewModifier{
    func body(content: Content) -> some View{
        content
            .frame(maxWidth: .infinity)
            .font(Font.system(.title).bold())
            .padding(.vertical, 5)
            .border(.mint)
            .background(Color.mint)
            .foregroundColor(.white) //Cor do Texto
            .cornerRadius(10.0)
    }
}
