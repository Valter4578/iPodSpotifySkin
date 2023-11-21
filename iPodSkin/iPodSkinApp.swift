//
//  iPodSkinApp.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 05.11.2023.
//

import SwiftUI
import UIKit

@main
struct iPodSkinApp: App {
    let view: iPodView =  iPodConfigurator.configureIpodView()
    
    var body: some Scene {
        WindowGroup {
            view
                .onOpenURL { url in
                    view.viewModel.handleAccessToken(url: url)
                }
        }
    }
}
