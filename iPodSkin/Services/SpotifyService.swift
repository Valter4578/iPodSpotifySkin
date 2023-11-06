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
    private let SpotifyClientID = "6c212878ea394187a8a11c2a1f0c5d5d"
    private let SpotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!
    private let accessTokenKey = "access-token-key"
    
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
        clientID: SpotifyClientID,
        redirectURL: SpotifyRedirectURL
    )
    
    lazy var sessionManager: SPTSessionManager? = {
        let manager = SPTSessionManager(configuration: configuration, delegate: self)
        return manager
    }()
    
    private var lastPlayerState: SPTAppRemotePlayerState?

    // MARK: - Functions
    func connect() {
        sessionManager?.initiateSession(with: scopes, options: .clientOnly)
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
