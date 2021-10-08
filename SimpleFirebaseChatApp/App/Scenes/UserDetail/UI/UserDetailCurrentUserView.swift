//
//  UserDetailCurrentUserView.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/26.
//

import UIKit

class UserDerailCurrentUserView: UIView {

    var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()

    var profileImageView: UIImageView = {
//        let image = UIImageView(image: UIImage(systemName: "gearshape.fill"))
        let image = UIImageView(image: UIImage(named: "boy"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .blue
        image.layer.cornerRadius = widthValue * 0.3 / 2
        return image
    }()

    var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "user 1"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()

    var stackViews: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = widthValue * 0.1
        return stackView
    }()

    var menuStackViews: [UIStackView] = {
        var stackViews: [UIStackView] = []
        let labelNames: [String] = ["招待","設定"]
        let uiImageStrings: [String] = [
            "person.fill.badge.plus",
            "gearshape.fill"
        ]

        for i in 0 ..< labelNames.count {
            var stackView: UIStackView = UIStackView()
            let label = UILabel()
            let imageView = UIImageView(image: UIImage(systemName: uiImageStrings[i]))

            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(label)
            stackViews.append(stackView)

            label.text = labelNames[i]
            label.textAlignment = .center
            label.font = UIFont.italicSystemFont(ofSize: 20)
            label.textColor = .darkGray
            imageView.tintColor = .darkGray
//            label.backgroundColor = .green
//            imageView.backgroundColor = .yellow
//            stackView.backgroundColor = .red
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.distribution = .fill
            stackView.spacing = 0

            stackView.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: widthValue * 0.15).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: widthValue * 0.15).isActive = true
            label.widthAnchor.constraint(equalToConstant: widthValue * 0.15).isActive = true

        }
        return stackViews
    }()

    func setupValue() {

        self.setupLayout()
    }

    private func setupLayout() {

        for stack in menuStackViews {
            stackViews.addArrangedSubview(stack)
        }

        self.addSubview(self.backgroundView)
        self.backgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.backgroundView.widthAnchor.constraint(equalToConstant: widthValue).isActive = true
        self.backgroundView.heightAnchor.constraint(equalToConstant: heightValue * 0.65).isActive = true

        self.addSubview(self.userNameLabel)
        self.userNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.userNameLabel.bottomAnchor.constraint(equalTo: self.backgroundView.bottomAnchor, constant: -widthValue * 0.05).isActive = true
        self.userNameLabel.heightAnchor.constraint(equalToConstant: widthValue * 0.1).isActive = true

        self.addSubview(self.profileImageView)
        self.profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.profileImageView.bottomAnchor.constraint(equalTo: self.userNameLabel.topAnchor, constant: -widthValue * 0.05).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: widthValue * 0.3).isActive = true
        self.profileImageView.heightAnchor.constraint(equalToConstant: widthValue * 0.3).isActive = true

        self.addSubview(self.stackViews)
        self.stackViews.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.stackViews.topAnchor.constraint(equalTo: self.backgroundView.bottomAnchor, constant: widthValue * 0.05).isActive = true
//        self.stackViews.widthAnchor.constraint(equalToConstant: widthValue * 0.7).isActive = true
//        self.stackViews.heightAnchor.constraint(equalToConstant: widthValue * 0.2).isActive = true
    }
}
