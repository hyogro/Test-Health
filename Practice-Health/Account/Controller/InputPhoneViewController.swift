//
//  InputPhoneViewController.swift
//  InputPhoneViewController
//
//  Created by 김효준 on 2021/08/30.
//

import UIKit

// MARK: Input Phone Main Code

class InputPhoneViewController: UIViewController {
    
    // MARK: Outlet Property
    
    @IBOutlet var phoneTf: UITextField!
    @IBOutlet var authTf: UITextField!
    @IBOutlet var doAuthBtn: UIButton!
    @IBOutlet var finishSignupBtn: UIButton!
    
    // MARK: - Property
    
    var request = Create_AccountDTO_REQ()
    
    // MARK: - Override Method

    override func viewDidLoad() {
        self.title = "연락처 입력"
        phoneTf.placeholder = "'-' 빼고 입력해주세요"
        authTf.isHidden = true
        doAuthBtn.isHidden = true
        finishSignupBtn.isEnabled = false
    }
    
    // MARK: - Action Method

    @IBAction func clickGoAuthBtn(_ sender: UIButton) {
        if phoneTf.text!.count == 11 {
            alert("인증번호를 입력해주세요.", view: self)
            
            authTf.placeholder = "인증번호를 입력해주세요"
            authTf.isHidden = false
            doAuthBtn.isHidden = false
            
            phoneTf.resignFirstResponder()
            authTf.becomeFirstResponder()
        } else {
            alert("연락처를 확인해주세요.", view: self)
        }
    }
    
    @IBAction func clickDoAuthBtn(_ sender: UIButton) {
        if authTf.text! == "123" {
            authTf.resignFirstResponder()
            
            alert("인증되었습니다!", view: self)
            
            finishSignupBtn.setTitle("회원가입 완료!", for: .normal)
            finishSignupBtn.isEnabled = true
            authTf.isHidden = true
            doAuthBtn.isHidden = true
            
            request.phone = phoneTf.text!
            
        } else {
            alert("인증번호를 확인해주세요.", view: self)
        }
    }
    
    @IBAction func clickFinishSingupBtn(_ sender: UIButton) {
        
    }
}

// MARK: - 키패드 제어 Extension

extension InputPhoneViewController {
    
    // MARK: Override Method
    
    /* 여백 터치하면 키패드 내림 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
}
