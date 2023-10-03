//
//  MainViewController.swift
//  CryptoWallet_MVP
//
//  Created by Ilnur Mindubayev on 20.11.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    
    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)
    
    private let loadingSpinner: UIActivityIndicatorView = {
        let loadingSpinner = UIActivityIndicatorView()
        loadingSpinner.style = .large
        loadingSpinner.hidesWhenStopped = true
        return loadingSpinner
    }()
    
    private let sortByPriceSegmentedControl = UISegmentedControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLogOutButton()
        setupTableView()
        
        tableView.register(CoinCell.self, forCellReuseIdentifier: "CoinCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        
        setupSegmentedControl()
        setupSpinner()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.coinModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell", for: indexPath) as? CoinCell else { fatalError() }
        
        let coinModel = presenter.coinModels?[indexPath.row]
        cell.coin = coinModel

        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let coinModel = presenter.coinModels?[indexPath.row]
        presenter.coinCellPressed(coinModel: coinModel)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController {
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainViewController {
    func setupSpinner() {
        view.addSubview(loadingSpinner)
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        loadingSpinner.startAnimating()
    }
}

extension MainViewController {
    func setupLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(logOutButtonPressed))
    }
    @objc private func logOutButtonPressed() {
        presenter.logOutButtonPressed()
    }
}

extension MainViewController {
    func setupSegmentedControl() {
        view.addSubview(sortByPriceSegmentedControl)
        sortByPriceSegmentedControl.insertSegment(withTitle: "Daily price change ↑ ", at: 0, animated: true)
        sortByPriceSegmentedControl.insertSegment(withTitle: "Daily price change ↓ ", at: 1, animated: true)
        
        sortByPriceSegmentedControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            sortByPriceSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sortByPriceSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            sortByPriceSegmentedControl.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
            sortByPriceSegmentedControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])

        sortByPriceSegmentedControl.selectedSegmentIndex = 0
        sortByPriceSegmentedControl.addTarget(self, action: #selector(sortByPriceSegmentedControlAction(sender:)), for: .valueChanged)

    }

    @objc func sortByPriceSegmentedControlAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            presenter.sortCoinsPriceChangeMaxToMin()
        case 1:
            presenter.sortCoinsPriceChangeMinToMax()
        default: break
        }
        
    }
}

extension MainViewController: MainViewProtocol {
    func success() {
        tableView.reloadData()
        loadingSpinner.stopAnimating()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
