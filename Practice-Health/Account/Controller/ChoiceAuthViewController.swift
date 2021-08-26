//
//  ChoiceAuthViewController.swift
//  ChoiceAuthViewController
//
//  Created by 김효준 on 2021/08/26.
//

import UIKit

class ChoiceAuthViewController: UIViewController {

    
}

// MARK: -  키패드 관련

extension ChoiceAuthViewController {
    
    // MARK: Override Method
    
    /* 여백 터치하면 키패드 내림 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
}
