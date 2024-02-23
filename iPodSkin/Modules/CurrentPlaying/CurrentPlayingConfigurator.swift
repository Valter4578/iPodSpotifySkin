//
//  CurrentPlayingConfigurator.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 11.02.2024.
//

import Foundation

class CurrentPlayingConfigurator {
    
    static func configureCurrentPlayingView(with viewModel: CurrentPlayingViewModel) -> CurrentPlayingView {
        //        let coverFlowContainerView = CoverFlowContainerView(viewModel: viewModel)
        //        return coverFlowContainerView
//        let homeMenuView = HomeMenuView(viewModel: viewModel)
//        return homeMenuView
        let view = CurrentPlayingView(viewModel: viewModel)
        return view 
    }
}
