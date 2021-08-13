//
//  changePwViewController.swift
//  FridgeLoginRegister
//
//  Created by 황서진 on 2021/08/10.
//

import UIKit

class changePwViewController: UIViewController {

    @IBOutlet var changePwBtn: UIButton!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var pwCheckTextField: UITextField!
    @IBOutlet var pwEyeButton: UIButton!
    @IBOutlet var pwCheckEyeButton: UIButton!
    
    
    var pwWhetherEye = false
    var pwCheckWhetherEye = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @IBAction func pwEyeBtnClicked(_ sender: UIButton) {
        if pwWhetherEye == true {
            let stopEyeAlert = UIAlertController(title: "경고!", message: "기존에 작성했던 비밀번호가 모두 지워집니다.\n 계속하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            let continueAction = UIAlertAction(title: "네, 계속합니다.", style: UIAlertAction.Style.default, handler: {ACTION in self.pwTextField.isSecureTextEntry = true
                self.pwEyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
                self.pwWhetherEye = false})
            let stopAction = UIAlertAction(title: "아니요.", style: UIAlertAction.Style.default, handler: nil)
            
            stopEyeAlert.addAction(stopAction)
            stopEyeAlert.addAction(continueAction)
            present(stopEyeAlert, animated: true, completion: nil)
        } else {
            self.pwTextField.isSecureTextEntry = false
            pwEyeButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            pwWhetherEye = true
        }
        
    }
    
    @IBAction func pwCheckEyeBtnClicked(_ sender: UIButton) {
        if pwCheckWhetherEye == true {
            let stopEyeAlert = UIAlertController(title: "경고!", message: "기존에 작성했던 비밀번호가 모두 지워집니다.\n 계속하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            let continueAction = UIAlertAction(title: "네, 계속합니다.", style: UIAlertAction.Style.default, handler: {ACTION in self.pwTextField.isSecureTextEntry = true
                self.pwCheckEyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
                self.pwCheckWhetherEye = false})
            let stopAction = UIAlertAction(title: "아니요.", style: UIAlertAction.Style.default, handler: nil)
            
            stopEyeAlert.addAction(stopAction)
            stopEyeAlert.addAction(continueAction)
            present(stopEyeAlert, animated: true, completion: nil)
        } else {
            self.pwCheckTextField.isSecureTextEntry = false
            pwCheckEyeButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            pwCheckWhetherEye = true
        }
    }
    
    @IBAction func changePwBtnClicked(_ sender: UIButton) {
        
        if self.changePwBtn.titleLabel?.text == "로그인 화면으로 돌아가기" {
            _ = navigationController?.popToRootViewController(animated: true)
        } else {
            // 비밀번호 재설정한 것 서버에 업데이트 하는 과정 여기에!
            self.changePwBtn.setTitle("로그인 화면으로 돌아가기", for: .normal)
        }
        
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        let stopChangePWAlert = UIAlertController(title: "경고!", message: "비밀번호 재설정이 완료되지 않았습니다.\n재설정을 중단하고 이전 화면으로 돌아가시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let stopAction = UIAlertAction(title: "네, 중단하고 돌아갑니다.", style: UIAlertAction.Style.default, handler: {ACTION in self.navigationController?.popViewController(animated: true)})
        let continueAction = UIAlertAction(title: "아니요.", style: UIAlertAction.Style.default, handler: nil)
        
        stopChangePWAlert.addAction(stopAction)
        stopChangePWAlert.addAction(continueAction)
        present(stopChangePWAlert, animated: true, completion: nil)
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
