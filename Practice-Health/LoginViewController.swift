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
    
    override func viewDidLoad() {
        idTf.placeholder = "ID"
        pwTf.placeholder = "Password"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func clickBtnLogin(_ sender: UIButton) {
        
    }
    
    @IBAction func clickGoSignUpBtn(_ sender: UIButton) {
        
        let svc = self.storyboard!.instantiateViewController(withIdentifier: "SignUpVC")
        
        svc.modalTransitionStyle = .coverVertical
        svc.modalPresentationStyle = .fullScreen
        
        self.present(svc, animated: true)
    }
}
