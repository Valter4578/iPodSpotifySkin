//
//  CoverFlowContainerView.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 22.01.2024.
//

import SwiftUI

struct CoverFlowContainerView: View {
    @ObservedObject var viewModel: CoverFlowViewModel
    @State private var callOffset: Int = 0

    var body: some View {
        VStack {
            GeometryReader { geo in
                VStack {
                    CoverFlowView(itemWidth: 170,
                                  spacing: -20,
                                  rotation: 45,
                                  coverItems: viewModel.coverItems) { coverItem in
                        getCoverItemView(item: coverItem)
                            .rotation3DEffect(coverItem.flipped ? Angle(degrees: 180) : .zero, axis: (x: 0, y: 1, z: 0), anchor: .center)
                            .scaleEffect(coverItem.flipped ? CGSize(width: 1.4, height: 1.4) : CGSize(width: 1.0, height: 1.0), anchor: .center)
                            .task {
                                if coverItem.data.id == viewModel.albums.last?.id {
                                    callOffset += 1
                                    await viewModel.fetchAlbumList(limit: 20, offsetCoff: callOffset)
                                }
                            }
                    }
                }
                .frame(height: geo.size.height)
            }
        }
        .onAppear(perform: {
            viewModel.onAppear()
        })
    }
    
    @ViewBuilder
    func getCoverItemView(item: CoverFlowItem) -> some View {
        if item.flipped {
            CoverFlowDetailView(title: item.data.name, artistName: item.data.artists[0].name, tracks: item.data.tracks?.items.map { $0.name } ?? [])
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0), anchor: .center)
        } else {
            CacheAsyncImage(url: URL(string: item.data.images[0].url)) { image in
                image.image?.resizable()
            }
        }
    }
    
}

//#Preview {
//    CoverFlowContainerView()
//}
