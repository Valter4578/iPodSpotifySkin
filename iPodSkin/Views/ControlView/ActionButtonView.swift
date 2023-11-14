//
//  ActionButtonView.swift
//  iPodSkinApp
//
//  Created by Максим Алексеев  on 14.11.2023.
//

import SwiftUI

struct ActionButtonView: View {
    var body: some View {
        Circle()
            .fill(.gray)
            .stroke(.black, lineWidth: 0.7)
            .fill(
                LinearGradient(colors: [Color(red: 40/255, green: 40/255, blue: 41/255), Color(red: 103/255, green: 100/255, blue: 103/255)], startPoint: .top, endPoint: .bottom)
            )
    }
}

#Preview {
    ActionButtonView()
        .frame(width: 100, height: 1000, alignment: .center)
}
