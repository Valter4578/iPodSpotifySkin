//
//  AlbumDetailViewModel.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 20.01.2024.
//

import Foundation
import SwiftUI

class AlbumDetailViewModel: ObservableObject {
    @Published var album: Album
    
    private var spotifyService: SpotifyService
    
    init(album: Album, spotifyService: SpotifyService) {
        self.album = album
        self.spotifyService = spotifyService
    }

    func getTracklist() -> [TracksItem] {
        return album.tracks?.items ?? []
    }
    
    func playTrack(item: TracksItem) {
        spotifyService.playTrack(trackURI: item.uri)
    }
}
