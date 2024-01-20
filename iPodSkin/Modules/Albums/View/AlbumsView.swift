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
            VStack {
                ForEach(Array(zip(viewModel.albums.indices, viewModel.albums)), id: \.0) { index, item in
                    NavigationLink {
                        AlbumDetailConfigurator.configureAlbumDetailView(with: item)
                    } label: {
                        AlbumsItem(imageUrl: item.images[0].url, title: item.name, artistName: item.artists[0].name)
                    }
                }
            }
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
