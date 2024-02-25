//
//  CurrentPlayingViewModel.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 11.02.2024.
//

import Foundation
import SwiftUI
import Combine

class CurrentPlayingViewModel: ObservableObject {
    // MARK: - Dependencies
    private var spotifyService: SpotifyService
    private var networkService: Networkable
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    
    @Published var currentPlayingResponse: CurrentPlayingResponse?
    
    @Published var currentPlayingSeconds: Int = 0
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var progress: CGFloat = 0.0
        
    // MARK: - Inits
    init(networkService: Networkable, spotifyService: SpotifyService) {
        self.networkService = networkService
        self.spotifyService = spotifyService
    }
    
    // MARK: - Functions
    func getImageUrl() -> URL? {
        return URL(string: currentPlayingResponse?.item.album.images[0].url ?? "")
    }
    
    func getTrackName() -> String {
        return currentPlayingResponse?.item.name ?? ""
    }
    
    func getAlbumName() -> String {
        return currentPlayingResponse?.item.album.name ?? ""
    }
    
    func getArtistsName() -> String {
        return currentPlayingResponse?.item.artists.map { $0.name }.joined(separator: " ") ?? ""
    }
    
    func getTrackTotalLength() -> String {
        guard let response = currentPlayingResponse else { return "--:--" }
        
        var seconds = response.item.durationMS / 1000
        let minutes = seconds / 60
        seconds = seconds - (minutes * 60)
        return String("\(minutes):\(seconds < 10 ? "0" : "")\(seconds)")
    }
    
    func getFormattedPlayingTime() -> String {
        let minutes = currentPlayingSeconds / 60
        let seconds = currentPlayingSeconds - (minutes * 60)
        return String("\(minutes):\(seconds < 10 ? "0" : "")\(seconds)")
    }
    
    func getCurrentPlaying() {
        self.networkService.getCurrentPlaying()
            .print("ViewModel: ")
            .receive(on: DispatchQueue.main)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] response in
                if response.isPlaying {
                    self?.currentPlayingSeconds = response.progressMS / 1000
                    self?.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                } else {
                    self?.timer.upstream.connect().cancel()
                }
                
                self?.currentPlayingResponse = response
            }
            .store(in: &cancellables)
    }
    
    func updateProgress() {
        currentPlayingSeconds += 1
        progress = CGFloat(currentPlayingSeconds) / CGFloat(((currentPlayingResponse?.item.durationMS ?? 0) / 1000))
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
