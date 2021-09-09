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
    
    var userId: String?
    var authority: String = ""
    
    // MARK: - Override Method
    
    override func viewWillAppear(_ animated: Bool) {
        let url = "https://fapi.leescode.com/account/login"
        let param = ["userId": userId!]
        
        loginRequestPost(url: url, param: param) { (code) in
            if code == "A2000" {
                UserDefaults.standard.set(self.userId, forKey: "userId")
            }
        }
    }
    
    override func viewDidLoad() {
        self.title = "회원가입 완료"

    }
    
    // MARK: - Action Method
    
    @IBAction func goInputInfoBtn(_ sender: UIButton) {
        var target: String = ""
        
        if authority == "ROLE_MEMBERSHIP" {
            target = "InputDetailMembershipVC"
        } else if authority == "ROLE_TRAINER" {
            target = "InputDetailTrainerVC"
        } else { return }
        
        let idvc = self.storyboard!.instantiateViewController(withIdentifier: target)
        
        self.navigationController?.pushViewController(idvc, animated: true)
        
    }
    
    @IBAction func endSignupBtn(_ sender: UIButton) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}
