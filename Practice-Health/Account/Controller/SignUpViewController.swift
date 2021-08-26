//
//  SignUpViewController.swift
//  SignUpViewController
//
//  Created by 김효준 on 2021/08/18.
//

import Foundation
import UIKit

// MARK: SignUp Main Code

class SignUpViewController: UIViewController {

    // MARK: Outlet Property
    
    @IBOutlet var phoneTf: UITextField! // 연락처
    @IBOutlet var authNumTf: UITextField! // 인증번호
    @IBOutlet var firstPwTf: UITextField! // 비밀번호
    @IBOutlet var secondPwTf: UITextField! // 비밀번호 확인
    @IBOutlet var nameTf: UITextField! // 이름
    @IBOutlet var doAuthBtn: UIButton! // 인증하기 버튼
    @IBOutlet var goAuthBtn: UIButton! // 인증요청 버튼
    @IBOutlet var scrollView: UIScrollView! // 스크롤 뷰
    
    // MARK: - Property
    
    var signUpInfo = Create_AccountDTO_REQ()
    var id: String?
    var phoneAuth: Bool?
    
    // MARK: - Override Method
    
    override func viewDidLoad() {
        
        doAuthBtn.isHidden = true
        authNumTf.isHidden = true
        
        /* 키패드가 올라왔거나 내려갔을 때 뷰 스크롤 지원을 위한 selector 등록 */
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        /* 키패드가 올라와 있을 때 빈 공간을 터치하면 키보드가 내려가게 하기 위한 selector 등록 및 TapGestureRecognizer 설정 */
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOtherPlace(sender:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    // MARK: - Action Method

    /* 인증요청 클릭 */
    @IBAction func clickAuthReqBtn(_ sender: UIButton) {
        
        let phone = phoneTf.text
        
        if phone?.count == 11 {
            
            doAuthBtn.isHidden = false
            authNumTf.isHidden = false
            id = phone
            
        } else {
            
            alert("연락처를 확인해주세요.", view: self)
        }
    }
    
    /* 인증하기 클릭 */
    @IBAction func clickAuthCheckBtn(_ sender: UIButton) {
        
        let authNum = authNumTf.text
        
        if authNum == "123" {
            
            alert("인증이 완료되었습니다.", view: self)
            
            goAuthBtn.isEnabled = false
            phoneTf.isEnabled = false
            doAuthBtn.isHidden = true
            authNumTf.isHidden = true
            phoneAuth = true
            signUpInfo.userId = id
            
            self.view.endEditing(true)
            
        } else {
            
            alert("잘못된 인증번호 입니다.", view: self)
        }
    }
    
    /* 회원가입 클릭 */
    @IBAction func clickSignUpBtn(_ sender: UIButton) {
        
        let pw1 = firstPwTf?.text
        let pw2 = secondPwTf?.text
        guard let name = nameTf?.text else {
            return
        }
        
        /* 핸드폰 인증을 완료했을 때 */
        if phoneAuth == true {
            
            /* 비밀번호와 비밀번호 확인 텍스트필드의 값이 같을 때 */
            if pw1 == pw2 {
                
                /* 이름을 입력했을 때 */
                if name.count >= 2 {
                    signUpInfo.name = name
                    signUpInfo.password = pw1
                    
                    /* API로 바디를 보냄 */
                    self.requestSignUp()
                    
                } else {
                    
                    alert("이름을 입력해주세요.", view: self)
                }
                
            } else {
                
                alert("비밀번호를 확인해주세요.", view: self)
            }
            
        } else {
            
            alert("연락처 인증을 진행해주세요", view: self)
        }
    }
    
    // MARK: - User Defined Method
    
    /* 입력받은 정보를 바탕으로 API에 보낼 바디 파라미터를 정의하고 통신 대상 API url을 등록 후 정보를 보냄 */
    func requestSignUp() {
        
        let param = ["userId" : signUpInfo.userId, "password" : signUpInfo.password, "name" : signUpInfo.name]
        let url = "https://fapi.leescode.com/user"
        signupRequestPost(url: url, param: param, view: self)
    }
}

// MARK: - 키패드 관련 메소드

extension SignUpViewController {
    
    // MARK: OBJC Method
    
    /* 키패드가 올라왔을 때 뷰의 크기를 재정의함 */
    @objc func keyboardWillShow(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                  return
              }
        
        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: keyboardFrame.size.height,
            right: 0.0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    /* 키패드가 내려갔을 때 뷰의 크기를 원래대로 되돌림 */
    @objc func keyboardWillHide() {
        
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
}
