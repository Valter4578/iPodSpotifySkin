//
//  TrackItemView.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 20.01.2024.
//

import SwiftUI

struct TrackItemView: View {
    var title: String
    
    var body: some View {
        HStack(alignment: .center, content: {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.black)
            Spacer()
        })
    }
}

