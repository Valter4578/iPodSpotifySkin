//
//  HomeMenuConfigurator.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 24.01.2024.
//

import Foundation

final class HomeMenuConfigurator {
    static func configureHomeMenu(with viewModel: HomeMenuViewModel) -> HomeMenuView {
//        let coverFlowContainerView = CoverFlowContainerView(viewModel: viewModel)
//        return coverFlowContainerView
        let homeMenuView = HomeMenuView(viewModel: viewModel)
        return homeMenuView
    }
}
