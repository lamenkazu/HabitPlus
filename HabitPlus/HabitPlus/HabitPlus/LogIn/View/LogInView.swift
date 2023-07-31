//
//  LogInView.swift
//  HabitPlus
///Users/coltec/Desktop/HabitPlus/HabitPlus/HabitPlus/LogIn/View/LogInView.swift
//  Created by coltec on 13/04/23.
//

import SwiftUI

struct LogInView: View {
    
    @ObservedObject var viewModel: LogInViewModel

    
    @State var action : Int? = 0
    
    
    
    var body: some View {
        
        
        ZStack{
            if case LogInUIState.goToHomeScreen = viewModel.uiState{
                
                viewModel.homeView()
                
            }else{
                //Possibilita utilizar o NavigationLink
                NavigationView{
                    
                    //Quando o teclado aparece permite que tudo se mova para que nao atrapalhe a visao.
                    ScrollView(showsIndicators: false){
                        
                        //a propriedade spacing funciona como um padding
                        VStack(alignment: .center, spacing: 10){
                            
                            //Cria um espaço para os componentes
                            Spacer(minLength: 200)
                            
                            VStack(alignment: .center, spacing: 8){
                                
                                logoView
                                
                                lblLogInTitle
                                
                                usernameView
                                
                                passwordView
                                
                                buttonSendView
                                
                                registerView
                                
                            } //VStack
                        } //VStack
                        
                        if case LogInUIState.error(let value) = viewModel.uiState{
                            Text("").alert(isPresented: .constant(true)){ //Sempre true porque o parametro nao é nulo, aqui é estado de erro.
                                Alert(
                                    title: Text("Habit +"),
                                    message: Text(value),
                                    dismissButton: .default(Text("OK")){
                                        //Aqui é o codigo que faz algo quando some o alerta
                                    }
                                )
                            }
                        } //Fim IfCaseError
                        
                    } //ScrollView
                    
                } //NavigationView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 30)
                .background(.mint)
                .navigationBarTitle("trocar", displayMode: .inline)
                .navigationBarHidden(true)
            }
            }
        }
        
        
}

extension LogInView {
    
    var logoView : some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 30)
    }
    
    var lblLogInTitle : some View{
        Text("Login").foregroundColor(.mint)
            .font(.title.bold())
            .padding(.horizontal, 8)
    }
    
    var usernameView : some View {
        /*
        TextField("username", text: $username)
            
         */
        
        EditTextView(placeHolder: "Email",
                     text: $viewModel.email,
                     error: "username invalido",
                     failure: viewModel.email.count < 5,
                     keyboard: .emailAddress) //usuario nao pode ser menor q 6

        
        
    }
    
    var passwordView : some View{
        EditTextView(placeHolder: "Senha",
                     text: $viewModel.password,
                     error: "senha invalida",
                     failure: viewModel.password.count < 8,//senha nao pode ser menor q 8
                     isSecure: true)
    }
    
    var buttonSendView : some View {
        
        LoadingButtonView(action: {
            
            viewModel.login()
            
        }, text: "Entrar",
           disabled: !viewModel.email.isEmail() || viewModel.password.count < 8,
           showProgress: self.viewModel.uiState == LogInUIState.loading)
        
    }
    
    var registerView : some View{
        VStack{
            Text("Não tenho cadastro")
                .foregroundColor(.indigo)
                .font(.title3)
                .padding(.top, 100)
            
            ZStack{
                
                NavigationLink(
                    destination: viewModel.signUpView(), //Criar na ViewModel
                    tag: 1,
                    selection: $action,
                    label: {EmptyView()}
                )



                Button("Realizar "){
                    self.action = 1
                }
    
                
            }//ZStack
        } //VStack
        
        
    }//registerView
    
}//extension LogInView

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(viewModel: LogInViewModel(interactor: LogInInteractor()))
    }
}
