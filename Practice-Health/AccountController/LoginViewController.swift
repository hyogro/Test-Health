//
//  LoginViewController.swift
//  LoginViewController
//
//  Created by 김효준 on 2021/08/18.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var idTf: UITextField!
    @IBOutlet var pwTf: UITextField!
    
    var loginInfo = Login_AccountDTO_REQ()
    
    override func viewWillAppear(_ animated: Bool) {
        if let memberId = UserDefaults.standard.string(forKey: "memberId") {
            let password = UserDefaults.standard.string(forKey: "password")!
            let param = ["memberId" : memberId, "password" : password]
            let url = "https://fapi.leescode.com/account/login"
            loginRequestPost(url: url, param: param, memberId: memberId, password: password, view: self)
        }
    }
    
    override func viewDidLoad() {
        idTf.placeholder = "ID"
        pwTf.placeholder = "Password"        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func clickBtnLogin(_ sender: UIButton) {
        guard let memberId = idTf?.text else { return }
        guard let password = pwTf?.text else { return }
        loginInfo.memberId = memberId
        loginInfo.password = password
        
        let param = ["memberId" : loginInfo.memberId, "password" : loginInfo.password]
        let url = "https://fapi.leescode.com/account/login"
        loginRequestPost(url: url, param: param, memberId: memberId, password: password, view: self)
    }
    
    @IBAction func clickGoSignUpBtn(_ sender: UIButton) {
        
        let svc = self.storyboard!.instantiateViewController(withIdentifier: "SignUpVC")
        
        svc.modalTransitionStyle = .coverVertical
        
        self.present(svc, animated: true)
    }
}
