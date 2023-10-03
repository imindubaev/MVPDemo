//
//  MainPresenter.swift
//  CryptoWallet_MVP
//
//  Created by Ilnur Mindubayev on 20.11.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, userDefaultsManager: UserDefaultsManagerProtocol)
    func getCoinModels(forCoinsEnum: [CoinsEnum])
    var coinModels: [CoinModel]? { get set }
    func coinCellPressed(coinModel: CoinModel?)
    func logOutButtonPressed()
    func sortCoinsPriceChangeMaxToMin()
    func sortCoinsPriceChangeMinToMax()
}

class MainViewPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var coinModels: [CoinModel]?
    var userDefaultsManager: UserDefaultsManagerProtocol?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, userDefaultsManager: UserDefaultsManagerProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.userDefaultsManager = userDefaultsManager
        getCoinModels(forCoinsEnum: CoinsEnum.allCases)
    }
    
    
    func getCoinModels(forCoinsEnum: [CoinsEnum]) {
        
        let dispatchGroup = DispatchGroup()
        var temporaryCoinModels = [CoinModel]()
        
        for coinEnum in forCoinsEnum {

            dispatchGroup.enter()
            
            networkService.getCoinModel(coinsEnum: coinEnum) { [weak self] result in
                guard self != nil else { return }
                switch result {
                case .success(let coinModel):
                    if let coinModel = coinModel {
                        if coinModel.data?.name != nil {
                            temporaryCoinModels.append(coinModel)
                        }
                    } else {
                        return
                    }
                    dispatchGroup.leave()
                case .failure(let error):
                    print(error)
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.coinModels = temporaryCoinModels
            self.sortCoinsPriceChangeMaxToMin()
            self.view?.success()
        }
    }
    
    func coinCellPressed(coinModel: CoinModel?) {
        router?.showDetail(coinModel: coinModel)
    }
    
    func logOutButtonPressed() {
        userDefaultsManager?.saveIsLoggedIn(isLoggedIn: false)
        router?.showLogin()
    }
    
    func sortCoinsPriceChangeMaxToMin() {
        if coinModels != nil {
            coinModels?.sort(by: {$0 > $1})
            self.view?.success()
        } else {
            self.view?.failure(error: "failed to sort coins" as! Error)
        }
    }
    
    func sortCoinsPriceChangeMinToMax() {
        if coinModels != nil {
            coinModels?.sort()
            self.view?.success()
        } else {
            self.view?.failure(error: "failed to sort coins" as! Error)
        }
    }
}

