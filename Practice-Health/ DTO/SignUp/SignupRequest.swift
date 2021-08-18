//
//  SignupRequest.swift
//  SignupRequest
//
//  Created by 김효준 on 2021/08/18.
//

import Foundation
import UIKit

func signupRequestPost(url: String, param: [String: String?], view: UIViewController) {
    let requestUrl = URL(string: url)
    var request = URLRequest(url: requestUrl!)
    let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
    
    request.httpMethod = "POST"
    request.httpBody = paramData
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue(String(paramData.count), forHTTPHeaderField: "Content-Length")
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let e = error {
            NSLog("An error has occurred : \(e.localizedDescription)")
            return
        }
        DispatchQueue.main.async {
            do {
                let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                guard let jsonObject = object else { return }
                
                let code = jsonObject["code"] as? String
                let message = jsonObject["message"] as? String
                if code == "A1000" {
                    NSLog("회원가입 성공! \(String(describing: message))")
                    
                    let alert = UIAlertController(title: "회원가입", message: "회원가입 성공!", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "확인", style: .cancel) { (_) in
                        view.presentingViewController?.dismiss(animated: true)
                    })
                    
                    view.present(alert, animated: false)
                }
            } catch let e as NSError {
                NSLog("회원가입 실패... \(e.localizedDescription)")
                view.alert("회원가입에 실패하였습니다.")
            }
        }
    }
    
    task.resume()
}
