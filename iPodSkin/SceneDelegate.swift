////
////  SceneDelegate.swift
////  iPodSkin
////
////  Created by Максим Алексеев  on 05.11.2023.
////
//
//import Foundation
//import SwiftUI
//
//class SceneDelegate: UIResponder, UIWindowSceneDelegate, ObservableObject {
//
//    let spotifyService = SpotifyService()
//    var window: UIWindow?
////    MARK: - SceneDelegate
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let scene = (scene as? UIWindowScene) else { return }
//        let window = UIWindow(windowScene: windowScene)
//
//        
//    }
////    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
////        guard let windowScene = (scene as? UIWindowScene) else { return }
////        window = UIWindow(frame: UIScreen.main.bounds)
////        window!.makeKeyAndVisible()
////        window!.windowScene = windowScene
////        window!.rootViewController = rootViewController
////    }
//
//    
//    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//        guard let url = URLContexts.first?.url else { return }
//        let parameters = spotifyService.appRemote.authorizationParameters(from: url)
//        if let code = parameters?["code"] {
//            spotifyService.responseCode = code
//        } else if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
//            spotifyService.accessTokenKey = access_token
//        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
//            print("No access token error =", error_description)
//        }
//    }
////
////    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
////        guard let url = URLContexts.first?.url else {
////            return
////        }
////
////        let parameters = appRemote.authorizationParameters(from: url);
////
////        if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
////            appRemote.connectionParameters.accessToken = access_token
////            self.accessToken = access_token
////        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
////            // Show the error
////        }
//////        self.sessionManager
////    }
////    
////    func sceneDidBecomeActive(_ scene: UIScene) {
////        if let _ = self.appRemote.connectionParameters.accessToken {
////            self.appRemote.connect()
////        }
////    }
////    
////    func sceneWillResignActive(_ scene: UIScene) {
////        if self.appRemote.isConnected {
////            self.appRemote.disconnect()
////        }
////    }
////    // MARK: - SPTAppRemoteDelegate
////    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
////        // Connection was successful, you can begin issuing commands
////        self.appRemote.playerAPI?.delegate = self
////        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
////            if let error = error {
////                debugPrint(error.localizedDescription)
////            }
////        })
////    }
////    
////    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
////        print("disconnected")
////    }
////    
////    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
////        print("failed: ", error?.localizedDescription)
////    }
////    
////    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
////        debugPrint("Track name: %@", playerState.track.name)
////    }
////    // MARK: - SPTSessionManagerDelegate
////    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
////        print("success", session)
////        self.appRemote.connectionParameters.accessToken = session.accessToken
////        self.appRemote.connect()
////    }
////    
////    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
////        print("fail", error)
////    }
////    
////    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
////        print("renewed", session)
////    }
//}
