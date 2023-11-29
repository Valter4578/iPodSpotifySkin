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
        VStack {
            ForEach(Array(zip(viewModel.albums.indices, viewModel.albums)), id: \.0) { index, item in
                AlbumsItem(imageUrl: item.images[0].url, title: item.name, artistName: item.artists[0].name)
            }
        }
        .background(.white)
        .onAppear(perform: {
            viewModel.fetchAlbumList(limit: 20)
        })
    }
}

//
//#Preview {
//    AlbumsView()
//}
