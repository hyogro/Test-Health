//
//  ChoiceAuthViewController.swift
//  ChoiceAuthViewController
//
//  Created by 김효준 on 2021/08/26.
//

import UIKit

// MARK: Choice Authority Main Code

class ChoiceAuthViewController: UIViewController {
    
    // MARK: Outlet Property
    
    @IBOutlet var choiceAuth: UISegmentedControl!
    @IBOutlet var goCreateIdBtn: UIButton!
    
    // MARK: - Property

    var account = Create_AccountDTO_REQ()
    
    // MARK: - Action Method
    
    /* Segmented Control 선택지에 따라 버튼 Title 변경 */
    @IBAction func choiceAuthAction(_ sender: UISegmentedControl) {
        
        if choiceAuth.selectedSegmentIndex == 0 {
            goCreateIdBtn.setTitle("수강생으로 가입하기", for: .normal)
        } else {
            goCreateIdBtn.setTitle("강사로 가입하기", for: .normal)
        }
        choiceAuth.isSelected = true
    }
    
    /* Segmented Control의 선택지가 존재할 경우 다음 페이지로 이동 */
    @IBAction func goCreateIdBtn(_ sender: UIButton) {
        var test: String?
        if choiceAuth.isSelected == true {
            test = "true"
        } else {
            test = "false"
        }
        NSLog(test!)
        if choiceAuth.isSelected {
            let civc = self.storyboard!.instantiateViewController(withIdentifier: "CreateIdVC")
            
            civc.modalTransitionStyle = .coverVertical
            civc.modalPresentationStyle = .fullScreen
            
            self.present(civc, animated: true)
        }
    }
}
