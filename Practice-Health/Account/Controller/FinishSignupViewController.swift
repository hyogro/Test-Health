//
//  FinishSingupViewController.swift
//  FinishSingupViewController
//
//  Created by 김효준 on 2021/08/31.
//

import UIKit

// MARK: Finish Signup Main Code

class FinishSignupViewController: UIViewController {

    // MARK: Property
    
    var loginInfo = Login_AccountDTO_REQ()
    var authority: String = ""
    
    // MARK: - Override Method
    
    override func viewWillAppear(_ animated: Bool) {
        let param = ["userId" : loginInfo.userId, "password" : loginInfo.password]
        let url = "https://fapi.leescode.com/account/login"
        
        loginRequestPost(url: url, param: param, userId: loginInfo.userId!, password: loginInfo.password!, view: self)
    }
    
    override func viewDidLoad() {
        self.title = "회원가입 완료"

    }
    
    // MARK: - Action Method
    
    @IBAction func goInputInfoBtn(_ sender: UIButton) {
        var idvc: UIViewController
        
        if authority == "ROLE_MEMBERSHIP" {
            idvc = self.storyboard!.instantiateViewController(withIdentifier: "InputDetailMembershipVC")
        } else {
            idvc = self.storyboard!.instantiateViewController(withIdentifier: "InputDetailTrainerVC")
        }
        
        self.navigationController?.pushViewController(idvc, animated: true)
        
    }
    
    
    @IBAction func endSignupBtn(_ sender: UIButton) {
        
        let mvc = self.storyboard!.instantiateViewController(withIdentifier: "MenuVC")
        
        self.navigationController?.popToViewController(mvc, animated: true)
    }
}
