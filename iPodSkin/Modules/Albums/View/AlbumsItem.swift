//
//  AlbumsItem.swift
//  iPodSkinApp
//
//  Created by Максим Алексеев  on 22.11.2023.
//

import SwiftUI

struct AlbumsItem: View {
    var imageUrl: String
    var title: String
    var artistName: String
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image.image?.resizable()
            }
            .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 0, content: {
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.black)
                Text(artistName)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(.black)
            })
            .padding(.vertical, 20)
            Spacer()
            
        }
        .frame(height: 50, alignment: .center)
    }
}

//#Preview {
//    AlbumsItem(imageUrl: , title: "Forever story", artistName: "JID")
//}
