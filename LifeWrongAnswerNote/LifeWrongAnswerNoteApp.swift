//
//  LifeWrongAnswerNoteApp.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/03.
//

import SwiftUI

@main
struct LifeWrongAnswerNoteApp: App {
    init() {
        CoreDataManager.shared.load(forTest: false)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
