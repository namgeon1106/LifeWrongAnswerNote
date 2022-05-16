//
//  Assessment.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/09.
//

import Foundation
import SwiftUI

enum Assessment: Int16 {
    case notSure = 0, good, bad, soso
    
    var image: some View {
        switch(self) {
        case .notSure:
            return Image(systemName: "questionmark.circle").foregroundColor(.gray)
        case .good:
            return Image(systemName: "circle.circle").foregroundColor(.blue)
        case .bad:
            return Image(systemName: "x.circle").foregroundColor(.red)
        case .soso:
            return Image(systemName: "triangle.circle").foregroundColor(.orange)
        }
    }
    
    var description: String {
        switch(self) {
        case .notSure:
            return "모르겠음"
        case .good:
            return "좋음"
        case .bad:
            return "나쁨"
        case .soso:
            return "중간"
        }
    }
    
    static var allValues: [Assessment] {
        return [.notSure, .good, .bad, .soso]
    }
}
