//
//  CurrentPlayingView.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 11.02.2024.
//

import SwiftUI

struct CurrentPlayingView: View {
    @ObservedObject var viewModel: CurrentPlayingViewModel
    
    @State private var rotationDegrees = 0.0
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var currentPlayingSeconds: Int = 0
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack(alignment: .center) {
                    AsyncImage(url: viewModel.getImageUrl()) { image in
                        image
                            .resizable()
                            .frame(width: 150, height: 150)
                            .rotation3DEffect(
                                .degrees(10),
                                axis: (x: 0.1, y: 1.0, z: 0.0)
                            )
                    } placeholder: {
                        // TODO: - Add placeholder image
                        Rectangle()
                            .frame(width: 150, height: 150)
                            .opacity(0)
                    }
                    .padding(.leading, 10)
                    
                    Spacer()
                    
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
                    .frame(width: geo.size.width / 2)
                    .padding(.bottom, 50)
                }
                .padding(.top, 20)
                
                HStack {
                    Text(viewModel.getFormattedPlayingTime())
                        .onReceive(viewModel.timer) { _ in
                            viewModel.updateProgress()
                        }
                    CurrentPlayingProgressBarView(progress: viewModel.progress)
                        .frame(height: 20)
                    Text(viewModel.getTrackTotalLength())
                }
                .padding(.horizontal, 20)
            }
        }
        .onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

//#Preview {
//    CurrentPlayingView()
//}
