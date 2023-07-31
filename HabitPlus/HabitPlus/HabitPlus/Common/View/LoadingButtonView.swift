//
//  LoadingButtonView.swift
//  HabitPlus
//
//  Created by coltec on 04/05/23.
//

import SwiftUI

struct LoadingButtonView: View {
    
    var action: () -> Void;
    var text: String;
    
    
    var disabled : Bool = true;
    var showProgress: Bool = false;
    
    var body: some View {
        
        ZStack{
            Button{
                action()
            } label: {
                Text(showProgress ? "" : text)
                    .frame(maxWidth: .infinity)
                    .font(Font.system(.title).bold())
                    .padding(.vertical, 5)
                    .border(.mint)
                    .background(disabled ? Color("lightBlue") : Color.mint)
                    .foregroundColor(.white) //Cor do Texto
                    .cornerRadius(10.0)
            }
            .disabled(disabled || showProgress)
            .padding(.horizontal, 100)
            
            ProgressView() // Exibe ProgressView. Exibe com opacidade.
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(showProgress ? 1 : 0)
            
            
        }
        
    }
}

struct LoadingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingButtonView(action: {}, text: "Botao" )
    }
}
