//
//  InputBirthViewController.swift
//  InputBirthViewController
//
//  Created by 김효준 on 2021/08/30.
//

import UIKit

// MARK: Input Birth Main Code

class InputBirthViewController: UIViewController {

    // MARK: Outlet Property
    
    @IBOutlet var datePicker: UIDatePicker!
    
    // MARK: - Property
    
    var request = Create_AccountDTO_REQ()
    
    // MARK: - Override Method
    
    override func viewDidLoad() {
        self.title = "생년월일 입력"
    }

    // MARK: - Action Method
    
    @IBAction func clickSkipBirthBtn(_ sender: UIButton) {
        let csvc = defineTarget()
        request.birthDate = nil
        
        csvc.request = request
        
        let alert = UIAlertController(title: "생년월일 생략", message: "생년월일 입력을 생략하시겠습니까?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            
            self.navigationController?.pushViewController(csvc, animated: true)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: false)
        
    }
    
    @IBAction func clickGoChoiceSexBtn(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        request.birthDate = formatter.string(from: datePicker.date)
        
        let csvc = defineTarget()
        
        csvc.request = request
        
        self.navigationController?.pushViewController(csvc, animated: true)
        
    }
    
    // MARK: - User Defined Method
    
    func defineTarget() -> ChoiceSexViewController {
        let csvc = self.storyboard?.instantiateViewController(withIdentifier: "ChoiceSexVC") as! ChoiceSexViewController
        
        return csvc
    }
}
