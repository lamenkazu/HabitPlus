//
//  EditTextView.swift
//  HabitPlus
//
//  Created by coltec on 02/05/23.
//

import SwiftUI

struct EditTextView: View {
    
    var placeHolder: String = ""
    @Binding var text: String
    
    //Mensagem De Erro
    var error: String? = nil
    var failure: Bool? = nil
    
    var keyboard: UIKeyboardType = .default
    
    var isSecure: Bool = false
    
    var body: some View{
        VStack{
            
            if isSecure{
                
                SecureField(placeHolder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .autocapitalization(.none)
                    .textFieldStyle(CustomTextFieldStyle())
                
            }else{
                TextField(placeHolder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .autocapitalization(.none)
                    .textFieldStyle(CustomTextFieldStyle())
            }
            
            
                
            
            if let error = error, failure == true, !text.isEmpty {
                
                Text(error).foregroundColor(.red)
                
            }
            
        }
    }

}

struct EditTextView_Previews: PreviewProvider {
    static var previews: some View {
        //Visualizando o Dark Mode
        ForEach(ColorScheme.allCases, id: \.self){ value in
            EditTextView(placeHolder: "User", text: .constant("blablabla"))
                .preferredColorScheme(value) //DarkMode Call
        }
        
    }
}
