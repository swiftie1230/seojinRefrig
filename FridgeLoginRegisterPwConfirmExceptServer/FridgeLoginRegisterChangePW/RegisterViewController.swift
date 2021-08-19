//
//  RegisterViewController.swift
//  FridgeLoginRegister
//
//  Created by 황서진 on 2021/07/28.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var pwConfirmLabel: UILabel!
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var pwLabel: UILabel!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var nickNameCheckBtn: UIButton!
    @IBOutlet var emailSentBtn: UIButton!
    @IBOutlet var eyeBtn: UIButton!
    @IBOutlet var pwConfirmTextField: UITextField!
    @IBOutlet var finishButton: UIButton!
    
    var whetherEye = false
    var nickName = false
    var email = false
    var pw = false
    var pwCheck = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pwConfirmLabel.text = ""
        idTextField.delegate = self
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
    
    // 가입하기 버튼 활성화 여부 함수!
    // 채워지지 않은 textField가 한 개라도 존재한다면 가입하기 버튼 비활성화 (lightGray)
    // 두 개 다 채워져 있으면 활성화 (AllowColor)
    func whetherAllowRegisterOrNot () {
        if nickName && email && pw && pwCheck {
            finishButton.backgroundColor = UIColor(named: "AllowColor")
        } else {
            finishButton.backgroundColor = UIColor.lightGray
        }
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    
    @IBAction func idTextFieldEdited(_ sender: UITextField) {
        checkMaxLength(textField: idTextField, maxLength: 8)
        nickNameCheckBtn.backgroundColor = UIColor(named: "AllowColor")
    }
    
    
    
    // 닉네임 중복 확인 버튼 클릭되었을 때 실행될 함수
    @IBAction func nickNameCheckBtnClicked(_ sender: Any) {
        if nickNameCheckBtn.backgroundColor == UIColor(named: "AllowColor") {
            // 서버와 통신 후, 사용 가능하면 textField 파란색
            nickName = true
            // else {whenTextFieldWrongInput -> "이미 사용중인 닉네임입니다."}
            whetherAllowRegisterOrNot()
        }
    }

    
    @IBAction func emailTextFieldEdited(_ sender: UITextField) {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
//        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
//        if emailTest.evaluate(with: emailTextField.text) == true {
//            // 만약 이메일 형식과 일치한다면
//            // 서버 통신 ( 서버에 있는 이메일이라면 -> "이미 등록된 이메일입니다." )
//            // else 허용
//            email = true
//        } else {
//            // 일치하지 않는다면
//            whenTextFieldWrongInput(textField: emailTextField, label: emailLabel, labelText: "형식에 맞지 않는 이메일입니다.")
//            email = false
//        }
//        whetherAllowRegisterOrNot()
    }
    
    @IBAction func emailSendBtnClicked(_ sender: UIButton) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: emailTextField.text) == true {
            emailLabel.text = ""
            emailLabel.textColor = UIColor.lightGray
            emailTextField.layer.borderColor = UIColor.lightGray.cgColor
            // 만약 이메일 형식과 일치한다면
            // 서버 통신 ( 서버에 있는 이메일이라면 -> "이미 등록된 이메일입니다." )
            // else 허용
            email = true
        } else {
            // 일치하지 않는다면
            whenTextFieldWrongInput(textField: emailTextField, label: emailLabel, labelText: "형식에 맞지 않는 이메일입니다.")
            email = false
        }
        whetherAllowRegisterOrNot()
    }
    
    @IBAction func pwTextFieldEdited(_ sender: UITextField) {
        let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        if passwordTest.evaluate(with: pwTextField.text) == true {
            pwLabel.text = ""
            pwLabel.textColor = UIColor.lightGray
            pwTextField.layer.borderColor = UIColor.lightGray.cgColor
            pw = true
        } else {
            whenTextFieldWrongInput(textField: pwTextField, label: pwLabel, labelText: "영어 대/소문자, 숫자, 특수문자 중 3종류 조합 8자리 이상")
            pw = false
        }
        whetherAllowRegisterOrNot()
    }
    
    @IBAction func pwConfirmTextFieldEdited(_ sender: UITextField) {
        if pwTextField.text != pwConfirmTextField.text {
            whenTextFieldWrongInput(textField: pwConfirmTextField, label: pwConfirmLabel, labelText: "비밀번호가 일치하지 않습니다.")
            pwCheck = false
        } else {
            pwConfirmTextField.layer.borderColor = UIColor.lightGray.cgColor
            pwConfirmLabel.text = ""
            pwCheck = true
        }
        whetherAllowRegisterOrNot()
    }
    
    @IBAction func finishBtnClicked(_ sender: UIButton) {
        
        if finishButton.backgroundColor == UIColor(named: "AllowColor") {
                
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
    
    // 뒤로 가기 버튼 클릭되었을 때 실행되는 함수
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
