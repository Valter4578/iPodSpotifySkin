//
//  CurrentPlayingView.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 11.02.2024.
//

import SwiftUI

struct CurrentPlayingView: View {
    @ObservedObject var viewModel: CurrentPlayingViewModel
    var body: some View {
        HStack {

            AsyncImage(url: viewModel.getImageUrl()) { image in
                image
                    .resizable()
                    .frame(width: 150, height: 150)
                    .rotation3DEffect(
                        .degrees(10),
                        axis: (x: 0.1, y: 1.0, z: 0.0)
                    )
            } placeholder: {
                Color.green
            }
            
            
            VStack(alignment: .leading, content: {
                Spacer()
                Text(viewModel.getTrackName())
                    .font(.system(size: 18, weight: .bold))
                
                Text(viewModel.getArtistsName())
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.gray)
                
                Text(viewModel.getAlbumName())
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.gray)
                    .lineLimit(5)
            })
            .frame(height: 150)
            .padding(.bottom, 50)
        }
        .onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

//#Preview {
//    CurrentPlayingView()
//}
