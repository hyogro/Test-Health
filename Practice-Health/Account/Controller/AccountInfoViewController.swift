//
//  AccountInfoViewController.swift
//  AccountInfoViewController
//
//  Created by 김효준 on 2021/08/25.
//

import UIKit

// MARK: Account Info Main Code

class AccountInfoViewController: UIViewController {
    
    // MARK: Outlet Property
    
    @IBOutlet var idTf: UITextField!
    @IBOutlet var nameTf: UITextField!
    
    // MARK: - Property

    // MARK: - Override Method
    
    override func viewWillAppear(_ animated: Bool) {        
        let url = "https://fapi.leescode.com/user"
        GetInfoRequest(url: url, view: self) { (info) in
            self.idTf.text = info.userId
            self.nameTf.text = info.name
        }
    }
    
    override func viewDidLoad() {
        self.title = "내 정보 보기"
    }
}
