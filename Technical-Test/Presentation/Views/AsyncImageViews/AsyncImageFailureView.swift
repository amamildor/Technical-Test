//
//  AsyncImageFailureView.swift
//  Technical-Test
//
//  Created by Nicolas Favre on 25/03/2025.
//

import SwiftUI

struct AsyncImageFailureView: View {
    var viewModel: AsyncImageFailureViewModel
    
    var body: some View {
        switch viewModel.displayMode {
        case .circle:
            viewModel.image
                .resizable()
                .scaledToFit()
                .background(viewModel.backgroundColor)
                .clipShape(Circle())
                .overlay(Circle().stroke(viewModel.contentColor, lineWidth: 2))
        case .cornerRadius(let cornerRadius, _):
            viewModel.image
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(viewModel.contentColor)
                .frame(width: viewModel.backgroundWidth, height: viewModel.backgroundHeight)
                .background(viewModel.backgroundColor)
                .cornerRadius(cornerRadius)
        }
    }
}
