//
//  iPodSkinApp.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 05.11.2023.
//

import SwiftUI

@main
struct iPodSkinApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}