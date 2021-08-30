//
//  ChoiceSexViewController.swift
//  ChoiceSexViewController
//
//  Created by 김효준 on 2021/08/30.
//

import UIKit

// MARK: Choice Sex Main Code

class ChoiceSexViewController: UIViewController {

    // MARK: Outlet Property
    
    @IBOutlet var choiceSexSeg: UISegmentedControl!
    
    // MARK: - Property
    
    var request = Create_AccountDTO_REQ()
    
    // MARK: - Override Method
    
    override func viewDidLoad() {
        self.title = "성별 선택"
    }
    
    // MARK: - Action Method
    
    @IBAction func choiceSexSegAction(_ sender: UISegmentedControl) {
        
        if choiceSexSeg.selectedSegmentIndex == 0 {
            request.sex = "M"
        } else if choiceSexSeg.selectedSegmentIndex == 2 {
            request.sex = "F"
        }
    }
    
    @IBAction func clickGoInputPhoneBtn(_ sender: UIButton) {
        let cpvc = self.storyboard?.instantiateViewController(withIdentifier: "InputPhoneVC") as! InputPhoneViewController
        
        let alert = UIAlertController(title: "성별 선택", message: "선택한 정보로 계속하시겠습니까?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            self.navigationController?.pushViewController(cpvc, animated: true)
        }
        
        cpvc.request = request
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: false)
    }
}
