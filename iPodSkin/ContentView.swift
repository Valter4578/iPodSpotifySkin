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
        Button(action: {
            spotifyService.connect()
        }, label: {
            Text("connect to spotify")
        })
        .background(.green)
        .frame(width: 100, height: 100)
    }
}

#Preview {
    ContentView()
        .environmentObject(SpotifyService())
}
