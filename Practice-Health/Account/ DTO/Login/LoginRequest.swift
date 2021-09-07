//
//  LoginRequest.swift
//  LoginRequest
//
//  Created by 김효준 on 2021/08/18.
//
import UIKit
import Foundation

func loginRequestPost(url: String, param: [String: String?], userId: String, password: String, view: UIViewController) {
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
                
                if code == "A2000" {
                    let data = jsonObject["data"] as? NSDictionary
                    let grantType = data!.value(forKey: "grantType") as? String
                    let accessToken = data!.value(forKey: "accessToken") as? String

                    NSLog("로그인 성공! \(String(describing: message!))")
                    
                    UserDefaults.standard.set(userId, forKey: "userId")
                    UserDefaults.standard.set(grantType, forKey: "grantType")
                    UserDefaults.standard.set(accessToken, forKey: "accessToken")
                    
                    view.navigationController?.popViewController(animated: true)
                } else {
                    NSLog("로그인 실패 \(String(describing: message!))")
                    view.alert("ID와 비밀번호를 확인해주세요.", view: view)
                }
            } catch let e as NSError {
                NSLog("로그인 실패... \(e.localizedDescription)")
                view.alert("로그인 실패하였습니다.", view: view)
            }
        }
    }
    
    task.resume()
}
