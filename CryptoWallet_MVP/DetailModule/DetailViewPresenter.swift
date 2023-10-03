//
//  DetailPresenter.swift
//  CryptoWallet_MVP
//
//  Created by Ilnur Mindubayev on 21.11.2022.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setCoinModelDetailedInfo(coinModel: CoinModel?)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, router: RouterProtocol, coinModel: CoinModel?)
    func setCoinModelDetailedInfo()
}

class DetailViewPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    var coinModel: CoinModel?
    
    required init(view: DetailViewProtocol, router: RouterProtocol, coinModel: CoinModel?) {
        self.view = view
        self.coinModel = coinModel
        self.router = router
    }
    
    func setCoinModelDetailedInfo() {
        self.view?.setCoinModelDetailedInfo(coinModel: coinModel)
    }
}
