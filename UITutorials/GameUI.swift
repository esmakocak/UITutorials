//
//  GameUI.swift
//  UITutorials
//
//  Created by Esma Koçak on 5.08.2024.
//

import SwiftUI

struct GameUI: View {
    var body: some View {
        Game()
    }
}


struct Game: View {
    var body: some View {
        VStack {
            HStack{
                Text("Your Player")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName:  "line.horizontal.3.decrease")
                        .font(.title)
                        .foregroundColor(.white)
                }

                
            }
            .padding(.horizontal)
            .padding(.top)

            Spacer()
                
        }
        .background(LinearGradient(gradient: .init(colors: [Color("clr"), Color("Color1")]), startPoint: .top, endPoint: .bottom))
    }
}

#Preview {
    GameUI()
}
