//
//  AsyncImageSuccessViewModel.swift
//  Technical-Test
//
//  Created by Nicolas Favre on 25/03/2025.
//

import SwiftUI

struct AsyncImageSuccessViewModel {
    let displayMode: DisplayMode
    let image: Image
    var backgroundColor: Color = .clear
    var hasBeenSeen: Bool
    
    var gradient: LinearGradient {
        if hasBeenSeen {
            .init(gradient: userCardSeenGradient, startPoint: .leading, endPoint: .trailing)
        } else {
            .init(gradient: userCardUnseenGradient, startPoint: .leading, endPoint: .trailing)
        }
        
    }
    
    var strokeWidth: CGFloat {
        if hasBeenSeen {
            2
        } else {
            4
        }
        
    }
}
