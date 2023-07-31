//
//  HabitDetailView.swift
//  HabitPlus
//
//  Created by coltec on 06/06/23.
//

import SwiftUI

struct HabitDetailView: View {
    
    @ObservedObject var viewModel: HabitDetailViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(viewModel: HabitDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ScrollView(showsIndicators: false){
            VStack(alignment: .center, spacing: 12){
                Text(viewModel.name)
                    .foregroundColor(.mint)
                    .font(.title.bold())
                
                Text("Unidade: \(viewModel.label)")
            }
            
            VStack{
                TextField("Escreva aqui o valor conquistado", text: $viewModel.value)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.numberPad)
                
                Divider()
                    .frame(height: 1)
                    .background(.gray)
            }.padding(.horizontal, 32)
            
            Text("Os registros devem ser feitos em até 24h.\nHábitos se constroem todos os dias xD")
            
            LoadingButtonView(action: {
                viewModel.save()
            },
                              text: "Salvar" ,
                              disabled: self.viewModel.value.isEmpty,
                              showProgress: self.viewModel.uiState == .loading)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            Button("Cancelar"){
                // dismiss / pop exit
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    withAnimation(.easeOut(duration: 2)){
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                  
              }
              .modifier(ButtonStyle())
              .padding(.horizontal, 115)
              
              Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.top, 32)
            .onAppear{
                viewModel.$uiState.sink { uiState in
                  if uiState == .success {
                    self.presentationMode.wrappedValue.dismiss()
                  }
                }.store(in: &viewModel.cancellables)
            }
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(viewModel: HabitDetailViewModel(id: 1, name: "Assistir aula", label: "horas", interactor: HabitDetailInteractor()))
    }
}
