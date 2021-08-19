//
//  SignUpViewController.swift
//  SignUpViewController
//
//  Created by 김효준 on 2021/08/18.
//

import Foundation
import UIKit

// MARK: SignUp Main Code
class SignUpViewController: UIViewController {

    @IBOutlet var phoneTf: UITextField!
    @IBOutlet var authNumTf: UITextField!
    @IBOutlet var firstPwTf: UITextField!
    @IBOutlet var secondPwTf: UITextField!
    @IBOutlet var nameTf: UITextField!
    @IBOutlet var doAuthBtn: UIButton!
    @IBOutlet var goAuthBtn: UIButton!
    
    var signUpInfo = Create_AccountDTO_REQ()
    
    var id: String?
    var phoneAuth: Bool?
    
    override func viewDidLoad() {
        
        doAuthBtn.isHidden = true
        authNumTf.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func clickAuthReqBtn(_ sender: UIButton) {
        
        let phone = phoneTf.text
        
        if phone?.count == 11 {
            
            doAuthBtn.isHidden = false
            authNumTf.isHidden = false
            id = phone
            
        } else {
            
            alert("연락처를 확인해주세요.", view: self)
        }
    }
    
    @IBAction func clickAuthCheckBtn(_ sender: UIButton) {
        
        let authNum = authNumTf.text
        
        if authNum == "123" {
            
            alert("인증이 완료되었습니다.", view: self)
            
            goAuthBtn.isEnabled = false
            phoneTf.isEnabled = false
            doAuthBtn.isHidden = true
            authNumTf.isHidden = true
            phoneAuth = true
            signUpInfo.userId = id
            
            self.view.endEditing(true)
            
        } else {
            
            alert("잘못된 인증번호 입니다.", view: self)
        }
    }
    
    @IBAction func clickSignUpBtn(_ sender: UIButton) {
        
        let pw1 = firstPwTf?.text
        let pw2 = secondPwTf?.text
        guard let name = nameTf?.text else {
            return
        }
        
        if phoneAuth == true {
            
            if pw1 == pw2 {
                
                if name.count >= 2 {
                    signUpInfo.name = name
                    signUpInfo.password = pw1
                    
                    self.requestSignUp()
                    
                } else {
                    
                    alert("이름을 입력해주세요.", view: self)
                }
                
            } else {
                
                alert("비밀번호를 확인해주세요.", view: self)
            }
            
        } else {
            
            alert("연락처 인증을 진행해주세요", view: self)
        }
    }
    
    func requestSignUp() {
        let param = ["userId" : signUpInfo.userId, "password" : signUpInfo.password, "name" : signUpInfo.name]
        let url = "https://fapi.leescode.com/user"
        signupRequestPost(url: url, param: param, view: self)
    }
}
