//
//  WelcomeRouter.swift
//  MCHProject
//
//  Created by Савченко Максим Олегович on 12.06.2021.
//

import Foundation
import UIKit

protocol WelcomeRouter: AnyObject {
    func goToMainScreen()
    func goToPhotoScreen()
}

final class WelcomeRouterImp: WelcomeRouter {
    
    weak var view: WelcomeViewController?
    
    init(view: WelcomeViewController) {
        self.view = view
    }
    
    func goToMainScreen() {
        
        let vc = FeedViewController()
        
        view?.navigationController?.pushViewController(vc, animated: true)
        //view?.present(vc, animated: true, completion: nil)
        
        //view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToPhotoScreen() {
        
        let vc = PhotoViewController().loadStoryboard(identifier: "PhotoViewController")
        
        view?.present(vc, animated: true, completion: nil)

    }
    
}

