//
//  LogInViewModel.swift
//  HabitPlus
//
//  Created by coltec on 13/04/23.
//

import Foundation
import SwiftUI
import Combine

class LogInViewModel: ObservableObject{
    
    @Published var uiState: LogInUIState = .none
    
    @Published var email : String = ""
    @Published var password : String = ""
    
    
    //Aplicação dos conceitos Programação Reativa - Cria variáveis
    private let publisher = PassthroughSubject<Bool, Never>() //Fica Escutando as informações
    private var cancellable: AnyCancellable? //Cancela a escuta quando for escutado.
    
    private let interactor: LogInInteractor
    private var cancellableRequest: AnyCancellable?
    
    //Metodo Construtor
    init(interactor: LogInInteractor){
        self.interactor = interactor
        //Quando sincronizar, para de observar através do Cancellable
        cancellable = publisher.sink{ value in
            
            //Se valor for verdadeiro vai pra HomeScreen
            if(value){
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    //Método destrutor
    deinit{
        
        cancellable?.cancel() //cria um cancell
        cancellableRequest?.cancel()
        
    }
    
    func login(){
        
        self.uiState = .loading // para gerar a barra de progresso
        

        cancellableRequest =  interactor.authLogin(request: LogInRequest(email: email,
                                                   password: password))
        .receive(on: DispatchQueue.main)
        .sink{ completion in
            

            switch(completion) {
              case .failure(let appError):
                self.uiState = LogInUIState.error(appError.message)
                break
              case .finished:
                break
            }
            
          } receiveValue: { success in

              self.interactor.insertAuth(userAuth: UserAuth(idToken: success.accessToken,
                                                            refreshToken: success.refreshToken,
                                                            expires: Date().timeIntervalSince1970 + Double(success.expires),
                                                            tokenType: success.tokenType))
              
              self.uiState = .goToHomeScreen
          }
            
        }
        
            
            //Codigo de erro exibido falta de cadastro
            /*
             
            Text("").alert(isPresented: .constant(true)){
                Alert(
                    title: Text("Habit+"),
                    message: Text("Usuario nao cadastrado"),
                    dismissButton: .default(Text("OK")){
                        //Código após confirmar falta de cadastro.
                        self.uiState = .none
                    }
                )
            }
            
            */
            
    
}

extension LogInViewModel {
    func homeView() -> some View{
        return LogInViewRouter.makeHomeView()
    }
    
    func signUpView() -> some View{
        return LogInViewRouter.makeSignUpView(publisher: publisher)
    }

}
