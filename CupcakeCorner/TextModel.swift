//
//  TextModel.swift
//  CupcakeCorner
//
//  Created by Nick Pavlov on 2/26/23.
//

import Foundation
import SwiftUI

struct TextModel: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title.bold())
            .multilineTextAlignment(.center)
            .overlay {
                LinearGradient(gradient: Gradient(colors: [.pink, .blue, .green]), startPoint: .leading, endPoint: .trailing)
                    .mask {
                        Text(text)
                            .font(.title.bold())
                            .multilineTextAlignment(.center)
                    }
            }
    }
}
