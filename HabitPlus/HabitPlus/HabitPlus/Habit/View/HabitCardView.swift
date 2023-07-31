//
//  HabitCardView.swift
//  HabitPlus
//
//  Created by coltec on 05/06/23.
//

import SwiftUI
import Combine

struct HabitCardView: View {
    
    let viewModel: HabitCardViewModel
    @State private var action = false
    
    var body: some View {
        ZStack(alignment: .trailing){
            
            NavigationLink(
                destination: viewModel.habitDetailView(),
                isActive: self.$action,
                label: {
                    EmptyView()
                }
            )
            Button(action: {
                self.action = true
            }, label:{
                HStack{
                    ImageView(url: viewModel.icon)
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .clipped()
                        .padding(.horizontal, 8)
                    
                    Spacer()
                    
                    HStack(alignment: .top){
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text(viewModel.name)
                                .foregroundColor(Color.blue)
                            
                            Text(viewModel.label)
                                .foregroundColor(Color("textColor"))
                                .bold()
                            
                            Text(viewModel.date)
                                .foregroundColor(Color("textColor"))
                                .bold()
                        }.frame(maxWidth: 300, alignment: .leading)                    }
                
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 4){
                        
                        Text("Registrado")
                            .foregroundColor(Color.blue)
                            .bold()
                            .multilineTextAlignment(.leading)
                        
                        Text(viewModel.value)
                            .foregroundColor(Color("textColor"))
                            .bold()
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                }
                .padding()
                .cornerRadius(4.0)
            })
            
            Rectangle()
                .frame(width: 8)
                .foregroundColor(viewModel.state)
            
        }.background(
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(Color.blue, lineWidth: 1.4)
                .shadow(color: .gray, radius: 2, x: 2.0, y: 2.0)
        )
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
    }

}

struct HabitCardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            List{
                HabitCardView(viewModel: HabitCardViewModel(id:1,
                                                            icon:"https://upload.wikimedia.org/wikipedia/commons/a/ac/IOS-Emblem.jpg",
                                                             date: "05/06/2023 20:11:00",
                                                             name: "Aula de iOS",
                                                             label: "horas",
                                                             value: "4",
                                                             state: .yellow,
                                                            habitPublisher: PassthroughSubject<Bool, Never>()
                    
                ))
            }
        }
    }
}
