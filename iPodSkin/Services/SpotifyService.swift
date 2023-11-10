//
//  SpotifyService.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 06.11.2023.
//

import Foundation
import SwiftUI
import UIKit

class SpotifyService: NSObject, ObservableObject  {
    
    // MARK: - Variables
    private let spotifyClientID = "6c212878ea394187a8a11c2a1f0c5d5d"
    private let spotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!
    var accessToken = "access-token-key"
    private let secterKey = "7448a7dd574f4906b7d44f1308d214b7"
    
//    var responseCode: String? {
//        didSet {
//            fetchAccessToken { (dictionary, error) in
//                if let error = error {
//                    print("Fetching token request error \(error)")
//                    return
//                }
//                if let dictionary = dictionary {
//                    let accessToken = dictionary["access_token"] as! String
//                    DispatchQueue.main.async {
//                        self.appRemote.connectionParameters.accessToken = accessToken
//                        self.appRemote.connect()
//                    }
//                }
//            }
//        }
//    }
    
    private let scopes: SPTScope = [
                                .userReadEmail, .userReadPrivate,
                                .userReadPlaybackState, .userModifyPlaybackState, .userReadCurrentlyPlaying,
                                .streaming, .appRemoteControl,
                                .playlistReadCollaborative, .playlistModifyPublic, .playlistReadPrivate, .playlistModifyPrivate,
                                .userLibraryModify, .userLibraryRead,
                                .userTopRead, .userReadPlaybackState, .userReadCurrentlyPlaying,
                                .userFollowRead, .userFollowModify
                            ]

    var playURI = ""
    
    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
        //        appRemote.connectionParameters.accessToken = self.accessToken
        appRemote.delegate = self
        return appRemote
    }()
    
    lazy var configuration = SPTConfiguration(
        clientID: spotifyClientID,
        redirectURL: spotifyRedirectURL
    )
    
//    lazy var sessionManager: SPTSessionManager? = {
//        let manager = SPTSessionManager(configuration: configuration, delegate: self)
//        return manager
//    }()
    
    private var lastPlayerState: SPTAppRemotePlayerState?

    // MARK: - Functions
    func connect() {
        //        sessionManager?.initiateSession(with: scopes, options: .clientOnly)
        guard let _ = self.appRemote.connectionParameters.accessToken else {
            self.appRemote.authorizeAndPlayURI("")
            return
        }
        
        appRemote.connect()
    }
    
    func disconnect() {
        if (appRemote.isConnected) {
            appRemote.disconnect()
        }
    }
    
    func fetchAlbumCover(for track:SPTAppRemoteTrack, completionHandler: @escaping (Image) -> ()) {
        appRemote.imageAPI?.fetchImage(forItem: track, with: CGSize.zero, callback: { (image, error) in
            if let error = error {
                print("Error fetching track image: " + error.localizedDescription)
            } else if let image = image as? UIImage {
                completionHandler(Image(uiImage: image))
            }
        })
    }
    
    func fetchPlayerState() {
        appRemote.playerAPI?.getPlayerState({ [weak self] (playerState, error) in
            if let error = error {
                print("Error getting player state:" + error.localizedDescription)
            } else if let playerState = playerState as? SPTAppRemotePlayerState {
                print(playerState)
                self?.lastPlayerState = playerState
            }
        })
    }
    func fetchAccessToken(from url: URL) {
        let parameters = appRemote.authorizationParameters(from: url)
        
        if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = accessToken
            self.accessToken = accessToken
        } else if let errorDescription = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print(errorDescription)
        }
    }
    
    
//    func fetchAccessToken(completion: @escaping ([String: Any]?, Error?) -> Void) {
//           let url = URL(string: "https://spotify.com/api/token")!
//           var request = URLRequest(url: url)
//           request.httpMethod = "POST"
//           let spotifyAuthKey = "Basic \((spotifyClientID + ":" + secterKey).data(using: .utf8)!.base64EncodedString())"
//           request.allHTTPHeaderFields = ["Authorization": spotifyAuthKey,
//                                          "Content-Type": "application/x-www-form-urlencoded"]
//
//           var requestBodyComponents = URLComponents()
////           let scopeAsString = stringScopes.joined(separator: " ")
//
//           requestBodyComponents.queryItems = [
//               URLQueryItem(name: "client_id", value: spotifyClientID),
//               URLQueryItem(name: "grant_type", value: "authorization_code"),
//               URLQueryItem(name: "code", value: responseCode!),
//               URLQueryItem(name: "redirect_uri", value: spotifyRedirectURL.absoluteString),
////               URLQueryItem(name: "code_verifier", value: ""),
////               URLQueryItem(name: "scope", value: scopeAsString),
//           ]
//
//           request.httpBody = requestBodyComponents.query?.data(using: .utf8)
//
//           let task = URLSession.shared.dataTask(with: request) { data, response, error in
//               guard let data = data,
//                     let response = response as? HTTPURLResponse,
//                     (200 ..< 300) ~= response.statusCode,
//                     error == nil else {
//                         print("Error fetching token \(error?.localizedDescription ?? "")")
//                         return completion(nil, error)
//                     }
//               let responseObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
//               print("Access Token Dictionary=", responseObject ?? "")
//               completion(responseObject, nil)
//           }
//           task.resume()
//       }
}

// MARK: - SPTAppRemoteDelegate
extension SpotifyService: SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        // Connection was successful, you can begin issuing commands
        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
        })
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("disconnected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("failed: ", error?.localizedDescription)
    }
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        debugPrint("Track name: %@", playerState.track.name)
    }
}

// MARK: - SPTSessionManagerDelegate
extension SpotifyService: SPTSessionManagerDelegate {
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("connected", session)
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("failed with error: ", error.localizedDescription)
    }
}
