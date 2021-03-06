//
//  MenuViewController.swift
//  MenuViewController
//
//  Created by 김효준 on 2021/08/24.
//

import UIKit

// MARK: Menu Page Main Code

class MenuViewController: UITableViewController {
    
    // MARK: Outlet Property
    
    @IBOutlet var logoutBtn: UIButton!
    
    // MARK: - Override Method
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    /* 테이블 뷰 셀 행 수 리턴하는 함수*/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    /* 테이블 뷰 셀의 내용을 구성하는 함수 */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
        
        if UserDefaults.standard.string(forKey: "accessToken") != nil {
            cell.userInfo.text = UserDefaults.standard.string(forKey: "userId")
        } else {
            cell.userInfo.text = "로그인을 해주세요!"
        }
        
        if cell.userInfo.text == "로그인을 해주세요!" {
            logoutBtn.isHidden = true
        } else {
            logoutBtn.isHidden = false
        }
        
        return cell
    }
    
    /* 생성된 프로필 계정 테이블 뷰 셀을 터치 시 실행 */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /* 로그인 정보가 있을 경우 계정 정보 VC로 이동. 그 외의 경우 로그인 VC로 이동 */
        if UserDefaults.standard.string(forKey: "accessToken") != nil {
            
            let aivc = self.storyboard!.instantiateViewController(withIdentifier: "AccountInfoVC")
            
            self.navigationController?.pushViewController(aivc, animated: true)
            
        } else {
            
            let ipvc = self.storyboard!.instantiateViewController(withIdentifier: "InputPhoneVC")
            
            self.navigationController?.pushViewController(ipvc, animated: true)
            
        }
    }
    
    // MARK: - Action Method
    
    @IBAction func clickLogoutBtn(_ sender: UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "grantType")
        UserDefaults.standard.removeObject(forKey: "accessToken")
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: .none)
        
        logoutBtn.isHidden = true
    }
}
