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

    init(@ViewBuilder daugtherView: () -> T) {
        self.daugtherView = daugtherView()
    }

    var body: some View {
        // You can modify your viewes here.
        daugtherView
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 4)
            )
    }
}

