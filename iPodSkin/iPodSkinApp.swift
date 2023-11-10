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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(spotifyService)
                .onOpenURL { url in
//                    let parameters = spotifyService.appRemote.authorizationParameters(from: url)
//                    if let code = parameters?["code"] {
//                        spotifyService.responseCode = code
//                    } else if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
//                        spotifyService.accessTokenKey = access_token
//                    } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
//                        print("No access token error =", error_description)
//                    }
                    spotifyService.fetchAccessToken(from: url)
                }
        }
    }
}
