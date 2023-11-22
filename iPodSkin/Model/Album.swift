//
//  Album.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 15.11.2023.
//

import Foundation

struct AlbumResponse: Codable {
    let href: String
    let items: [AlbumItemResponse]
    let limit: Int
    let next: String
    let offset: Int
//    let previous: JSONNull?
    let total: Int
}

struct AlbumItemResponse: Codable {
//    let addedAt: Date
    let album: Album

    enum CodingKeys: String, CodingKey {
//        case addedAt = "added_at"
        case album
    }
}

struct Album: Codable {
    let albumType: String
    let artists: [Artist]
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [SpotifyImage]
    let label: String
    let name: String
    let releaseDate, releaseDatePrecision: String
    let totalTracks: Int
    let tracks: Tracks
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
        case externalUrls = "external_urls"
        case href, id, images, label, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case tracks, type, uri
    }
}

// MARK: - Artist
struct Artist: Codable {
    let externalUrls: ExternalUrls
    let href: String
    let id, name: String
    let type: ArtistType
    let uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String
}

enum ArtistType: String, Codable {
    case artist = "artist"
}

// MARK: - Copyright
struct Copyright: Codable {
    let text, type: String
}

// MARK: - Image
struct SpotifyImage: Codable {
    let height: Int
    let url: String
    let width: Int
}

// MARK: - Tracks
struct Tracks: Codable {
    let href: String
    let items: [TracksItem]
    let limit: Int
    let offset: Int
    let total: Int
}

// MARK: - TracksItem
struct TracksItem: Codable {
    let artists: [Artist]
    let availableMarkets: [String]
    let discNumber, durationMS: Int
    let explicit: Bool
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let isLocal: Bool
    let name: String
    let previewURL: String?
    let trackNumber: Int
    let type: ItemType
    let uri: String

    enum CodingKeys: String, CodingKey {
        case artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalUrls = "external_urls"
        case href, id
        case isLocal = "is_local"
        case name
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
    }
}

enum ItemType: String, Codable {
    case track = "track"
}
