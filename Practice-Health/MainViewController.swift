//
//  MainViewController.swift
//  MainViewController
//
//  Created by 김효준 on 2021/08/18.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func clickLogoutBtn(_ sender: UIButton) {
        
        let checkLogoutAlert = UIAlertController(title: "로그아웃", message: "로그아웃하시겠습니까?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            let alert = UIAlertController(title: "로그아웃", message: "로그아웃되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel) { (_) in
                UserDefaults.standard.removeObject(forKey: "userId")
                UserDefaults.standard.removeObject(forKey: "password")
                UserDefaults.standard.removeObject(forKey: "grantType")
                UserDefaults.standard.removeObject(forKey: "accessToken")
                UserDefaults.standard.removeObject(forKey: "refreshToken")
                UserDefaults.standard.removeObject(forKey: "accessTokenExpiresIn")
                
                self.presentingViewController?.dismiss(animated: true)
            })
            
            self.present(alert, animated: false)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        checkLogoutAlert.addAction(ok)
        checkLogoutAlert.addAction(cancel)
        self.present(checkLogoutAlert, animated: false)
        
    }
}
