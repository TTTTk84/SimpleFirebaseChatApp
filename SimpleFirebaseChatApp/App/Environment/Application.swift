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

//        let todoGateway = TodoGateway(useCase: self.useCase)
//
//        useCase.todoGateway = todoGateway
//
//        let todoDataStore = TodoDataStore()
//        todoGateway.dataStore = todoDataStore

        let userGateway = UserGateway(useCase: self.useCase)

        self.useCase.userGateway = userGateway
        

    }

}
