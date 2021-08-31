//
//  UserListRouter.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import Foundation

protocol UserListRouterProtocol {
    func transitionToAddAlert()
    func transitionToChatList()
}


class UserListRouter: UserListRouterProtocol {


    private(set) var view: ChatViewProtocol!
    private let useCase = Application.shared.useCase


    init(view: ChatViewProtocol) {
        self.view = view
    }


    func transitionToAddAlert() {

    }

    func transitionToChatList() {
        self.view.popViewController(animated: true)
    }


}

