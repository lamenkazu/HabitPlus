//
//  SignUpUIState.swift
//  HabitPlus
//
//  Created by coltec on 27/04/23.
//

import Foundation

enum SignUpUIState: Equatable{
    case none
    case loading
    
    //Perde a responsabilidade de guiar pra qual tela ir. Isso fica responsavel pela View Mãe, que é a LogIn
    case success //Ex goToHomeScreen
    
    case error(String)
}
