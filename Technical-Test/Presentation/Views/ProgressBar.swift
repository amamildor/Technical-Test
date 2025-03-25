//
//  ProgressBar.swift
//  Technical-Test
//
//  Created by Nicolas Favre on 25/03/2025.
//

import SwiftUI

struct ProgressBar: View {
    var progress: CGFloat
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(height: 4)
                
                Capsule()
                    .fill(Color.white)
                    .frame(width: proxy.size.width * progress, height: 4)
            }
        }
        .frame(height: 4)
    }
}
