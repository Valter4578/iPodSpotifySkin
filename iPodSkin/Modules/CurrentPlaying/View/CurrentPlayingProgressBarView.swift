//
//  CurrentPlayingProgressBarView.swift
//  iPodSkinApp
//
//  Created by Максим Алексеев  on 24.02.2024.
//

import SwiftUI

struct CurrentPlayingProgressBarView: View {
    let progress: CGFloat
    let shadowColor = Color(uiColor: .lightGray).opacity(0.3)
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundStyle(
                        .white.gradient.shadow(.inner(color: shadowColor, radius: 8, x: 0, y: 3))
                        .shadow(.inner(color: shadowColor, radius: 8, x: 0, y: -3))
                            
                    )
                    .frame(width: geometry.size.width, height: 20)

                Rectangle()
                    .frame(
                        width: min(progress * geometry.size.width,
                                   geometry.size.width),
                        height: 20
                    )
                    .foregroundStyle(
                        LinearGradient(colors: [.blue, .blue.opacity(0.6)], startPoint: .top, endPoint: .bottom)
                    )
            }
        }
    }
}


//#Preview {
//    CurrentPlayingProgressBarView(progress: 0.5)
//}
