//
//  Router.swift
//  CryptoWallet_MVP
//
//  Created by Ilnur Mindubayev on 20.11.2022.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: ModuleBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showLogin()
    func showMain()
    func showDetail(coinModel: CoinModel?)
    var userDefaultsManager: UserDefaultsManagerProtocol? { get }
}

class Router: RouterProtocol {

    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    var userDefaultsManager: UserDefaultsManagerProtocol?
    
    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol, userDefaultsManager: UserDefaultsManagerProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
        self.userDefaultsManager = userDefaultsManager
    }
    
    func initialViewController() {
        if let userDefaultsManager = userDefaultsManager {
            userDefaultsManager.isLoggedIn() ? showMain() : showLogin()
        } else {
            showLogin()
        }
    }
    
    func showLogin() {
        if let navigationController = navigationController {
            guard let loginViewController = moduleBuilder?.createLoginModule(router: self) else { return }
            navigationController.viewControllers = [loginViewController]
        }
    }
    
    func showMain() {
        if let navigationController = navigationController {
            guard let mainViewController = moduleBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(coinModel: CoinModel?) {
        if let navigationController = navigationController {
            guard let detailViewController = moduleBuilder?.createDetailModule(coinModel: coinModel, router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}
