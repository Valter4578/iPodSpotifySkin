//
//  AlbumsView.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 18.11.2023.
//

import SwiftUI

struct AlbumsView: View {
    @ObservedObject var viewModel: AlbumsViewModel
    
    var body: some View {
        VStack {
            Text("Albums")
            ForEach(Array(zip(viewModel.albums.indices, viewModel.albums)), id: \.0) { index, item in
                
                Text("\(index)) \(item.name)")
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

//#Preview {
//    AlbumsView()
//}
