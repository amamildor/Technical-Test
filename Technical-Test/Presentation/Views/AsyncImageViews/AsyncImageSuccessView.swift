//
//  AsyncImageSuccessView.swift
//  Technical-Test
//
//  Created by Nicolas Favre on 25/03/2025.
//

import SwiftUI

struct AsyncImageSuccessView: View {
    var viewModel: AsyncImageSuccessViewModel
    
    var body: some View {
        switch viewModel.displayMode {
        case .circle(false):
            viewModel.image
                .resizable()
                .scaledToFit()
                .background(viewModel.backgroundColor)
                .clipShape(Circle())
                .overlay(Circle().stroke(viewModel.gradient, lineWidth: viewModel.strokeWidth))
        case .circle(true):
            viewModel.image
                .resizable()
                .scaledToFit()
                .background(viewModel.backgroundColor)
                .clipShape(Circle())
        case .cornerRadius(let cornerRadius, false):
            viewModel.image
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(viewModel.gradient, lineWidth: viewModel.strokeWidth)
                }
        case .cornerRadius(let cornerRadius, true):
            viewModel.image
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
    }
}
