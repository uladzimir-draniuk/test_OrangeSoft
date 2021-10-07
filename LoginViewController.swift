//
//  LoginViewController.swift
//  test_api
//
//  Created by elf on 19.09.2021.
//

import UIKit

class LoginViewController: UIViewController {

    let loginName = "orangesoft@yandex.by"
    let loginPassword = "test"

    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var resultText: UITextField!
      
    

    @IBAction func check(_ sender: Any) {
        loginView.endEditing(true)
        if textName.text == loginName, textPassword.text == loginPassword {
            resultText.text = "Вы вошли!"
            performSegue(withIdentifier: "MySeque", sender: self)
        } else {
            self.resultText.text = "Неверное имя или пароль"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first) != nil {
            loginView.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    
}
