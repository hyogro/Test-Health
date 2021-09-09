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
    @IBOutlet var goInputNameBtn: UIButton!
    @IBOutlet var validateLabel: UILabel!
    @IBOutlet var goAuthBtn: UIButton!
    
    // MARK: - Property
    
    var request = Create_AccountDTO_REQ()
    var phone: String = ""
    var inputCode: String = ""
    
    // MARK: - Override Method

    override func viewDidLoad() {
        self.title = "연락처 입력"
        phoneTf.placeholder = "'-' 빼고 입력해주세요"
        authTf.isHidden = true
        doAuthBtn.isHidden = true
        goInputNameBtn.isEnabled = false
        validateLabel.isHidden = true
        goAuthBtn.isEnabled = false
        
        self.phoneTf.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // MARK: - Action Method

    @IBAction func clickGoAuthBtn(_ sender: UIButton) {
        if phoneTf.text!.count == 13 {
            phone = phoneTf.text!
            let param = ["phone": phone]
            let url = "https://fapi.leescode.com/account/phone/cert"
            
            certifyPhoneRequestPost(url: url, param: param) { (certifyCode) in
                if certifyCode != "" {
                    self.alert("인증번호를 입력해주세요.", view: self)
                    
                    self.authTf.placeholder = "인증번호를 입력해주세요"
                    self.authTf.isHidden = false
                    self.doAuthBtn.isHidden = false
                    
                    self.phoneTf.resignFirstResponder()
                    self.authTf.becomeFirstResponder()
                } else {
                    self.alert("인증번호 요청 실패", view: self)
                }
            }
        } else {
            self.alert("연락처를 확인해주세요.", view: self)
        }
    }
    
    @IBAction func clickDoAuthBtn(_ sender: UIButton) {
        inputCode = authTf.text!
        if inputCode != "" {
            let param = ["phone": phone, "number": inputCode]
            let url = "https://fapi.leescode.com/account/phone/verify"
            verifyCodeRequestPost(url: url, param: param) { (verifyPhone) in
                if verifyPhone.userId != nil {
                    self.alert("인증 성공", view: self)
                    self.request.userId = verifyPhone.userId
                    self.goInputNameBtn.isEnabled = true
                    self.goInputNameBtn.setTitle("계속하기", for: .normal)
                }
            }
        }
    }
    
    @IBAction func clickGoInputNameBtn(_ sender: UIButton) {
        let invc = self.storyboard!.instantiateViewController(withIdentifier: "InputNameVC") as! InputNameViewController
        
        invc.request = request
        
        self.navigationController?.pushViewController(invc, animated: true)
        
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
