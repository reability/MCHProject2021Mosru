//
//  WelcomeAssembly.swift
//  MCHProject
//
//  Created by Савченко Максим Олегович on 12.06.2021.
//

import UIKit

final class WelcomeAssembly {
    
    func assembly() -> WelcomeViewController {
        
        debugPrint("start")
        
        //let v = FeedViewController()
        //return v
        
        let vc = WelcomeViewController().loadStoryboard(identifier: "WelcomeViewController") as! WelcomeViewController
        let presenter = WelcomePresenterImp(view: vc)
        let router: WelcomeRouter = WelcomeRouterImp(view: vc)
        
        let eventDataSource = EventDataSourceImp()
        let dateDataSource = DateDataSourceImp()
        
        vc.presenter = presenter
        
        vc.eventDataSource = eventDataSource
        vc.dateDataSource = dateDataSource
        
        presenter.router = router
        
        return vc
    }
    
}
