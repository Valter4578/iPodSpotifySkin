//
//  iPodSkinApp.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 05.11.2023.
//

import SwiftUI
import UIKit

@main
struct iPodSkinApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    @StateObject var spotifyService: SpotifyService = SpotifyService()
    @StateObject var networkService: NetworkService = NetworkService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(spotifyService)
                .environmentObject(networkService)
                .onOpenURL { url in
                    spotifyService.handleAccessToken(from: url)
                }
        }
    }
}
