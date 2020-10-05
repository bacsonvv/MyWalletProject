//
//  LoginViewController.swift
//  MyWalletProject
//
//  Created by Hoang Lam on 9/30/20.
//  Copyright © 2020 Vuong Vu Bac Son. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import Firebase

protocol LoginViewControllerDelegate {
    func nextCategory(viewController:UIViewController)
    func autoLogin()
}

class LoginViewController: UIViewController {
    
    var window: UIWindow?
    @IBOutlet weak var btnLoginFacebook: UIButton!
    @IBOutlet weak var btnLoginGoogle: UIButton!
    @IBOutlet weak var btnLoginApple: UIButton!
    
    var isLogined:Bool = UserDefaults.standard.bool(forKey: "login")
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customButton(listButton: [btnLoginFacebook,btnLoginGoogle,btnLoginApple])
    }
    
    //MARK: - viewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        autoLogin()
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    
    func customButton(listButton:[UIButton]) {
        for button in listButton {
            button.layer.borderWidth = 1
            button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            button.layer.cornerRadius = 6
        }
    }
    
    //MARK: - Login facebook click
    @IBAction func btnLoginFacebookClick(_ sender: Any) {
        LoginFbPresenter().fbLogin(viewController: self)
    }
    
    @IBAction func btnLoginGoogleClick(_ sender: Any) {
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func btnLoginAppleClick(_ sender: Any) {
        
    }
    
}

extension LoginViewController:LoginViewControllerDelegate{
    func nextCategory(viewController: UIViewController) {
        let vc = UIStoryboard.init(name: "Signin", bundle: nil).instantiateViewController(withIdentifier: "TestLoginViewController") as! TestLoginViewController
        vc.modalPresentationStyle = .fullScreen
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func autoLogin(){
        print(isLogined)
        if isLogined == true {
            nextCategory(viewController: self)
        }
    }
}
