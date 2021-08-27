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

    var authority: String = ""
    
    // MARK: - Override Method
    
    override func viewDidLoad() {
        goCreateIdBtn.isEnabled = false
        self.title = "계정 타입 선택"
    }
    
    // MARK: - Action Method
    
    /* Segmented Control 선택지에 따라 버튼 Title 변경 */
    @IBAction func choiceAuthAction(_ sender: UISegmentedControl) {
        
        if choiceAuth.selectedSegmentIndex == 0 {
            goCreateIdBtn.setTitle("수강생으로 가입하기", for: .normal)
            authority = "ROLE_MEMBERSHIP"
        } else {
            goCreateIdBtn.setTitle("강사로 가입하기", for: .normal)
            authority = "ROLE_TRAINER"
        }
        goCreateIdBtn.isEnabled = true
    }
    
    /* Segmented Control의 선택지가 존재할 경우 다음 페이지로 이동 */
    @IBAction func clickGoCreateIdBtn(_ sender: UIButton) {
        
        let civc = self.storyboard!.instantiateViewController(withIdentifier: "CreateIdVC") as! CreateIdViewController
        
        civc.authority = authority
        self.navigationController!.pushViewController(civc, animated: true)
    }
}
