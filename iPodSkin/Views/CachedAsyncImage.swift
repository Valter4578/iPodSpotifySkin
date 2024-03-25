//
//  CachedAsyncImage.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 25.03.2024.
//

import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {

    private let imageCache: NSCache<NSString, CacheEntryObject> = NSCache()
    private let url: URL?
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    init(
        url: URL?,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    var body: some View {
        if let url = url {
            if let cached = imageCache[url] {
                let _ = print("cached \(url.absoluteString)")
                //            content(.success(Image(uiImage: image)))
                content(.success(cached.image))
            } else {
                let _ = print("request \(url.absoluteString)")
                AsyncImage(
                    url: url,
                    scale: scale,
                    transaction: transaction
                ) { phase in
                    cacheAndRender(phase: phase)
                }
            }
        }
    }

    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase,
         let url = url {
//            ImageCache[url] = ima
//            imageCache.setObject(CacheEntryObject(image: image), forKey: url.absoluteString as NSString)
            imageCache[url] = CacheEntryObject(image: image)
        }

        return content(phase)
    }
}

