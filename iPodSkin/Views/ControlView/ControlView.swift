//
//  ControlView.swift
//  iPodSkinApp
//
//  Created by Максим Алексеев  on 14.11.2023.
//

import SwiftUI

struct ControlView: View {
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                print("last buttom pressed")
            }, label: {
                Image("last")
                    .resizable()
                .frame(width: 20, height: 10)            })
            .frame(width: 100, height: 150)
            .background(Color(red: 33/255, green: 33/255, blue: 34/255))
            
            VStack(spacing: 0) {
                Button(action: {
                    print("Menu buttom pressed")
                }, label: {
                    Text("MENU")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundStyle(.white)
                })
                .frame(width: 150, height: 100)
                .background(Color(red: 33/255, green: 33/255, blue: 34/255))
                
                ActionButtonView()
                    .frame(width: 82, height: 82, alignment: .center)
                
                Button(action: {
                    print("pause buttom pressed")
                }, label: {
                    Image("play")
                        .resizable()
                        .frame(width: 26, height: 12)
                })
                .frame(width: 150, height: 100)
                .background(Color(red: 33/255, green: 33/255, blue: 34/255))
            }
            
            Button(action: {
                print("next buttom pressed")
            }, label: {
                Image("next")
                    .resizable()
                    .frame(width: 20, height: 10)
            })
            .frame(width: 100, height: 150)
            .background(Color(red: 33/255, green: 33/255, blue: 34/255))
        }
        .background(Color(red: 33/255, green: 33/255, blue: 34/255))
        .clipShape(Circle())
    }
}

#Preview {
    ControlView()
}
