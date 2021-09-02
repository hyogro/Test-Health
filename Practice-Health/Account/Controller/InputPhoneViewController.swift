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
    @IBOutlet var validateLabel: UILabel!
    @IBOutlet var goAuthBtn: UIButton!
    
    // MARK: - Property
    
    var request = Create_AccountDTO_REQ()
    
    // MARK: - Override Method

    override func viewDidLoad() {
        self.title = "연락처 입력"
        phoneTf.placeholder = "'-' 빼고 입력해주세요"
        authTf.isHidden = true
        doAuthBtn.isHidden = true
        finishSignupBtn.isEnabled = false
        validateLabel.isHidden = true
        goAuthBtn.isEnabled = false
        
        self.phoneTf.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // MARK: - Action Method

    @IBAction func clickGoAuthBtn(_ sender: UIButton) {
        if phoneTf.text!.count == 13 {
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
        
        let param = ["userId" : request.userId, "password" : request.password, "name" : request.name, "phone" : request.phone, "birthDate" : request.birthDate, "sex" : request.sex, "authority" : request.authority]
        
        let url = "https://fapi.leescode.com/user"
        signupRequestPost(url: url, param: param, view: self)
        
        let fsvc = self.storyboard!.instantiateViewController(withIdentifier: "FinishSignupVC") as! FinishSignupViewController
        
        fsvc.loginInfo.userId = request.userId
        fsvc.loginInfo.password = request.password
        fsvc.authority = request.authority!
        
        self.navigationController?.pushViewController(fsvc, animated: true)
        
    }
    
    // MARK: - Objc Method
    
    @objc func textFieldDidChange(_ sender: Any?) {
        if phoneTf.text == "" {
            validateLabel.isHidden = true
            goAuthBtn.isEnabled = false
        } else {
            if phoneTf.text!.count == 3 || phoneTf.text!.count == 8 {
                phoneTf.text = phoneTf.text! + "-"
            }
            
            if phoneTf.text!.validatePhone() == false {
                validateLabel.isHidden = false
                validateLabel.text = "연락처를 입력해주세요."
                goAuthBtn.isEnabled = false
            } else {
                validateLabel.isHidden = true
                goAuthBtn.isEnabled = true
            }
        }
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
