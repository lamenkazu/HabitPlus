//
//  SplashUIState.swift
//  HabitPlus
//
//  Created by coltec on 11/04/23.
//

import Foundation

enum SplashUIState {
    case loading;
    case goToLogScreen;
    case goToHomeScreen;
    case err(String);
}
