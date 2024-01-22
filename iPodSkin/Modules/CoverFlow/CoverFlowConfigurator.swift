//
//  CoverFlowConfigurator.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 22.01.2024.
//

import Foundation

final class CoverFlowConfigurator {
    static func configureCoverFlow(with viewModel: CoverFlowViewModel) -> CoverFlowContainerView {
        let coverFlowContainerView = CoverFlowContainerView(viewModel: viewModel)
        return coverFlowContainerView
    }
}
