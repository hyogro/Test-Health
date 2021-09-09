//
//  SignupRequest.swift
//  SignupRequest
//
//  Created by 김효준 on 2021/08/18.
//

import Foundation
import UIKit

func signupRequestPost(url: String, param: [String: String?], completion: @escaping(_ code: String) -> Void) {
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
                    NSLog("회원가입 성공! \(String(describing: message!))")
                } else {
                    NSLog("회원가입 실패 \(String(describing: message!))")
                }
                
                completion(code ?? "없음")
            } catch let e as NSError {
                NSLog("회원가입 실패... \(e.localizedDescription)")
            }
        }
    }
    
    task.resume()
}

func certifyPhoneRequestPost(url: String, param: [String: String], completion: @escaping(_ certifyCode: String) -> Void){
    var certifyCode: String = ""
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
            do{
                let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                guard let jsonObject = object else { return }
                
                let code = jsonObject["code"] as? String
                let message = jsonObject["message"] as? String
                
                if code == "A2300" {
                    let num = jsonObject["data"] as? String
                    certifyCode = num ?? "없음"
                    NSLog("code : \(certifyCode)")
                    NSLog("인증번호 요청 성공 \(String(describing: message!))")
                    completion(certifyCode)
                } else {
                    NSLog("인증번호 요청 실패 \(String(describing: message!))")
                }
                
            } catch let e as NSError {
                NSLog("인증정보 생성 실패 \(e.localizedDescription)")
            }
        }
    }
    
    task.resume()
}

func verifyCodeRequestPost(url: String, param: [String: String], completion: @escaping(_ verifyPhone: VerifyPhone) -> Void) {
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
                let object = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
                guard let jsonObject = object else { return }
                
                let code = jsonObject["code"] as? String
                let message = jsonObject["message"] as? String
                
                if code == "A2400" {
                    let responseData = jsonObject["data"] as? NSDictionary
                    var verifyPhone = VerifyPhone()
                    verifyPhone.userId = responseData?.value(forKey: "userId") as? String
                    if let verify = responseData?.value(forKey: "alreadyExist") as? Bool, verify == true {
                        verifyPhone.alreadyExist = true
                        NSLog(">>>>>true")
                    } else {
                        verifyPhone.alreadyExist = false
                        NSLog(">>>>>false")
                    }
                    
                    completion(verifyPhone)
                    NSLog("인증 성공 \(String(describing: message!))")
                } else {
                    NSLog("인증 실패 \(String(describing: message!))")
                }
                
            } catch let e as NSError {
                NSLog("인증 실패 \(e.localizedDescription)")
            }
        }
    }
    
    task.resume()
}

func checkNameRequest(url: String, completion: @escaping(_ check: String) -> Void){
    let requestUrl = URL(string: url)
    var request = URLRequest(url: requestUrl!)
    
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let e = error {
            NSLog("An error has occurred : \(e.localizedDescription)")
            return
        }
        
        DispatchQueue.main.async {
            completion(String(decoding: data!, as: UTF8.self))
            NSLog(String(decoding: data!, as: UTF8.self))
        }
    }
    
    task.resume()
}
