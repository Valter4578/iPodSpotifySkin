//
//  HomeMenuViewModel.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 24.01.2024.
//

import Foundation
import SwiftUI

class HomeMenuViewModel: ObservableObject {
    var networkService: Networkable
    
    init(networkService: Networkable) {
        self.networkService = networkService
    }
}
