//
//  AlbumsView.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 26.11.2023.
//

import SwiftUI

struct AlbumsView: View {
    @ObservedObject var viewModel: AlbumsViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0, content: {
                ForEach(Array(zip(viewModel.albums.indices, viewModel.albums)), id: \.0) { index, item in
                    NavigationLink {
                        AlbumDetailConfigurator.configureAlbumDetailView(with: item, spotifyService: viewModel.spotifyService)
                    } label: {
                        AlbumsItemView(imageUrl: item.images[0].url, title: item.name, artistName: item.artists[0].name)
                    }
                }
            })
        }
        .background(.white)
        .onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

//
//#Preview {
//    AlbumsView()
//}
