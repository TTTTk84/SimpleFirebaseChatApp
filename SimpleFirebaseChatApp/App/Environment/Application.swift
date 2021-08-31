//
//  Application.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//


import UIKit


class Application {

    static let shared = Application()
    private init() {}

    private(set) var useCase: ChatUseCaseProtocol!

    func configure(with window: UIWindow) {
        buildLayer()

        let loginViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)

        let loginRouter = LoginRouter(view: loginViewController)
        let loginPresenter = LoginPresenter(router: loginRouter,
                                            useCase: self.useCase)
        loginViewController.inject(presenter: loginPresenter)


        window.rootViewController = navigationController
    }


    // MARK: Private Methods

    private func buildLayer() {

        self.useCase = ChatUseCase()

        let userGateway = UserGateway(useCase: self.useCase)
        self.useCase.userGateway = userGateway
        let userDataStore = UserDataStore()
        userGateway.dataStore = userDataStore

        let chatRoomGateway = ChatRoomGateway(useCase: self.useCase)
        self.useCase.chatRoomGateway = chatRoomGateway
        let chatRoomDataStore = ChatRoomDataStore()
        chatRoomGateway.dataStore = chatRoomDataStore

    }

}
