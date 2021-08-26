//
//  MainViewController.swift
//  MainViewController
//
//  Created by 김효준 on 2021/08/18.
//

import UIKit

// MARK: Main Page Main Code

class MainViewController: UIViewController {
    
    // MARK: - Override Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Action Method
    
}
