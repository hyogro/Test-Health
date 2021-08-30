//
//  CreatePasswordViewController.swift
//  CreatePasswordViewController
//
//  Created by 김효준 on 2021/08/27.
//

import UIKit

// MARK: Create Password Main Code

class CreatePasswordViewController: UIViewController {

    // MARK: Outlet Property
    
    @IBOutlet var pwTf: UITextField!
    @IBOutlet var checkPwTf: UITextField!
    
    
    // MARK: - Property
    
    var request = Create_AccountDTO_REQ()
    
    // MARK: - Override Method
    
    override func viewDidLoad() {
        self.title = "비밀번호 설정"
        pwTf.placeholder = "비밀번호"
        checkPwTf.placeholder = "비밀번호 확인"
    }
    
    // MARK: - Action Method
    
    
    @IBAction func clickGoInputNameBtn(_ sender: UIButton) {
        
        if pwTf.text!.count >= 4 && pwTf.text == checkPwTf.text {
            request.password = pwTf.text!
            
            let invc = self.storyboard?.instantiateViewController(withIdentifier: "InputNameVC") as! InputNameViewController
            
            invc.request = request
            
            self.navigationController?.pushViewController(invc, animated: true)
        } else {
            alert("입력한 비밀번호를 확인해주세요.", view: self)
        }
    }
    
}

// MARK: - 키패드 제어 Extension

extension CreatePasswordViewController {
    
    // MARK: Override Method
    
    /* 여백 터치하면 키패드 내림 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
}
