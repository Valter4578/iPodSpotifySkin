//
//  ScreenContainerTopBarView.swift
//  iPodSkinApp
//
//  Created by Максим Алексеев  on 30.11.2023.
//

import SwiftUI

struct ScreenContainerTopBarView: View {
    var title: String
    var body: some View {
        HStack(alignment: .center, content: {
            Text(title)
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(.black)
                .padding(.leading, 10)
            
            Spacer()
        })
        .frame(height: 20)
        .background(
            LinearGradient(colors: [Color(uiColor: UIColor.lightGray), .white], startPoint: .bottom, endPoint: .top)
        )
    }
}

#Preview {
    ScreenContainerTopBarView(title: "Now playing")
}
