//
//  AlbumsView.swift
//  iPodSkinApp
//
//  Created by Максим Алексеев  on 22.11.2023.
//

import SwiftUI

struct AlbumsView: View {
    @ObservedObject var viewModel: AlbumsViewModel
    var body: some View {
        VStack(spacing: 0, content: {
            ForEach(viewModel.albums, id: \.id) { album in
                AlbumsItem(imageUrl: album.images[0].url, title: album.name, artistName: album.artists[0].name)
            }
        })
        .background(.white)
        .onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

//#Preview {
//    AlbumsView()
//}
