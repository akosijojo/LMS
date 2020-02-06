 //
//  ForgotPasswordViewController.swift
//  LMS
//
//  Created by Jojo Destreza on 1/9/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

 import UIKit
 
class ForgotPasswordViewController: UIViewController ,UITextFieldDelegate {
    
    var isShow : Bool = false
    var viewModel : LoginViewModel?
    
    lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    //    lazy var signUpLabel : UILabel = {
    //        let lbl = UILabel()
    //        lbl.text = "Sign up"
    //        lbl.font = UIFont(name: Fonts.medium, size: 20)
    //        lbl.sizeToFit()
    //        lbl.textAlignment = .right
    //        lbl.isUserInteractionEnabled = true
    //        return lbl
    //    }()
    //
    
    lazy var forgotPass : UILabel = {
        let lbl = UILabel()
        lbl.textColor = Config().colors.textColorDark
        lbl.font = UIFont(name: Fonts.bold, size: 20)
        lbl.text = "Forgot your password?"
        lbl.textAlignment = .center
//        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    
    lazy var forgotPassDescription : UILabel = {
        let lbl = UILabel()
        lbl.textColor = Config().colors.textColorDark
        lbl.font = UIFont(name: Fonts.regular, size: 14)
        lbl.text = "Enter your email below to recieve your password reset instructions"
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
//        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    lazy var userNameTextField : TextField = {
        let txt = TextField()
        txt.placeholder = "Email address"
        txt.layer.borderWidth = 1
        txt.layer.borderColor = Config().colors.borderColor.cgColor
        txt.layer.cornerRadius = 20
        txt.keyboardType = .emailAddress
        txt.backgroundColor = Config().colors.borderColor
        txt.textColor = Config().colors.textColorDark
        txt.font = UIFont(name: Fonts.regular, size: 16)
        return txt
    }()
    
    lazy var loginButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Send", for: .normal)
        btn.setTitleColor(Config().colors.whiteBackground, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = Config().colors.lightGraybackground.cgColor
        btn.layer.cornerRadius = 20
        btn.backgroundColor = Config().colors.lightBlueBgColor
        btn.titleLabel?.font = UIFont(name: Fonts.regular, size: 16)
        btn.addTarget(self, action: #selector(submitEmailAction), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        view.backgroundColor = .white
        hidesKeyboardOnTapArround()
        setUpListener()
        setUpView()
        userNameTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUpNavigationBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(whenShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(whenHideKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setUpNavigationBar() {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "arrow_left")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = Config().colors.blueBgColor
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        let leftButton = UIBarButtonItem(customView: backButton)
        
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
            if userNameTextField.isFirstResponder {
                if !aRect.contains(userNameTextField.frame.origin) {
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
        
        scrollView.addSubview(forgotPass)
        forgotPass.snp.makeConstraints { (make) in
            make.centerY.equalTo(scrollView).offset(-140)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(40)
        }
        
        scrollView.addSubview(forgotPassDescription)
        forgotPassDescription.snp.makeConstraints { (make) in
            make.top.equalTo(forgotPass.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(80)
        }
        
        scrollView.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(forgotPassDescription.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(40)
        }
    
        scrollView.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(userNameTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(40)
            make.bottom.equalTo(scrollView).offset(-20)
        }
       
    }
    
    @objc func submitEmailAction() {
        
    }
    
    
 }
