//
//  LoginViewController.swift
//  LoginViewController
//
//  Created by 김효준 on 2021/08/18.
//

import UIKit

// MARK: Login Main Code

class LoginViewController: UIViewController {

    // MARK: Outlet Property
    
    @IBOutlet var idTf: UITextField!    // ID
    @IBOutlet var pwTf: UITextField!    // Password
    
    // MARK: Property
    
    var loginInfo = Login_AccountDTO_REQ()
    
    // MARK: - Override Method
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = true

    }
    
    override func viewDidLoad() {
        
        /* ID, PW 텍스트 필드에 안내문자 세팅 */
        idTf.placeholder = "Email ID"
        pwTf.placeholder = "Password"
        self.title = "로그인"
        
        super.viewDidLoad()
    }

    // MARK: - Action Method
    
    /* 로그인 버튼 클릭 */
    @IBAction func clickBtnLogin(_ sender: UIButton) {
        
        /* ID, Password 텍스트 필드의 값 가져오기 */
        guard let userId = idTf?.text else { return }
        guard let password = pwTf?.text else { return }
        
        /* ID, Password 입력값이 길이 최소 조건 충족 시 로그인 API로 리퀘스트를 보냄 */
        if userId.count >= 8 && password.count >= 3 {
            loginInfo.userId = userId
            loginInfo.password = password
            
            /* 입력값을 공백으로 초기화 */
            idTf.text = ""
            pwTf.text = ""
            
            let param = ["userId" : loginInfo.userId, "password" : loginInfo.password]
            let url = "https://fapi.leescode.com/account/login"
            loginRequestPost(url: url, param: param, userId: userId, password: password, view: self)
        } else {
            alert("ID 또는 비밀번호를 확인해주세요.", view: self)
        }
    }
    
    @IBAction func clickGoCreateAccountBtn(_ sender: UIButton) {
        let cavc = self.storyboard!.instantiateViewController(withIdentifier: "ChoiceAuthVC")
        
        self.navigationController?.pushViewController(cavc, animated: true)
    }
}

// MARK: - 키패드 제어 Extension

extension LoginViewController {
    
    // MARK: Override Method
    
    /* 여백 터치하면 키패드 내림 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
}
