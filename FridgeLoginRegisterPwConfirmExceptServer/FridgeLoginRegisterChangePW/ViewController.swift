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

    @IBOutlet var idLabel: UILabel!
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var maintainButton: UIButton!
    @IBOutlet var pwEyeButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    
    var whetherMaintain = false
    var whetherpwEye = false
    var email = false
    var pw = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 비밀번호 가리기&보이기 (눈 모양 버튼 클릭되었을 때)
    @IBAction func pwEyeBtnClicked(_ sender: UIButton) {
        
        if whetherpwEye == true {
            // textField의 특성상 안 보이게 바꾸면 기존에 작성했던 것들이 지워짐.
            // 안 지워지게 하는 방법이 있긴 한데, 따로 클래스를 명시해야 하므로 일단 보류.
            // 사용자에게 알림만 띄워주는 방식으로 일단 구현.
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
    
    // 로그인 유지하기 버튼이 클릭되었을 때
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
    
    // 입력된 정보가 틀렸을 경우, textField가 살짝 떨리는 애니메이션&textField 테두리 붉게 변하는 함수.
    func whenTextFieldWrongInput(textField: UITextField, label: UILabel, labelText: String) -> Void{
        UIView.animate(withDuration: 0.2, animations: {
            textField.frame.origin.x -= 5
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                textField.frame.origin.x += 10
             }, completion: { _ in
                 UIView.animate(withDuration: 0.2, animations: {
                    textField.frame.origin.x -= 5
                })
            })
        })
        label.text = labelText
        label.textColor = UIColor.red
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1.0
    }
    
    // 로그인 버튼 활성화 여부 함수!
    // 채워지지 않은 textField가 한 개라도 존재한다면 로그인 버튼 비활성화 (lightGray)
    // 두 개 다 채워져 있으면 활성화 (AllowColor)
    func whetherAllowLoginOrNot() {
        if email && pw {
            loginButton.backgroundColor = UIColor(named: "AllowColor")
        } else {
            loginButton.backgroundColor = UIColor.lightGray
        }
    }
    
    @IBAction func idTextFieldEdited(_ sender: UITextField) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: idTextField.text) == true {
            // 만약 이메일 형식과 일치한다면
            // 서버 통신 ( 서버에 있는 이메일이라면 -> "이미 등록된 이메일입니다." )
            // else 허용
            idLabel.text = ""
            idLabel.textColor = UIColor.lightGray
            idTextField.layer.borderColor = UIColor.lightGray.cgColor
            email = true
        } else {
            // 일치하지 않는다면
            whenTextFieldWrongInput(textField: idTextField, label: idLabel, labelText: "형식에 맞지 않는 이메일입니다.")
            email = false
        }
        whetherAllowLoginOrNot()
    }
    
    @IBAction func pwTextFieldEditied(_ sender: UITextField) {
        if pwTextField.text?.count != 0 {
            pw = true
        }
        whetherAllowLoginOrNot()
    }
    
    // 로그인 서버 연동 여기에
    @IBAction func loginBtnClicked(_ sender: Any) {
        var id = idTextField.text ?? ""
        var pw = pwTextField.text ?? ""
        
        if loginButton.backgroundColor == UIColor(named: "AllowColor"){
            var parameters = [
                "password" : pw,
                "email" : id
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

