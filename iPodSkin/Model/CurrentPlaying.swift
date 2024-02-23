//
//  CurrentPlaying.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 23.02.2024.
//

import Foundation

struct CurrentPlayingResponse: Codable {
    let device: Device
    let repeatState: String
    let shuffleState: Bool
    let context: Context
    let timestamp, progressMS: Int
    let isPlaying: Bool
    let item: CurrentPlayingItem
    let currentlyPlayingType: String
//    let actions: Actions

    enum CodingKeys: String, CodingKey {
        case device
        case repeatState = "repeat_state"
        case shuffleState = "shuffle_state"
        case context, timestamp
        case progressMS = "progress_ms"
        case isPlaying = "is_playing"
        case item
        case currentlyPlayingType = "currently_playing_type"
//        case actions
    }
}

struct Context: Codable {
    let type, href: String
    let externalUrls: ExternalUrls
    let uri: String

    enum CodingKeys: String, CodingKey {
        case type, href
        case externalUrls = "external_urls"
        case uri
    }
}

// MARK: - Device
struct Device: Codable {
    let id: String
    let isActive, isPrivateSession, isRestricted: Bool
    let name, type: String
    let volumePercent: Int
    let supportsVolume: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case isActive = "is_active"
        case isPrivateSession = "is_private_session"
        case isRestricted = "is_restricted"
        case name, type
        case volumePercent = "volume_percent"
        case supportsVolume = "supports_volume"
    }
}

// MARK: - Item
struct CurrentPlayingItem: Codable {
    let album: Album
    let artists: [Artist]
    let availableMarkets: [String]
    let discNumber, durationMS: Int
    let explicit: Bool
//    let externalIDS: ExternalIDS
    let externalUrls: ExternalUrls
    let href, id: String
    let isPlayable: Bool?
//    let linkedFrom: LinkedFrom
//    let restrictions: Restrictions
    let name: String
    let popularity: Int
    let previewURL: String
    let trackNumber: Int
    let type, uri: String
    let isLocal: Bool

    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
//        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id
        case isPlayable = "is_playable"
//        case linkedFrom = "linked_from"
        case name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
        case isLocal = "is_local"
    }
}
