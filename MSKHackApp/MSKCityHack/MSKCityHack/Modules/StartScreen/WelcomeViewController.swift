//
//  ViewController.swift
//  MCHProject
//
//  Created by Савченко Максим Олегович on 12.06.2021.
//

import UIKit

typealias WelcomeProtocols = WelcomeViewOutput & WelcomeViewInput

// MARK: - Protocols

protocol WelcomeViewInput: AnyObject {
    func updateEvent(_ model: [CommonEntity])
    func updateDate(_ model: [CommonEntity])
}

protocol WelcomeViewOutput: AnyObject {
    
}

final class WelcomeViewController: UIViewController {
    
    // MARK: - Protocols
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var dateCollectionView: UICollectionView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var findButton: UIButton!
    
    var eventDataSource: EventDataSourceImp!
    var dateDataSource: DateDataSourceImp!
    var presenter: WelcomePresenterInput!
    
    // MARK: - Protocols
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        configViews()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}


// MARK: - Config Views

private extension WelcomeViewController {
    
    func configViews() {
        
        eventCollectionView.delegate = eventDataSource
        eventCollectionView.dataSource = eventDataSource
        
        dateCollectionView.delegate = dateDataSource
        dateCollectionView.dataSource = dateDataSource
        
        findButton.isEnabled = true
        findButton.addTarget(self, action: #selector(findButtonAction), for: .touchUpInside)
        
        dateDataSource.tapDelegate = self
        eventDataSource.tapDelegate = self
    }
    
    
    @objc func findButtonAction() {
        presenter.tapToFindButton()
    }
    
    @objc func skipButtonAction() {
        presenter.tapToFindButton()
    }
    
}

// MARK: - Imp Protocols

extension WelcomeViewController: WelcomeProtocols {
    
    func updateEvent(_ model: [CommonEntity]) {
        
        eventDataSource.update(model)
        eventCollectionView.reloadData()
    }
    
    func updateDate(_ model: [CommonEntity]) {
        
        dateDataSource.update(model)
        dateCollectionView.reloadData()
    }
    
}

extension WelcomeViewController: DateTapDelegate, EventTapDelegate {
    
    func tapToImage() {
        presenter.tapToPhotoImage()
    }
    
    func reloadData() {
        dateCollectionView.reloadData()
    }
    
}


