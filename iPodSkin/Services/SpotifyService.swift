//
//  SpotifyService.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 06.11.2023.
//

import Foundation
import SwiftUI
import UIKit

class SpotifyService: NSObject  {
    // MARK: - Variables
    private let spotifyClientID = "6c212878ea394187a8a11c2a1f0c5d5d"
    private let spotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!
    var accessToken = ""
    private let secterKey = "7448a7dd574f4906b7d44f1308d214b7"
    
    private let stringScopes = [
        "user-read-email", "user-read-private",
        "user-read-playback-state", "user-modify-playback-state", "user-read-currently-playing",
        "streaming", "app-remote-control",
        "playlist-read-collaborative", "playlist-modify-public", "playlist-read-private", "playlist-modify-private",
        "user-library-modify", "user-library-read",
        "user-top-read", "user-read-playback-position", "user-read-recently-played",
        "user-follow-read", "user-follow-modify",
    ]
    
    var playURI = ""
    
    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
        appRemote.delegate = self
        if let accessToken = self.obtainAccessToken() {
            appRemote.connectionParameters.accessToken = accessToken
            self.accessToken = accessToken
        }
        return appRemote
    }()
    
    lazy var configuration = SPTConfiguration(
        clientID: spotifyClientID,
        redirectURL: spotifyRedirectURL
    )
    
    private var lastPlayerState: SPTAppRemotePlayerState?
    
    // MARK: - Functions
    func connect() {
        guard let _ = self.appRemote.connectionParameters.accessToken else {
            self.appRemote.authorizeAndPlayURI("", asRadio: false, additionalScopes: stringScopes)
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
    
    func handleAccessToken(from url: URL) {
        let parameters = appRemote.authorizationParameters(from: url)
        
        if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = accessToken
            self.accessToken = accessToken
            print("Access token:", accessToken)
            appRemote.connect()
            saveAccessToken(accessToken)
        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print(error_description)
        }
    }
    
    func nextTrack() {
        appRemote.playerAPI?.skip(toNext: { result, error in
            if let error = error {
                print("Error next track: \(error)")
                return
            }
            print("Skipped track: \(result)")
        })
    }
    
    func lastTrack() {
        appRemote.playerAPI?.skip(toPrevious: { result, error in
            if let error = error {
                print("Error last track: \(error)")
                return
            }
            print("Skipped track: \(result)")
        })
    }
    
    func pause() {
        
    }
    
    
    func play() {
        
    }
    
    //    MARK: - Private func
    private func saveAccessToken(_ accessToken: String) {
        UserDefaults.standard.setValue(accessToken, forKey: "accessToken")
        UserDefaults.standard.setValue(Date.now, forKey: "accessTokenSaveTime")
    }
    
    private func obtainAccessToken() -> String? {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken"),
              let accessTokenSaveTime = UserDefaults.standard.object(forKey: "accessTokenSaveTime") as? Date else { return nil }
        
        // check if access token was saved less than hour from current time
        if accessTokenSaveTime >= Date.now - 3600 {
            return accessToken
        }
        
        return nil
    }
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
