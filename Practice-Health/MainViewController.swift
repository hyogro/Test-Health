//
//  MainViewController.swift
//  MainViewController
//
//  Created by 김효준 on 2021/08/18.
//

import UIKit

// MARK: Main Page Main Code

class MainViewController: UIViewController {
    
    // MARK: - Override Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action Method
    
    /* 로그아웃 버튼 클릭 */
    @IBAction func clickLogoutBtn(_ sender: UIButton) {
        
        /* 로그아웃 실행 여부 확인 알림창 */
        let checkLogoutAlert = UIAlertController(title: "로그아웃", message: "로그아웃하시겠습니까?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            
            /* 로그아웃 확인 알림창 */
            let alert = UIAlertController(title: "로그아웃", message: "로그아웃되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel) { (_) in
                
                /* UserDefaults에 저장된 자동 로그인 정보 및 토큰 삭제 */
                UserDefaults.standard.removeObject(forKey: "userId")
                UserDefaults.standard.removeObject(forKey: "password")
                UserDefaults.standard.removeObject(forKey: "grantType")
                UserDefaults.standard.removeObject(forKey: "accessToken")
                UserDefaults.standard.removeObject(forKey: "refreshToken")
                UserDefaults.standard.removeObject(forKey: "accessTokenExpiresIn")
                
                /* 로그인 화면으로 되돌아감 */
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
