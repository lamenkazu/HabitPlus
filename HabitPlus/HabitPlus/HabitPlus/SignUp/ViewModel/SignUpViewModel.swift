//
//  SignUpViewModel.swift
//  HabitPlus
//
//  Created by coltec on 25/04/23.
//

import Foundation
import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var uiState: SignUpUIState = .none
    
    @Published var fullName: String = ""
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var document: String = ""
    @Published var phone: String = ""
    @Published var birthday: String = ""
    @Published var gender = Gender.female
    
    //Aplicação Programação Reativa
    var publisher: PassthroughSubject<Bool, Never>! //Não é opocional (!)
    
    private let interactor: SignUpInteractor
    
    private var cancellableSignUp: AnyCancellable?
    private var cancellableLogIn: AnyCancellable?
    
    init(interactor: SignUpInteractor) {
      self.interactor = interactor
    }
    
    deinit {
      cancellableSignUp?.cancel()
      cancellableLogIn?.cancel()
    }
    
    func signUp(){
        
        self.uiState = .loading
    
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthday)
        
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data Invalida \(birthday)")
            return
        }
        
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
    
        
        cancellableSignUp = interactor.postUser(request: SignUpRequest(fullName: fullName,
                                                                       email: email,
                                                                       password: password,
                                                                       document: document,
                                                                       phone: phone,
                                                                       birthday: birthday,
                                                                       gender: gender.index))
        .receive(on: DispatchQueue.main)
        .sink { completion in
            
            switch(completion) {
              case .failure(let appError):
                self.uiState = .error(appError.message)
                break
              case .finished:
                break
            }
      } receiveValue: { created in
          if (created) {
            self.cancellableLogIn = self.interactor.authLogin(request: LogInRequest(email: self.email, password: self.password))
              .receive(on: DispatchQueue.main)
              .sink { completion in
                  
                switch(completion) {
                    
                  case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                    
                  case .finished:
                    break
                }
                  
              } receiveValue: { successSignIn in
                print(created)
                self.publisher.send(created)
                self.uiState = .success
              }
              
          }
        }
                      
    }
}


extension SignUpViewModel{
    func homeView() -> some View{
        return SignUpViewRouter.makeHomeView()
    }
    
}
