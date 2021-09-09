//
//  InputNameViewController.swift
//  InputNameViewController
//
//  Created by 김효준 on 2021/08/30.
//

import UIKit

// MARK: Input Name Main Code

class InputNameViewController: UIViewController {

    // MARK: Outlet Property
    
    @IBOutlet var nameTf: UITextField!
    @IBOutlet var goChoiceAuthBtn: UIButton!
    @IBOutlet var checkIdBtn: UIButton!
    
    // MARK: - Property
    
    var request = Create_AccountDTO_REQ()
    
    // MARK: - Override Method
    
    override func viewDidLoad() {
        self.title = "닉네임 입력"
        NSLog("userId >>>>>>>> \(request.userId ?? "없음")")
        goChoiceAuthBtn.isEnabled = false
    }

    // MARK: - Action Method
    
    @IBAction func clickCheckIdBtn(_ sender: UIButton) {
        if nameTf.text! != "" {
            let url = "https://fapi.leescode.com/account/exists/name/\(nameTf.text!)"
            
            checkNameRequest(url: url) { (check) in
                if check == "true" {
                    self.alert("이미 사용중인 닉네임입니다. 다시 입력해주세요.", view: self)
                } else {
                    self.alert("사용 가능한 닉네임입니다.", view: self)
                    self.goChoiceAuthBtn.isEnabled = true
                }
            }
        } else {
            alert("닉네임을 입력해주세요", view: self)
        }
    }
    
    @IBAction func clickGoChoiceAuthBtn(_ sender: UIButton) {
        
        request.name = nameTf.text!
        
        let cavc = self.storyboard?.instantiateViewController(withIdentifier: "ChoiceAuthVC") as! ChoiceAuthViewController
        
        cavc.request = request
        
        if request.name != "" {
            
            let alert = UIAlertController(title: "닉네임 확인", message: "입력한 닉네임으로 계속하시겠습니까?", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "확인", style: .default) { (_) in
                self.navigationController?.pushViewController(cavc, animated: true)
            }
            
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(ok)
            alert.addAction(cancel)
            
            self.present(alert, animated: false)
            
        } else {
            alert("닉네임을 입력해주세요.", view: self)
        }
    }
    
}

// MARK: - 키패드 및 버튼 제어 Extension

extension InputNameViewController {
    
    // MARK: Override Method
    
    /* 여백 터치했을 때 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        if nameTf.text != "" {
            goChoiceAuthBtn.setTitle("\(nameTf.text!) 님으로 계속하기", for: .normal)
        }
    }
}
