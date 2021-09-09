//
//  ChoiceAuthViewController.swift
//  ChoiceAuthViewController
//
//  Created by 김효준 on 2021/08/26.
//

import UIKit

// MARK: Choice Authority Main Code

class ChoiceAuthViewController: UIViewController {
    
    // MARK: Outlet Property
    
    @IBOutlet var choiceAuth: UISegmentedControl!
    @IBOutlet var goFinishSignupBtn: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    // MARK: - Property

    var request = Create_AccountDTO_REQ()
    
    // MARK: - Override Method
    
    override func viewDidLoad() {
        goFinishSignupBtn.isEnabled = false
        self.title = "계정 타입 선택"
        titleLabel.text = "\(request.name!) 님 환영합니다!"
    }
    
    // MARK: - Action Method
    
    /* Segmented Control 선택지에 따라 버튼 Title 변경 */
    @IBAction func choiceAuthAction(_ sender: UISegmentedControl) {
        if choiceAuth.selectedSegmentIndex == 0 {
            goFinishSignupBtn.setTitle("수강생으로 가입하기", for: .normal)
            request.authority = "ROLE_MEMBERSHIP"
        } else {
            goFinishSignupBtn.setTitle("강사로 가입하기", for: .normal)
            request.authority = "ROLE_TRAINER"
        }
        goFinishSignupBtn.isEnabled = true
    }
    
    /* Segmented Control의 선택지가 존재할 경우 회원가입 완료 */
    @IBAction func clickGoFinishSignupBtn(_ sender: UIButton) {
        
        let signupAlert = UIAlertController(title: "회원가입", message: "입력한 정보로 계정을 생성하시겠습니까?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            let url = "https://fapi.leescode.com/user"
            let param = ["userId": self.request.userId, "name": self.request.name, "authority": self.request.authority]
            
            signupRequestPost(url: url, param: param) { (code) in
                if code == "A1000" {
                    
                    let fsvc = self.storyboard!.instantiateViewController(withIdentifier: "FinishSignupVC") as! FinishSignupViewController
                    
                    fsvc.userId = self.request.userId
                    
                    self.navigationController!.pushViewController(fsvc, animated: true)
                } else {
                    self.alert("계정 생성에 실패하였습니다.", view: self)
                }
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        signupAlert.addAction(ok)
        signupAlert.addAction(cancel)
        
        self.present(signupAlert, animated: false)
    }
}
