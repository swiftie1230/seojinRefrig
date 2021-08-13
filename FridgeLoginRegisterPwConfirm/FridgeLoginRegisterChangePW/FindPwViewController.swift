//
//  FindPwViewController.swift
//  FridgeLoginRegister
//
//  Created by 황서진 on 2021/08/10.
//

import UIKit

class FindPwViewController: UIViewController {

    @IBOutlet var emailCheckBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailCheckBtn.layer.cornerRadius = 10
    }
    
    @IBAction func sendBtnClicked(_ sender: UIButton) {
        // 비밀번호 발송? 아니면 인증 번호?
        // 정확하게 나와있지 않으니 일단 여기까지만!
    }
    
    @IBAction func backToLoginBtnClicked(_ sender: UIButton) {
        
        _ = navigationController?.popViewController(animated: true)
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
