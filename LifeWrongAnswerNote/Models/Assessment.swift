//
//  Assessment.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/04/30.
//

import Foundation
import SwiftUI

enum Assessment: Int64 {
    case notSure = 0, good, bad, soso
    
    var image: some View {
        switch(self) {
        case .notSure:
            return Image(systemName: "questionmark.circle").foregroundColor(.gray)
        case .good:
            return Image(systemName: "checkmark.circle").foregroundColor(.green)
        case .bad:
            return Image(systemName: "x.circle").foregroundColor(.red)
        case .soso:
            return Image(systemName: "triangle.circle").foregroundColor(.orange)
        }
    }
}
