//
//  ScreenViewContainer.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 30.11.2023.
//

import SwiftUI

struct ScreenViewContainer<T: View>: View {
    // simple example that takes in one parameter.
    var daugtherView: T
    var isHalfView: Bool = false
    var title: String
    
    init(title: String, @ViewBuilder daugtherView: () -> T) {
        self.daugtherView = daugtherView()
        self.title = title
    }
    
    var body: some View {
        VStack(spacing: 0, content: {
            ScreenContainerTopBarView(title: title)
            
            NavigationStack(root: {
                daugtherView
            })
        })
        .clipShape(
            RoundedRectangle(cornerRadius: 10)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 4)
        )
    }
}

