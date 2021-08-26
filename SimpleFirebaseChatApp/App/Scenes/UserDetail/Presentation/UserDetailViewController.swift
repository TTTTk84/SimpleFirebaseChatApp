//
//  UserDetailViewController.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//

import UIKit

class UserDetailViewController: UIViewController {

    private var userDetailView: UserDerailCurrentUserView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.userDetailView = UserDerailCurrentUserView()
        self.userDetailView.setupValue()

        self.view.addSubview(self.userDetailView)
        self.userDetailView.translatesAutoresizingMaskIntoConstraints = false
        self.userDetailView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.userDetailView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.userDetailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.userDetailView.widthAnchor.constraint(equalToConstant: widthValue).isActive = true
        self.userDetailView.heightAnchor.constraint(equalToConstant: heightValue).isActive = true
    }
    
}
