//
//  EditViewController.swift
//  QuickText
//
//  Created by Debashree Joshi on 26/11/21.
//

import UIKit

class EditViewController: UIViewController {
    
    
    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .darkText
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.tintColor = UIColor.appThemeColor
        textView.isEditable = true
        return textView
    }()
    
    private let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.appThemeColor
        button.setTitle("Update", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private var updateButtonBottomConstraint: NSLayoutConstraint?

    var viewModel: EditMessageViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Edit Message"
        self.setupLayout()
        messageTextView.text = viewModel?.message
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupLayout() {
        self.view.backgroundColor = .white
        self.view.addSubview(messageTextView)
        self.view.addSubview(updateButton)
        
        messageTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        messageTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        messageTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        
        updateButton.topAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 20).isActive = true
        updateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        updateButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        updateButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        updateButtonBottomConstraint = updateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        updateButtonBottomConstraint?.isActive = true

        
        updateButton.addTarget(self, action: #selector(updateAction), for: .touchUpInside)
        
    }
    
    @objc func updateAction(_ sender: Any) {
        if messageTextView.text.isEmpty {
            self.showAlert(withTitle: "Error", withMessage: "Please enter text!")
        } else {
            viewModel?.updateMessage(message: messageTextView.text)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            updateButtonBottomConstraint?.constant = -keyboardHeight
        }
    }
}
