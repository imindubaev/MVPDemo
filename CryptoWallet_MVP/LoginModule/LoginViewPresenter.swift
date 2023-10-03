//
//  LoginPresenter.swift
//  CryptoWallet_MVP
//
//  Created by Ilnur Mindubayev on 21.11.2022.
//

import Foundation

protocol LoginViewProtocol: AnyObject {
    func loginFailed()
}

protocol LoginViewPresenterProtocol: AnyObject {
    init(view: LoginViewProtocol, router: RouterProtocol, userDefaultsManager: UserDefaultsManagerProtocol)
    func loginButtonPressed(login: String, password: String)
}

class LoginViewPresenter: LoginViewPresenterProtocol {
        
    weak var view: LoginViewProtocol?
    var router: RouterProtocol?
    var userDefaultsManager: UserDefaultsManagerProtocol?
    
    required init(view: LoginViewProtocol, router: RouterProtocol, userDefaultsManager: UserDefaultsManagerProtocol) {
        self.view = view
        self.router = router
        self.userDefaultsManager = userDefaultsManager
    }
    
    func loginButtonPressed(login: String, password: String) {
        
        if login != User.logins.first?.login || password != User.logins.first?.passwords {
            userDefaultsManager?.saveIsLoggedIn(isLoggedIn: false)
            self.view?.loginFailed()
        } else {
            userDefaultsManager?.saveIsLoggedIn(isLoggedIn: true)
            router?.showMain()
        }
    }
}

