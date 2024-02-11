//
//  HomeMenuView.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 23.01.2024.
//

import SwiftUI

struct HomeMenuView: View {
    @ObservedObject var viewModel: HomeMenuViewModel
    
    var body: some View {
        HStack {
            HStack {
                Spacer()
                VStack {
                    NavigationLink {
                        HomeMenuRouter.destinationForCoverFlow(using: viewModel.networkService)
                    } label: {
                        Text("Cover Flow")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.black)
                    }
                    
                    NavigationLink {
                        HomeMenuRouter.destinationForAlbumList(using: viewModel.networkService)
                    } label: {
                        Text("Albums list")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.black)
                    }
                }
                .background(.white)
                
                Spacer()
            }
            Color.red
        }
    }
}

//#Preview {
//    HomeMenuView()
//}
