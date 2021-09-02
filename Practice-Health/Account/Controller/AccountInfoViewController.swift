//
//  AccountInfoViewController.swift
//  AccountInfoViewController
//
//  Created by 김효준 on 2021/08/25.
//

import UIKit

// MARK: Account Info Main Code

class AccountInfoViewController: UIViewController {

    // MARK: - Override Method
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: "userId") == nil {
            let alert = UIAlertController(title: "로그인", message: "로그인이 필요한 페이지입니다.", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "확인", style: .cancel) { (_) in
                self.navigationController?.popViewController(animated: true)
            }
            
            alert.addAction(ok)
            
            self.present(alert, animated: false)
        }
    }
    
    override func viewDidLoad() {
        self.title = "내 정보 보기"

    }

}
