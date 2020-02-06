//
//  LoginViewController.swift
//  LMS
//
//  Created by Jojo Destreza on 01/09/20.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController ,UITextFieldDelegate {
    
    var isShow : Bool = false
    var viewModel : LoginViewModel?
    
    lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    lazy var loginLogo : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "app_login_oalmsimg")
        img.contentMode = .scaleAspectFit
        img.layer.masksToBounds = true
        return img
    }()
    
    lazy var userNameTextField : CustomTextFieldwithImage = {
        let txt = CustomTextFieldwithImage()
        txt.textField.placeholder = "Email address / user ID"
        txt.layer.borderWidth = 1
        txt.layer.borderColor = Config().colors.borderColor.cgColor
        txt.layer.cornerRadius = 20
        txt.textField.keyboardType = .emailAddress
        txt.backgroundColor = Config().colors.borderColor
        txt.imageViewL.image = UIImage(named: "user")?.withRenderingMode(.alwaysTemplate)
        txt.imageViewL.tintColor = Config().colors.textColorLight
        txt.setUpView(layout: .left)
        return txt
    }()
    
    lazy var passwordTextField : CustomTextFieldwithImage = {
        let v                = CustomTextFieldwithImage()
        v.layer.cornerRadius = 20
        v.textField.placeholder        = "Password"
        v.textField.isSecureTextEntry  = true
        v.imageViewL.image = UIImage(named: "lock")?.withRenderingMode(.alwaysTemplate)
        v.imageViewL.tintColor = Config().colors.textColorLight
        v.imageViewR.image = UIImage(named: "eye")?.withRenderingMode(.alwaysTemplate)
        v.imageViewR.tintColor = Config().colors.textColorLight
        v.layer.borderWidth = 1
        v.layer.borderColor = Config().colors.borderColor.cgColor
        v.layer.cornerRadius = 20
        v.backgroundColor = Config().colors.borderColor
        v.setUpView()
        return v
    }()
    
    lazy var loginButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(Config().colors.whiteBackground, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = Config().colors.lightGraybackground.cgColor
        btn.layer.cornerRadius = 20
        btn.backgroundColor = Config().colors.lightBlueBgColor
        btn.titleLabel?.font = UIFont(name: Fonts.regular, size: 16)
        btn.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var forgotPass : UILabel = {
        let lbl = UILabel()
        lbl.textColor = Config().colors.textColorDark
        lbl.font = UIFont(name: Fonts.regular, size: 14)
        lbl.text = "Forgot Password?"
        lbl.textAlignment = .center
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    lazy var termsAndCondition : UILabel = {
        let lbl = UILabel()
        lbl.textColor = Config().colors.textColorDark
        lbl.font = UIFont(name: Fonts.regular, size: 14)
        lbl.text = "By logging in,\n you must agree with Terms and Conditions"
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        hidesKeyboardOnTapArround()
        setUpListener()
        setUpView()
        userNameTextField.textField.delegate = self
        passwordTextField.textField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    
    }
    
    func appleButtonAction() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(whenShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(whenHideKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // hide navigation bar
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // show navigation bar
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField.textField {
            self.passwordTextField.becomeFirstResponder()
        }else {
            textField.resignFirstResponder()
        }
        return true
    }
   
    @objc func whenShowKeyboard(_ notification : NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            self.scrollView.contentInset = contentInsets
            var aRect: CGRect = self.scrollView.frame
            aRect.size.height -= keyboardHeight
            if userNameTextField.textField.isFirstResponder {
                if !aRect.contains(userNameTextField.frame.origin) {
                    self.scrollView.setContentOffset(CGPoint(x: 0, y: 80), animated: true)
                }
            }else if passwordTextField.isFirstResponder {
                if !aRect.contains(passwordTextField.frame.origin) {
                    self.scrollView.setContentOffset(CGPoint(x: 0, y: 80), animated: true)
                }
            }else {
                
            }
            
        }
    }
    
    @objc func whenHideKeyboard(_ notification : NSNotification) {
       scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func setUpListener() {
//        self.viewModel?.onSuccessGettingList = { [weak self] data in
//            DispatchQueue.main.async {
//                self?.dismiss(animated: true, completion: {
//                    self?.loginSuccessAction(data: data)
//                })
//            }
//        }
//
//        self.viewModel?.onErrorHandling = { [weak self
//            ] status in
//            DispatchQueue.main.async {
//                self?.dismiss(animated: true, completion: {
//                    self?.alert(btn: "OK", title: "", msg: status?.message ?? "Something went wrong")
//                })
//            }
//        }
    }
    
    func alert(btn: String,title: String,msg: String){
        let alert = self.alert(btn, title, msg) { (action) in
            
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func setUpView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        print("SCREEN WIDTH : \(Config().screenWidth)")
        scrollView.addSubview(loginLogo)
        loginLogo.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView).offset(100)
            make.centerX.equalTo(view)
            make.width.equalTo(250)
            make.height.equalTo(200)
        }
        
        scrollView.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(loginLogo.snp.bottom).offset(40)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(40)
        }
        
        scrollView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(userNameTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(40)
        }
        
        scrollView.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(40)
        }
        
        scrollView.addSubview(forgotPass)
        forgotPass.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(40)
        }
        
        scrollView.addSubview(termsAndCondition)
        termsAndCondition.snp.makeConstraints { (make) in
            make.top.equalTo(forgotPass.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(80)
            make.bottom.equalTo(scrollView).offset(-20)
        }
        
        
        
        // gesture of showing password
        let showPass = UITapGestureRecognizer(target: self, action: #selector(showPasswordAction(_:)))
        self.passwordTextField.imageViewR.addGestureRecognizer(showPass)
        
        let forgotPassTap = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordAction))
        self.forgotPass.addGestureRecognizer(forgotPassTap)
        
        let termsTap = UITapGestureRecognizer(target: self, action: #selector(termsAction))
        self.termsAndCondition.addGestureRecognizer(termsTap)
        
    }
    
    @objc func forgotPasswordAction() {
        let controller = ForgotPasswordViewController()
//        controller.modalTransitionStyle = .coverVertical
//        controller.modalPresentationStyle = .pageSheet
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @objc func termsAction() {
        if let url = URL(string: "https://oav2.orangeapps.ph/OA_resources/OrangeApps_User_Terms_and_Conditions.pdf") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func loginSuccessAction(data: UsersData?) {
        // where did it go on success logging in
        
    }
    
    @objc func loginButtonAction() {
        // action triggered on click login
        
        var app = AppCoordinator(window: UIApplication.shared.keyWindow ?? UIWindow())
        
        app.start()
        
        
    }
    
    @objc func showPasswordAction(_ sender: UIGestureRecognizer) {
        if !isShow{
            self.passwordTextField.imageViewR.image = UIImage(named: "eye_slash")?.withRenderingMode(.alwaysTemplate)
            isShow = true
            self.passwordTextField.textField.isSecureTextEntry = false
        }else {
            self.passwordTextField.imageViewR.image = UIImage(named: "eye")?.withRenderingMode(.alwaysTemplate)
            isShow = false
            self.passwordTextField.textField.isSecureTextEntry = true
        }
    }
    
}
