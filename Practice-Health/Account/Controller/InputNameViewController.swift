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
    @IBOutlet var goInputBirthBtn: UIButton!
    
    // MARK: - Property
    
    var request = Create_AccountDTO_REQ()
    
    // MARK: - Override Method
    
    override func viewDidLoad() {
        self.title = "이름 입력"
    }

    // MARK: - Action Method
    
    @IBAction func clickGoInputBirthBtn(_ sender: UIButton) {
        
        request.name = nameTf.text!
        
        let ibvc = self.storyboard?.instantiateViewController(withIdentifier: "InputBirthVC") as! InputBirthViewController
        
        ibvc.request = request
        
        if request.name != "" {
            
            let alert = UIAlertController(title: "이름 확인", message: "입력한 이름으로 계속하시겠습니까?", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "확인", style: .default) { (_) in
                self.navigationController?.pushViewController(ibvc, animated: true)
            }
            
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(ok)
            alert.addAction(cancel)
            
            self.present(alert, animated: false)
            
        } else {
            alert("이름을 입력해주세요.", view: self)
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
            goInputBirthBtn.setTitle("\(nameTf.text!) 님으로 계속하기", for: .normal)
        }
    }
}
