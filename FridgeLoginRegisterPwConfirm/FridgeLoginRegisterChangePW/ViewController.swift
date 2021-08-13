//
//  ViewController.swift
//  FridgeLoginRegister
//
//  Created by 황서진 on 2021/07/28.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var maintainButton: UIButton!
    @IBOutlet var pwEyeButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    
    var whetherMaintain = false
    var whetherpwEye = false
    var pwText : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pwEyeBtnClicked(_ sender: UIButton) {
        
        if whetherpwEye == true {
            let stopEyeAlert = UIAlertController(title: "경고!", message: "기존에 작성했던 비밀번호가 모두 지워집니다.\n 계속하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            let continueAction = UIAlertAction(title: "네, 계속합니다.", style: UIAlertAction.Style.default, handler: {ACTION in self.pwTextField.isSecureTextEntry = true
                self.pwEyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
                self.whetherpwEye = false})
            let stopAction = UIAlertAction(title: "아니요.", style: UIAlertAction.Style.default, handler: nil)
            
            stopEyeAlert.addAction(stopAction)
            stopEyeAlert.addAction(continueAction)
            present(stopEyeAlert, animated: true, completion: nil)
        } else {
            self.pwTextField.isSecureTextEntry = false
            self.pwEyeButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            self.whetherpwEye = true
        }
    }
    
    
    @IBAction func maintainBtnClicked(_ sender: UIButton) {
        if whetherMaintain == true {
            // 로그인 유지 끄는 코드 구현 여기에!
            maintainButton.setImage(UIImage(systemName: "squareshape"), for: .normal)
            whetherMaintain = false
        } else {
            // 로그인 유지 켜는 코드 구현 여기에!
            maintainButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            whetherMaintain = true
        }
        
    }
    
    @IBAction func idTextFieldEdited(_ sender: UITextField) {
        var id = idTextField.text ?? ""
        var pw = pwTextField.text ?? ""
        
        if id.count != 0 && pw.count != 0 {
            loginButton.backgroundColor = UIColor(named: "AllowColor")
        } else {
            loginButton.backgroundColor = UIColor.lightGray
        }
    }
    
    @IBAction func pwTextFieldEditied(_ sender: UITextField) {
        var id = idTextField.text ?? ""
        var pw = pwTextField.text ?? ""
        
        if id.count != 0 && pw.count != 0 {
            loginButton.backgroundColor = UIColor(named: "AllowColor")
        } else {
            loginButton.backgroundColor = UIColor.lightGray
        }
    }
    
    // 로그인 서버 연동 여기에
    @IBAction func loginBtnClicked(_ sender: Any) {
        var id = idTextField.text ?? ""
        var pw = pwTextField.text ?? ""
        
        if id.count != 0 && pw.count != 0 {
            var parameters = [
                "password" : pw,
                // 아이디?
                "nickname" : id
            ]
            
            
            
            AF.request("http://27.35.18.238/api/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
                debugPrint(response)
                
                if var value = response.value {
                    var json = JSON(value)
                    
    //                guard let VC = self.storyboard?.instantiateViewController(identifier: "tabBarController") else { return }
    //                self.present(VC, animated: true)
                    
                    
                }
            }
        }
        
        
    }
    

}

