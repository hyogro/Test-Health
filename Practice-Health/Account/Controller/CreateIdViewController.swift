//
//  CreateIdViewController.swift
//  CreateIdViewController
//
//  Created by 김효준 on 2021/08/26.
//

import UIKit

// MARK: Create Id Main Code

class CreateIdViewController: UIViewController {

    // MARK: Outlet Property
    
    @IBOutlet var idTf: UITextField!    // email ID를 받을 텍스트필드
    @IBOutlet var authTf: UITextField!
    @IBOutlet var authBtn: UIButton!
    @IBOutlet var goCreatePasswordBtn: UIButton!
    @IBOutlet var describeType: UILabel!
    
    // MARK: - Property
    
    var authority: String = ""
    var userId: String = ""
    var auth: Bool = false
    
    // MARK: - Override Method
    
    override func viewDidLoad() {
        
        /* 텍스트필드에 안내문자 세팅 */
        idTf.placeholder = "Email을 입력해주세요."
        authTf.isHidden = true
        authBtn.isHidden = true
        goCreatePasswordBtn.isEnabled = false
        
        if authority == "ROLE_MEMBERSHIP" {
            describeType.text = "수강생으로 가입합니다."
        } else {
            describeType.text = "강사로 가입합니다."
        }
        
        self.title = "Email ID 생성"
        
    }
    
    // MARK: - Action Method
    
    /* ID 입력 후 인증요청 버튼 클릭 */
    @IBAction func clickGoAuth(_ sender: UIButton) {
        if idTf.text != "" {
            authTf.isHidden = false
            authBtn.isHidden = false
            authTf.placeholder = "인증번호를 입력해주세요."
            alert("인증번호를 입력해주세요.", view: self)
            idTf.resignFirstResponder()
            authTf.becomeFirstResponder()
        } else {
            alert("Email ID를 확인해주세요.", view: self)
        }
    }
    
    /* 인증번호 입력 후 인증하기 클릭 */
    @IBAction func clickDoAuth(_ sender: UIButton) {
        if authTf.text == "123" {
            userId = idTf.text!
            auth = true
            alert("인증되었습니다.", view: self)
            authTf.isHidden = true
            authBtn.isHidden = true
            goCreatePasswordBtn.isEnabled = true
            goCreatePasswordBtn.setTitle("입력한 Email ID로 계속하기", for: .normal)
            authTf.resignFirstResponder()
        } else {
            alert("인증번호를 확인해주세요.", view: self)
        }
    }
    
    /* Email ID 생성 및 인증 후 비밀번호 입력 뷰로 이동 */
    @IBAction func clickGoCreatePasswordBtn(_ sender: UIButton) {
        let cpvc = self.storyboard!.instantiateViewController(withIdentifier: "CreatePWVC") as! CreatePasswordViewController
        
        cpvc.authority = authority
        cpvc.userId = userId
        
        self.navigationController!.pushViewController(cpvc, animated: true)
    }
}

// MARK: - 키패드 제어 Extension

extension CreateIdViewController {
    
    // MARK: Override Method
    
    /* 여백 터치하면 키패드 내림 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
}
