//
//  ContentView.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 05.11.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var spotifyService: SpotifyService
    var body: some View {
        VStack {
            
            
            Button(action: {
                spotifyService.connect()
            }, label: {
                Text("connect to spotify")
            })
            .background(.green)
            .frame(width: 100, height: 100)
            
            Spacer()
            
            ControlView()
                .frame(width: 230, height: 230, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(SpotifyService())
}
