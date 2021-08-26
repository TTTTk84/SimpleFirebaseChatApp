//
//  SignUpViewController.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/14.
//

import UIKit

class SignUpViewController: UIViewController {
    let widthValue = UIScreen.main.bounds.width
    let heightValue = UIScreen.main.bounds.height
    
    lazy var profileImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("プロフィール画像", for: .normal)
        button.backgroundColor = .green
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = widthValue * 0.5 / 2
        button.addTarget(self, action: #selector(moveToChatList), for: .touchUpInside)
        return button
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
    
    lazy var formStackViews: [UIStackView] = {
        var stackViews: [UIStackView] = []
        let labelNames: [String] = ["email", "password", "user name"]
        let placeholderNames: [String] = ["メールアドレス","パスワード","ユーザの名前"]
        
        for i in 0 ..< 3 {
            var stackView: UIStackView = UIStackView()
            let label = UILabel()
            let form = UITextField()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            label.text = labelNames[i]
            form.placeholder = placeholderNames[i]
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.addArrangedSubview(label)
            stackView.addArrangedSubview(form)
            stackViews.append(stackView)
        }
        return stackViews
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .green
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(moveToChatList), for: .touchUpInside)
        return button
    }()
    
    lazy var newloginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("既にアカウントを持っている方はこちら", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(moveToLogin), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(profileImageButton)
        view.addSubview(stackViews)
        view.addSubview(registerButton)
        view.addSubview(newloginButton)
        for stack in formStackViews {
            stackViews.addArrangedSubview(stack)
        }
        
        
        NSLayoutConstraint.activate([
            profileImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            profileImageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: widthValue * 0.3),
            profileImageButton.heightAnchor.constraint(equalToConstant: widthValue * 0.5),
            profileImageButton.widthAnchor.constraint(equalToConstant: widthValue * 0.5),
            stackViews.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            stackViews.topAnchor.constraint(equalTo: profileImageButton.bottomAnchor, constant: widthValue * 0.1),
            stackViews.widthAnchor.constraint(equalToConstant: widthValue * 0.7),
            stackViews.heightAnchor.constraint(equalToConstant: widthValue * 0.5),
            registerButton.topAnchor.constraint(equalTo: stackViews.bottomAnchor, constant: widthValue * 0.2),
            registerButton.widthAnchor.constraint(equalToConstant: widthValue * 0.7),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            newloginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: widthValue * 0.1),
            newloginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        ])
        
        
        
    }
    
    @objc func moveToChatList() {
        setAnimation()
        
        let chatListViewController = ChatListViewController()
        let navigationController = UINavigationController(rootViewController: chatListViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func moveToLogin() {
        setAnimation()
        
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true, completion: nil)
    }
    
    func setAnimation() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
    }
}
