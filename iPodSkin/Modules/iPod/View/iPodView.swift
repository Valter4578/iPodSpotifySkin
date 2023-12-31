//
//  iPodView.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 21.11.2023.
//

import SwiftUI

struct iPodView: View {
    @ObservedObject var viewModel: iPodViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    viewModel.connectPressd()
                }, label: {
                    Text("connect to spotify")
                })
                .background(.green)
                .frame(width: 100, height: 100)
                
//                NavigationLink(destination: AlbumsView(viewModel: AlbumsViewModel(networkService: viewModel.networkService))) {
//                    Text("Albums")
//                }
                
                ScreenViewContainer {
                    iPodRouter.destinationForAlbumList(using: viewModel.networkService)
                }
                .padding(.bottom, 61)
                .padding(.horizontal, 30)
                .padding(.top, 30)
                
                ControlView(lastButtonPressed: {
                    viewModel.lastPressed()
                }, nextButtonPressed: {
                    viewModel.nextPressed()
                })
                .frame(width: 230, height: 230, alignment: .center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(colors: [Color(red: 40/255, green: 40/255, blue: 41/255), Color(red: 103/255, green: 100/255, blue: 103/255)], startPoint: .bottom, endPoint: .top)
            )
        }
    }
}

//#Preview {
//    iPodView(viewModel: iPodViewModel(spotifyService: <#SpotifyService#>, networkService: <#Networkable#>))
//}
