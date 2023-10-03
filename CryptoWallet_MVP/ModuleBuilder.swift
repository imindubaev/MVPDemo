//
//  ModuleBuilder.swift
//  CryptoWallet_MVP
//
//  Created by Ilnur Mindubayev on 20.11.2022.
//

import UIKit

protocol ModuleBuilderProtocol {
    func createLoginModule(router: RouterProtocol) -> UIViewController
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(coinModel: CoinModel?, router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    
    func createLoginModule(router: RouterProtocol) -> UIViewController {
        let view = LoginViewController()
        let userDefaultsManager = UserDefaultsManager()
        let presenter = LoginViewPresenter(view: view, router: router, userDefaultsManager: userDefaultsManager)
        view.presenter = presenter
        return view
    }
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let userDefaultsManager = UserDefaultsManager()
        let presenter = MainViewPresenter(view: view, networkService: networkService, router: router, userDefaultsManager: userDefaultsManager)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(coinModel: CoinModel?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailViewPresenter(view: view, router: router, coinModel: coinModel)
        view.presenter = presenter
        return view
    }
}
