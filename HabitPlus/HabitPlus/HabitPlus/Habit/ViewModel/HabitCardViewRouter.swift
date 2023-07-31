//
//  HabitCardViewRouter.swift
//  HabitPlus
//
//  Created by coltec on 06/06/23.
//

import Foundation
import SwiftUI
import Combine

enum HabitCardViewRouter{
    static func makeHabitDetailView(id: Int, name: String,
                                    label: String, habitPublisher: PassthroughSubject<Bool, Never>) -> some View {
      let viewModel = HabitDetailViewModel(id: id, name: name, label: label, interactor: HabitDetailInteractor())
      viewModel.habitPublisher = habitPublisher
      return HabitDetailView(viewModel: viewModel)
    }
}
