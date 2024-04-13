//
//  CoverFlowDetailView.swift
//  iPodSkinApp
//
//  Created by Максим Алексеев  on 12.04.2024.
//

import SwiftUI

struct CoverFlowDetailView: View {
    var title: String
    var artistName: String
    
    var tracks: [String]
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 24, weight: .bold))
                    Text(artistName)
                        .font(.system(size: 22, weight: .bold))
                }
                Spacer()
            }
            .foregroundStyle(.white)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: Color.coverFlowHeaderGradientColors, startPoint: .top, endPoint: .bottom)
            )
            
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    ForEach(tracks, id: \.self, content: { track in
                        Text(track)
                            .font(.system(size: 20, weight: .regular))
                    })
                }
            }
        }
        .background(Color.white)
    }
}

#Preview {
    CoverFlowDetailView(title: "VULTURES 1", artistName: "Kanye West, TY dolla sign", tracks: ["BURN", "Keys to life", "Vultures", "Good morning"])
}
