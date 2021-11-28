//
//  AddMessageViewController.swift
//  QuickText
//
//  Created by Debashree Joshi on 26/11/21.
//

import UIKit

class AddMessageViewController: UIViewController, UINavigationControllerDelegate {
    
    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.darkText
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = true
        textView.tintColor = UIColor.appThemeColor
        return textView
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.appThemeColor
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private var saveButtonBottomConstraint: NSLayoutConstraint?
    
    var selectedImage: UIImage?
    
    var viewModel: AddMessageViewModel = AddMessageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add Message"
        self.setupLayout()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messageTextView.becomeFirstResponder()
    }
    
    private func setupLayout() {
        self.view.backgroundColor = .white
        self.view.addSubview(messageTextView)
        self.view.addSubview(saveButton)
        
        messageTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        messageTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        messageTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 20).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        saveButtonBottomConstraint = saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        saveButtonBottomConstraint?.isActive = true

        
        saveButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        
    }
    
    @objc func addAction(_ sender: Any) {
        if messageTextView.text.isEmpty {
            self.showAlert(withTitle: "Error", withMessage: "Please enter text!")
        } else {
            viewModel.save(message: messageTextView.text)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            saveButtonBottomConstraint?.constant = -keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        saveButtonBottomConstraint?.constant = -20
    }
}


