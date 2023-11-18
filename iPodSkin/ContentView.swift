//
//  ContentView.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 05.11.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var spotifyService: SpotifyService
    @EnvironmentObject var networkService: NetworkService
    var body: some View {
        VStack {
            
            
            Button(action: {
                spotifyService.connect()

                networkService.accessToken = spotifyService.accessToken
                
                networkService.getAlbums(limit: 2) { result in
                    switch result {
                    case .success(let albums):
                        print(albums)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }, label: {
                Text("connect to spotify")
            })
            .background(.green)
            .frame(width: 100, height: 100)
            
            Spacer()
            
            ControlView(lastButtonPressed: {
                spotifyService.lastTrack()
            }, nextButtonPressed: {
                spotifyService.nextTrack()
            })
                .frame(width: 230, height: 230, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) 
        .background(
            LinearGradient(colors: [Color(red: 40/255, green: 40/255, blue: 41/255), Color(red: 103/255, green: 100/255, blue: 103/255)], startPoint: .bottom, endPoint: .top)

        )
    }
}

#Preview {
    ContentView()
        .environmentObject(SpotifyService())
        .environmentObject(NetworkService())
}
