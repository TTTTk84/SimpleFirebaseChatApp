//
//  LoginViewController.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/14.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login"
        label.textColor = .black
        label.font = UIFont(name: "HiraKakuProN-W6", size: widthValue * 0.2)
        return label
    }()
    
    lazy var stackViews: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = widthValue * 0.1
        return stackView
    }()

    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "メールアドレス"
        return textField
    }()

    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "パスワード"
        return textField
    }()
    
    lazy var formStackViews: [UIStackView] = {
        var stackViews: [UIStackView] = []
        let labelNames: [String] = ["email", "password"]
        let textFields: [UITextField] = [emailTextField, passwordTextField]
        
        for i in 0 ..< 2 {
            var stackView: UIStackView = UIStackView()
            let label = UILabel()
            let form = textFields[i]
            stackView.translatesAutoresizingMaskIntoConstraints = false
            label.text = labelNames[i]
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.addArrangedSubview(label)
            stackView.addArrangedSubview(form)
            stackViews.append(stackView)
        }
        return stackViews
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .green
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(moveToChatList), for: .touchUpInside)
        return button
    }()
    
    lazy var newRegisterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("新規登録の方はこちらから", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(moveToSignUp), for: .touchUpInside)
        return button
    }()

    private var presenter: LoginPresenterProtocol!

    func inject(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(loginLabel)
        view.addSubview(stackViews)
        view.addSubview(loginButton)
        view.addSubview(newRegisterButton)
        for stack in formStackViews {
            stackViews.addArrangedSubview(stack)
        }
        
        self.setupConstraint()

    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: widthValue * 0.3),
            loginLabel.heightAnchor.constraint(equalToConstant: widthValue * 0.25),
            stackViews.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            stackViews.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: widthValue * 0.2),
            stackViews.widthAnchor.constraint(equalToConstant: widthValue * 0.7),
            stackViews.heightAnchor.constraint(equalToConstant: widthValue * 0.5),
            loginButton.topAnchor.constraint(equalTo: stackViews.bottomAnchor, constant: widthValue * 0.2),
            loginButton.widthAnchor.constraint(equalToConstant: widthValue * 0.7),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            newRegisterButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: widthValue * 0.1),
            newRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        ])

    }
    
    @objc func moveToChatList() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }

        self.presenter.checkLoginUser(email: email,
                                      passWord: password) {
            [weak self] bool in
            if bool {
                self?.presenter.tappedLoginButton()
            }

            return
        }
//        self.presenter.tappedLoginButton()
    }
    
    @objc func moveToSignUp() {
        self.presenter.tappedSignUpButton()
    }

}


extension LoginViewController: ChatViewProtocol {
    func reloadTableView() {
    }
    
}
