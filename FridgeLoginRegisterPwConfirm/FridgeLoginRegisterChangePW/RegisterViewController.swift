//
//  RegisterViewController.swift
//  FridgeLoginRegister
//
//  Created by 황서진 on 2021/07/28.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController {

    @IBOutlet var pwConfirmLabel: UILabel!
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var nickNameCheckBtn: UIButton!
    @IBOutlet var emailSentBtn: UIButton!
    @IBOutlet var eyeBtn: UIButton!
    @IBOutlet var pwConfirmTextField: UITextField!
    @IBOutlet var finishButton: UIButton!
    
    var whetherEye = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nickNameCheckBtn.layer.cornerRadius = 10
        emailSentBtn.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
        pwConfirmLabel.text = ""
    }
    
    func shakeTextField(textField: UITextField) -> Void{
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
    }
    
    @IBAction func idTextFieldEdited(_ sender: UITextField) {
        var email = emailTextField.text ?? ""
        var pw = pwTextField.text ?? ""
        var nickName = idTextField.text ?? ""
        var pwConfirm = pwConfirmTextField.text ?? ""
        
        if email.count != 0 && pw.count != 0 && nickName.count != 0 && pwConfirm.count != 0 {
            finishButton.backgroundColor = UIColor(named: "AllowColor")
        } else {
            finishButton.backgroundColor = UIColor.lightGray
        }
    }
    
    @IBAction func emailTextFieldEdited(_ sender: UITextField) {
        var email = emailTextField.text ?? ""
        var pw = pwTextField.text ?? ""
        var nickName = idTextField.text ?? ""
        var pwConfirm = pwConfirmTextField.text ?? ""
        if email.count != 0 && pw.count != 0 && nickName.count != 0 && pwConfirm.count != 0 {
            finishButton.backgroundColor = UIColor(named: "AllowColor")
        } else {
            finishButton.backgroundColor = UIColor.lightGray
        }
    }
    
    @IBAction func pwTextFieldEdited(_ sender: UITextField) {
        var email = emailTextField.text ?? ""
        var pw = pwTextField.text ?? ""
        var nickName = idTextField.text ?? ""
        var pwConfirm = pwConfirmTextField.text ?? ""
        if email.count != 0 && pw.count != 0 && nickName.count != 0 && pwConfirm.count != 0 {
            finishButton.backgroundColor = UIColor(named: "AllowColor")
        } else {
            finishButton.backgroundColor = UIColor.lightGray
        }
    }
    
    @IBAction func pwConfirmTextFieldEdited(_ sender: UITextField) {
        var email = emailTextField.text ?? ""
        var pw = pwTextField.text ?? ""
        var nickName = idTextField.text ?? ""
        var pwConfirm = pwConfirmTextField.text ?? ""
        if email.count != 0 && pw.count != 0 && nickName.count != 0 && pwConfirm.count != 0 {
            finishButton.backgroundColor = UIColor(named: "AllowColor")
        } else {
            finishButton.backgroundColor = UIColor.lightGray
        }
    }
    
    @IBAction func finishBtnClicked(_ sender: UIButton) {
        
        var email = emailTextField.text ?? ""
        var pw = pwTextField.text ?? ""
        var nickName = idTextField.text ?? ""
        var pwConfirm = pwConfirmTextField.text ?? ""
        
        if email.count != 0 && pw.count != 0 && nickName.count != 0 && pwConfirm.count != 0 {
            
            if pw != pwConfirm {
                self.pwConfirmLabel.text = "비밀번호가 일치하지 않습니다."
                pwConfirmTextField.layer.borderColor = UIColor.red.cgColor
                pwConfirmTextField.layer.borderWidth = 1.0
                self.shakeTextField(textField: pwConfirmTextField)
                return
            } else {
                pwConfirmTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
                
            var parameters = [
                "email" : email,
                "password" : pw,
                "nickname" : nickName
            ]
                
            AF.request("http://27.35.18.238/api/users", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
                debugPrint(response)
                if var value = response.value {
                    var json = JSON(value)
                    
                    // 응답코드 확인 -> 성공응답코드이면 성공(회원가입이 완료되었습니다.), 아니라면 실패(오류발생:오류코드)
                    
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        }
        
        
    
    }
    
    // 비밀번호 가리기 여부 
    @IBAction func eyeButtonClicked(_ sender: UIButton) {
        
        if whetherEye == true {
            let stopEyeAlert = UIAlertController(title: "경고!", message: "기존에 작성했던 비밀번호가 모두 지워집니다.\n 계속하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            let continueAction = UIAlertAction(title: "네, 계속합니다.", style: UIAlertAction.Style.default, handler: {ACTION in self.pwTextField.isSecureTextEntry = true
                self.eyeBtn.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
                self.whetherEye = false})
            let stopAction = UIAlertAction(title: "아니요.", style: UIAlertAction.Style.default, handler: nil)
            
            stopEyeAlert.addAction(stopAction)
            stopEyeAlert.addAction(continueAction)
            present(stopEyeAlert, animated: true, completion: nil)
        } else {
            self.pwTextField.isSecureTextEntry = false
            eyeBtn.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            whetherEye = true
        }
        
    }
    
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        let stopRegisterAlert = UIAlertController(title: "경고!", message: "회원가입이 완료되지 않았습니다.\n회원가입을 중단하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let stopAction = UIAlertAction(title: "네, 중단합니다.", style: UIAlertAction.Style.default, handler: {ACTION in self.navigationController?.popViewController(animated: true)})
        let continueAction = UIAlertAction(title: "아니요.", style: UIAlertAction.Style.default, handler: nil)
        
        stopRegisterAlert.addAction(stopAction)
        stopRegisterAlert.addAction(continueAction)
        present(stopRegisterAlert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
