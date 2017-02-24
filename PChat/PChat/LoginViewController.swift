//
//  LoginViewController.swift
//  PChat
//
//  Created by Yawen on 23/2/2017.
//  Copyright © 2017 YangSzu Kai. All rights reserved.
//

import UIKit
import Parse

extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }
    
}

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "asses.png")!)
        self.passwordTextField.delegate=self
        self.emailTextField.delegate=self
        
         
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.DismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        //signUpButton.backgroundColor = UIColor(white:0.000, alpha:0.07)
        let borderAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = 5.0
        
        signUpButton.frame = CGRect(100, 100, 200, 40)
        signUpButton.setTitle("Sign Up", for: UIControlState.normal)
        signUpButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        signUpButton.backgroundColor = UIColor(white:0.000, alpha:0.07)
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        signUpButton.layer.cornerRadius = cornerRadius
        
        loginButton.frame = CGRect(100, 100, 200, 40)
        loginButton.setTitle("Login", for: UIControlState.normal)
        loginButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        loginButton.backgroundColor = UIColor(white:0.000, alpha:0.07)
        loginButton.layer.borderWidth = 1.0
        loginButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        loginButton.layer.cornerRadius = cornerRadius
        
        
        
        
        /*
        let alertController = UIAlertController(title: "Error", message: "Failed to signup", preferredStyle: .alert)
        

      //  let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in}
       // alertController.addAction(cancelAction)


        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in }
        alertController.addAction(OKAction)
        
        present(alertController, animated: true) {
        
        }
 */
        // Do any additional setup after loading the view.
    }

    @IBAction func onSignUp(_ sender: Any) {
        signUp()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentChatView() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let chatView = mainStoryboard.instantiateViewController(withIdentifier: "ChatViewController") 
        present(chatView, animated: true, completion: nil)
    }
    
    @IBAction func onLogin(_ sender: Any) {
        /*
        do{
            try PFUser.logIn(withUsername: emailTextField.text!, password: passwordTextField.text!)
        }
        catch{
            let alertController = UIAlertController(title: "Error", message: "Failed to login", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in }
            alertController.addAction(OKAction)
            present(alertController, animated: true) {
                
            }

        }*/
        
        PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!) { (response: PFUser?, error: Error?) in
            if let error = error {
                //error
                print(error.localizedDescription)
                let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)" , preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true) {
                    
                }

            } else {
                self.presentChatView()
            }
        }
        
    }
    
    
    
    func signUp() {
       
        let user = PFUser()
        user.username = emailTextField.text
        user.password = passwordTextField.text
        //user.email = emailTextField.text
        // other fields can be set just like with PFObject
        //user["phone"] = "415-392-0202"
        user.signUpInBackground { (succeded, error) in
            if let error = error {
                 let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                print(error.localizedDescription)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true) {
                }
                
            
                // Show the errorString somewhere and let the user try again.
            } else {
                print("sign up!!")
                // Hooray! Let them use the app now.
                // Go to next screen
                self.presentChatView()
            }
        }
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    func DismissKeyboard(){
        self.view.endEditing(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
