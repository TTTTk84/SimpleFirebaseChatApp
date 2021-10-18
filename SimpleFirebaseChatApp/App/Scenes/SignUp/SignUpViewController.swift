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
        button.addTarget(self, action: #selector(tappedProfileImageButton), for: .touchUpInside)
        return button
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

    lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "ユーザーネーム"
        return textField
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
        let textFields: [UITextField] = [emailTextField, passwordTextField, userNameTextField]
        
        for i in 0 ..< 3 {
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

    private var presenter: SignUpPresenterProtocol!

    func inject(presenter: SignUpPresenterProtocol) {
        self.presenter = presenter
    }
    
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

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    @objc func tappedProfileImageButton() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true

        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func moveToChatList() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let userName = userNameTextField.text else { return }


        let image = profileImageButton.imageView?.image
        guard let uploadImage = image?.jpegData(compressionQuality: 0.3) else { return }

        let doc = [
            "email": email,
            "password": password,
            "username": userName,
        ]
        self.presenter.tappedSignUpButton(doc: doc,
                                          imageData: uploadImage)
    }
    
    @objc func moveToLogin() {
        self.presenter.tappedLoginButton()
    }

}

extension SignUpViewController: ChatViewProtocol {
    func reloadTableView() {
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate,
                                UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editImage = info[.editedImage] as? UIImage {
            profileImageButton.setImage(editImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileImageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }

        profileImageButton.setTitle("", for: .normal)
        profileImageButton.imageView?.contentMode = .scaleAspectFill
        profileImageButton.contentHorizontalAlignment = .fill
        profileImageButton.contentVerticalAlignment = .fill
        profileImageButton.clipsToBounds = true

        dismiss(animated: true, completion: nil)
    }
}
