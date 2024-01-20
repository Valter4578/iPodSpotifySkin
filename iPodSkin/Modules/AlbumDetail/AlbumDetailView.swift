//
//  AlbumDetailView.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 20.01.2024.
//

import SwiftUI

struct AlbumDetailView: View {
    @ObservedObject var viewModel: AlbumDetailViewModel
    var body: some View {
        ScrollView {
            VStack {
                ForEach(Array(zip(viewModel.getTracklist().indices, viewModel.getTracklist())), id: \.0) { index, item in
                    TrackItemView(title: item.name)
                }
            }
        }
        .background(.white)
        .onAppear(perform: {
            print(viewModel.album.name)
        })
    }
}


//#Preview {
//    AlbumDetailView()
//}
