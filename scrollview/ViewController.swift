//
//  ViewController.swift
//  scrollview
//
//  Created by Luis S Ramos on 3/18/19.
//  Copyright © 2019 Luis S Ramos. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController,UIScrollViewDelegate,UITextFieldDelegate {

    let scrollView = UIScrollView()
    let email: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 1
        return tf
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
         setupProperties()
        scrollView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func keyboardWillShow(_ notificaiton:Notification){
        if let keyboardFrame:NSValue = notificaiton.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardRectangle = keyboardFrame.cgRectValue
            let height = keyboardRectangle.height
           scrollView.setContentOffset(CGPoint(x: 0, y: height - 300), animated: true)
        }
    }
    @objc func keyboardWillHide(_ notificaiton:Notification){
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    private func setupProperties(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .red
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        email.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(email)
        email.heightAnchor.constraint(equalToConstant: 50).isActive = true
        email.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        email.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        email.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        email.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        email.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.becomeFirstResponder()
        return true
    }
}

