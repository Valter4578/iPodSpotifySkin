//
//  CurrentPlayingViewModel.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 11.02.2024.
//

import Foundation
import SwiftUI
import Combine

struct CurrentPlayingModel {
    
}

class CurrentPlayingViewModel: ObservableObject {
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    
    @Published var currentPlayingResponse: CurrentPlayingResponse?
    //    var album: Album?
    //    var trackNumber: Int = 0
    
    private var spotifyService: SpotifyService
    private var networkService: Networkable
    
    // MARK: - Inits
    //    init(album: Album, trackNumber: Int = 0, spotifyService: SpotifyService) {
    //    init(spotifyService: SpotifyService) {
    //        self.album = album
    //        self.trackNumber = trackNumber
    //        self.spotifyService = spotifyService
    //        spotifyService.$lastPlayerState
    //            .print()
    //            .sink { state in
    ////                self.album = state.track.album
    ////                self.trackNumber = state.track.name
    //
    //            }
    //            .store(in: &cancellables)
    //    }
    
    init(networkService: Networkable, spotifyService: SpotifyService) {
        self.networkService = networkService
        self.spotifyService = spotifyService
    }
    
    // MARK: - Functions
    func getImageUrl() -> URL? {
        //        return URL(string: album.images[0].url)
        //        return URL(string: "")
        return URL(string: currentPlayingResponse?.item.album.images[0].url ?? "")
    }
    
    func getTrackName() -> String {
        //        return album.tracks.items[trackNumber].name
        //        return "123"
        return currentPlayingResponse?.item.name ?? ""
    }
    
    func getAlbumName() -> String {
        //        return album.name
        return currentPlayingResponse?.item.album.name ?? ""
    }
    
    func getArtistsName() -> String {
        return currentPlayingResponse?.item.artists.map { $0.name }.joined(separator: " ") ?? ""
    }
    
    private func getCurrentPlaying() {
        self.networkService.getCurrentPlaying()
            .print("ViewModel: ")
            .receive(on: DispatchQueue.main)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] response in
                self?.currentPlayingResponse = response
            }
            .store(in: &cancellables)
    }
    
    func onAppear() {
        spotifyService.fetchPlayerState()
        spotifyService.$lastPlayerState
            .sink { [weak self] _ in
                self?.getCurrentPlaying()
            }
            .store(in: &cancellables)
    }
}
