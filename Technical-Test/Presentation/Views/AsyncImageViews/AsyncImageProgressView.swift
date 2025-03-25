//
//  AsyncImageProgressView.swift
//  Technical-Test
//
//  Created by Nicolas Favre on 25/03/2025.
//

import SwiftUI

struct AsyncImageProgressView: View {
    var viewModel: AsyncImageProgressViewModel
    
    var body: some View {
        switch viewModel.displayMode {
        case .circle:
            ProgressView()
                .background(viewModel.backgroundColor)
                .clipShape(Circle())
        case .cornerRadius(let cornerRadius, _):
            ProgressView()
                .background(viewModel.backgroundColor)
                .cornerRadius(cornerRadius)
        }
    }
}
