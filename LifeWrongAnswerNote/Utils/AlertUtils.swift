//
//  Utils.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/02.
//

import Foundation
import UIKit

class AlertUtils {
    static var alertTextInput = ""
    
    static func displayAlertViewWithTextField(title: String, message: String, placeholder: String, okAction: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { name in
            name.placeholder = placeholder
        }
            
        let addCategoryAction = UIAlertAction(title: "확인", style: .default) { _ in
            alertTextInput = (alert.textFields?[0].text)!
            okAction()
        }
            
        let cancelAction = UIAlertAction(title: "취소", style: .destructive) { _ in
            print("Cancel clicked")
        }
            
        alert.addAction(addCategoryAction)
        alert.addAction(cancelAction)
            
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
            
        windowScenes?.windows.first?.rootViewController?.present(alert, animated: true)
    }
}
