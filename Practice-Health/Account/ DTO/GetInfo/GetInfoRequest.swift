//
//  GetInfoRequest.swift
//  GetInfoRequest
//
//  Created by 김효준 on 2021/09/06.
//

import Foundation
import UIKit

func GetInfoRequest(url: String, view: UIViewController, completion: @escaping(_ info: GetInfo_Account_RES) -> Void) {
    let requestUrl = URL(string: url)
    var request = URLRequest(url: requestUrl!)
    
    let accessToken = UserDefaults.standard.string(forKey: "accessToken")
    let grantType = UserDefaults.standard.string(forKey: "grantType")
    NSLog(grantType!)
    NSLog(accessToken!)
    
    request.httpMethod = "GET"
    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.addValue(grantType! + accessToken!, forHTTPHeaderField: "token")
    
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
                NSLog(code!)
                if code == "A1100" {
                    NSLog("회원정보 조회 성공! \(String(describing: message!))")
                    let userInfo = jsonObject["data"] as? NSDictionary
                    var info = GetInfo_Account_RES()
                    info.userId = userInfo!.value(forKey: "userId") as? String
                    info.name = userInfo!.value(forKey: "name") as? String
                    
                    completion(info)
                } else {
                    NSLog("회원정보 조회 실패 \(String(describing: message!))")
                }
            } catch let e as NSError {
                NSLog("회원정보 조회 실패... \(e.localizedDescription)")
                view.alert("회원정보 조회를 실패하였습니다.", view: view)
            }
        }
    }
    
    task.resume()
}
