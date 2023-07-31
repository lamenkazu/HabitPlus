//
//  HabitView.swift
//  HabitPlus
//
//  Created by coltec on 05/06/23.
//

import SwiftUI

struct HabitView: View {
    
    @ObservedObject var viewModel: HabitViewModel
    
    var body: some View {
        
        ZStack{
            if case HabitUIState.loading = viewModel.uiState{
                progress
            }else {
                
                NavigationView{
                    ScrollView(showsIndicators: false){
                        VStack{
                            topContainer
                            
                            addButton
                            
                            if case HabitUIState.emptyList = viewModel.uiState{
                                
                                VStack{
                                    Image(systemName: "exclamationmark.octagon.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24, alignment: .center)
                                    Text("Nenhum habito encontrado ;-;")
                                }
                                
                            }else if case HabitUIState.fullList(let rows) = viewModel.uiState{
                                
                                LazyVStack{
                                    ForEach(rows, content: HabitCardView.init(viewModel:))
                                }
                                .padding(.horizontal, 14)
                                
                            }else if case HabitUIState.error(let message) = viewModel.uiState{
                                
                                Text("")
                                    .alert(isPresented: .constant(true)){
                                        Alert(title: Text("Ops! \(message)"),
                                              message: Text("Tentar novamente?"),
                                              primaryButton:  .default(Text("Sim")){
                                                    //aqui tenta de novo
                                                viewModel.onAppear()
                                            },
                                              secondaryButton: .cancel()
                                              
                                        )
                                    }
                                
                            }
                        }
                    }
                }
                .navigationTitle("Meus Habitos")
                
            }
                
        }
        .onAppear{
            if !viewModel.opened{
                viewModel.onAppear()
            }
        }
        
    }
}
extension HabitView{
    
    var topContainer: some View{
        VStack(alignment: .center, spacing: 12){
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50, alignment: .center)
            
            Text(viewModel.title)
                .font(Font.system(.title).bold())
                .foregroundColor(.mint)
            
            Text(viewModel.headline)
                .font(Font.system(.title3).bold())
                .foregroundColor(Color("textColor"))
            
            Text(viewModel.description)
                .font(Font.system(.subheadline).bold())
                .foregroundColor(Color("textColor"))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
    
    var addButton: some View{
        NavigationLink(
            destination: Text("Tela de adicionar")
                .frame(maxWidth: .infinity, maxHeight: .infinity)){
                    Label("Criar Habito", systemImage: "plus.app")
                        .modifier(ButtonStyle())
                }
                .padding(.horizontal, 50)
    }
    
    var progress: some View{
        ProgressView()
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(viewModel: HabitViewModel(interactor: HabitInteractor()))
    }
}
