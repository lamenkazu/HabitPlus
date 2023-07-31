//
//  SplashViewModel.swift
//  HabitPlus
//
//  Created by coltec on 13/04/23.
//

import Foundation
import SwiftUI
import Combine

//Codigo que conecta a View com a Model

//Herda de objeto observavel
class SplashViewModel : ObservableObject{
    @Published var uiState: SplashUIState = .loading
    
    private var cancellableAuth: AnyCancellable?
    private var cancellableRefresh: AnyCancellable?
    private let interactor: SplashInteractor
    
    init(interactor: SplashInteractor){
        self.interactor = interactor
    }
    
    deinit{
        cancellableAuth?.cancel()
        cancellableRefresh?.cancel()
    }
    
    func onAppear(){
        
        cancellableAuth = interactor.fetchAuth()
            .delay(for: .seconds(3), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink{ userAuth in
                //se userAuth == nulo -> Login
                if userAuth == nil{
                    self.uiState = .goToLogScreen
                } else if (Date().timeIntervalSince1970 > Double(userAuth!.expires)){
                //senao se userAuth != nulo && expirou
                    self.cancellableRefresh = self.interactor.refreshToken(request: RefreshRequest(token: userAuth!.refreshToken))
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: {completion in
                            switch completion{
                                case .failure(_):
                                self.uiState = .goToLogScreen
                                    break
                                default:
                                    break
                            }
                        }, receiveValue: { success in
                            let auth = UserAuth(idToken: success.accessToken,
                                                refreshToken: success.refreshToken,
                                                expires: Date().timeIntervalSince1970 + Double(success.expires),
                                                tokenType: success.tokenType)
                            self.interactor.insertAuth(userAuth: auth)
                            self.uiState = .goToHomeScreen
                            
                        }
                        )
                    
                } else {
                //senao -> Tela Principal
                    self.uiState = .goToHomeScreen
                }
            }
    }
    
    
    
}
extension SplashViewModel{
    func logInView() -> some View{
        
        return SplashViewRouter.makeLogInView()
        
    }
    func homeView() -> some View{
        return SplashViewRouter.makeHomeView()
    }
}
