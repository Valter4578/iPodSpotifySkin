//
//  CoverFlowContainerView.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 22.01.2024.
//

import SwiftUI

struct CoverFlowContainerView: View {
    @ObservedObject var viewModel: CoverFlowViewModel
    var body: some View {
        VStack {
            GeometryReader { geo in
                VStack {
                    CoverFlowView(itemWidth: 170,
                                  spacing: -20,
                                  rotation: 45,
                                  items: viewModel.albums) { album in
                        AsyncImage(url: URL(string: album.images[0].url)) { image in
                            image.image?.resizable()
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
    
}

//#Preview {
//    CoverFlowContainerView()
//}
