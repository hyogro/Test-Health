//
//  LoginViewController.swift
//  LoginViewController
//
//  Created by 김효준 on 2021/08/18.
//

import UIKit

// MARK: - Login Main Code
class LoginViewController: UIViewController {

    @IBOutlet var idTf: UITextField!
    @IBOutlet var pwTf: UITextField!
    
    var loginInfo = Login_AccountDTO_REQ()
    
    override func viewWillAppear(_ animated: Bool) {
        if let userId = UserDefaults.standard.string(forKey: "userId") {
            let password = UserDefaults.standard.string(forKey: "password")!
            let param = ["userId" : userId, "password" : password]
            let url = "https://fapi.leescode.com/account/login"
            loginRequestPost(url: url, param: param, userId: userId, password: password, view: self)
        }
    }
    
    override func viewDidLoad() {
        idTf.placeholder = "ID"
        pwTf.placeholder = "Password"
        
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func clickBtnLogin(_ sender: UIButton) {
        guard let userId = idTf?.text else { return }
        guard let password = pwTf?.text else { return }
        
        if userId.count == 11 && password.count >= 3 {
            loginInfo.userId = userId
            loginInfo.password = password
            
            idTf.text = ""
            pwTf.text = ""
            
            let param = ["userId" : loginInfo.userId, "password" : loginInfo.password]
            let url = "https://fapi.leescode.com/account/login"
            loginRequestPost(url: url, param: param, userId: userId, password: password, view: self)
        } else {
            alert("ID 또는 비밀번호를 확인해주세요.", view: self)
        }
    }
    
    @IBAction func clickGoSignUpBtn(_ sender: UIButton) {
        
        let svc = self.storyboard!.instantiateViewController(withIdentifier: "SignUpVC")
        
        svc.modalTransitionStyle = .coverVertical
        
        self.present(svc, animated: true)
    }
}
