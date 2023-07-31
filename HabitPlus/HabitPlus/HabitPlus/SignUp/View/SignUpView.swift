//
//  SignUpView.swift
//  HabitPlus
//
//  Created by coltec on 25/04/23.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    @State var action : Int? = 0
    
    var body: some View {
        

        ZStack{
            if case SignUpUIState.success = viewModel.uiState{
                
                viewModel.homeView()
                
            }else{
                
                
                ScrollView(showsIndicators: false){
                    
                    //a propriedade spacing funciona como um padding
                    VStack(alignment: .center, spacing: 10){
                        
                        //Cria um espaço para os componentes
                        Spacer(minLength: 100)
                        
                        VStack(alignment: .center, spacing: 8){
                            
                            logoView
                            
                            lblSignUpTitle
                            
                            completeNameView
                            
                            emailView
                            
                            passwordView
                            
                            cpfView
                            
                            phoneView
                            
                            birthdayView
                            
                            genderView
                            
                            registerView
                            
                            

                             
                            
                        } //VStack
                    } //VStack
                    
                
                } //ScrollView
                
                if case SignUpUIState.error(let value) = viewModel.uiState{
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
               
                
            }//else
        }
           
        
        
    }
}
extension SignUpView{
    
    var genderView: some View{
        //Componente Picker
        Picker("Genero", selection: $viewModel.gender){
            ForEach(Gender.allCases, id: \.self){
                value in
                Text(value.rawValue).tag(value)
            }
        }.padding(.horizontal, 30).pickerStyle(SegmentedPickerStyle())
            
    }
    
    var logoView: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 30)
    }
    
    var birthdayView: some View{
//        TextField("Username", text: $username)
//            .border(.black).padding(.horizontal, 100).autocapitalization(.none )
        
        EditTextView(placeHolder: "Nascimento", text: $viewModel.birthday, error: "DD/MM/AAAA", failure: viewModel.birthday.count != 10, keyboard: .numberPad)
        
    }
    
    var phoneView: some View{
//        TextField("Telefone", text: $username)
//            .border(.black).padding(.horizontal, 100).autocapitalization(.none )
        EditTextView(placeHolder: "Telefone",
                     text: $viewModel.phone,
                     error: "(xx)xxxxx-xxxx",
                     failure: false,
                        //!viewModel.phone.isAPhone(),
                     keyboard: .numberPad)
    }
    
    var cpfView: some View{
//        TextField("CPF", text: $username)
//            .border(.black).padding(.horizontal, 100).autocapitalization(.none )
        EditTextView(placeHolder: "CPF",
                     text: $viewModel.document,
                     error: "xxx.xxx.xxx-xx",
                     failure: false ,
                        //!viewModel.document.isCPF(),
                     keyboard: .numberPad)
    }
    
    var passwordView: some View{
//        SecureField("Username", text: $username)
//            .border(.black).padding(.horizontal, 100).autocapitalization(.none )
        EditTextView(placeHolder: "Senha", text: $viewModel.password, error: "Senha pequena", failure: viewModel.password.count < 8, isSecure: true)
    }
    
    var usernameView: some View{
//        TextField("Username", text: $username)
//            .border(.black).padding(.horizontal, 100).autocapitalization(.none )
        EditTextView(placeHolder: "Nome de Usuario",
                     text: $viewModel.username,
                     error: "Username Iválido",
                     failure: viewModel.username.count < 5)
    }
    
    var emailView: some View{
        EditTextView(placeHolder: "Email",
                     text: $viewModel.email,
                     error: "Email Iválido",
                     failure: false
                        //!viewModel.email.isEmail()
        )
    }
    
    var completeNameView: some View{
        /*TextField("Nome Completo",text: $completeName)
            .border(.black).padding(.horizontal, 40).autocapitalization(.none )
         */
        EditTextView(placeHolder: "Nome Completo", text: $viewModel.fullName, error: "Nome Ivalido", failure: viewModel.fullName.count < 3)
            
    }
    
    var lblSignUpTitle : some View{
        Text("Cadastro").foregroundColor(.mint)
            .font(.title.bold())
            .padding(.horizontal, 8)
    }
    
    var registerView : some View{
        VStack{
            
            
            ZStack{
                
                LoadingButtonView(action: {
                    viewModel.signUp()
                    
                },
                                  text: "Cadastrar",
                                  disabled: false,
                                    //viewModel.fullName.count < 3 || !viewModel.email.isEmail() || viewModel.password.count < 8 || !viewModel.document.isCPF() || !viewModel.phone.isAPhone() || viewModel.birthday.count != 10,
                                  showProgress: self.viewModel.uiState == SignUpUIState.loading
                )
                
            }//ZStack
        } //VStack
        
    }//registerView
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor()))
    }
}
