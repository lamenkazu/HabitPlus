//
//  SplashView.swift
//  HabitPlus
//
//  Created by coltec on 11/04/23.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel : SplashViewModel
    
    
    var body: some View {
        
        
        Group{
            switch viewModel.uiState {
                case .loading:  loadingScreen()
                    
                case .goToLogScreen:
                    viewModel.logInView()
                    
                case .goToHomeScreen:
                    viewModel.homeView()
                    
                case .err(let msg):
                    loadingScreen(err: msg)
            }
        }.onAppear(perform: {
            viewModel.onAppear()
        })
        
    }
        
}


extension SplashView{
    //Tela de Loading / Erro
    func loadingScreen(err: String? = nil) -> some View{
        ZStack{
            Image("logo")
                .resizable() //Possibilita alterar o tamanho
                .scaledToFit() //Escalar para encaixar na tela
                .frame(maxWidth: .infinity, maxHeight: .infinity) //Encaixa na tela com as dimensões especificadas (.infinity: toda a tela)
                .padding(20)
                .background(Color.white)
                .ignoresSafeArea() //Ignora padding de seguranca e cobre os espacos
            
            //Caso dê erro ativa um Alert
            if let err = err{
                Text("")
                    .alert(isPresented: .constant(true)){ //Faz ser sempre true para mostrar o alert
                        Alert(title: Text("Erro"),
                              message: Text(err),
                              dismissButton: .default(Text("Okay")) //Botao para confirmar. Ja existe normalmente, serve apenas para mudar o conteudo do texto.
                        
                        )
                    }
            }
        }
    }
    
    //
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
    }
}
