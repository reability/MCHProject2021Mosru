//
//  AfishaCardViewController.swift
//  MSKCityHack
//
//  Created by Ванурин Алексей Максимович on 13.06.2021.
//

import Foundation
import UIKit
import WebKit

final class AfishaCardViewController: UIViewController, WKUIDelegate {
    
    private var webView: WKWebView!
    private var eventId: Int
    
    init(eventId: Int) {
        self.eventId = eventId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.mos.ru/afisha/event/\(eventId)")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    
    
}
