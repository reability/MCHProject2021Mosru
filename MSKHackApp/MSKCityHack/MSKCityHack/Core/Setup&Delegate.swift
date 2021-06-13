//
//  Setup&Delegate.swift
//  MCHProject
//
//  Created by Савченко Максим Олегович on 12.06.2021.
//

import Foundation

// MARK: - Send info from tableview to cells and taps

protocol Setupable: AnyObject {
    func setup(_ object: Any)
}

protocol Delegatable: AnyObject {
    var delegate: AnyObject? { get set }
}

protocol ViewState: AnyObject {
    func viewDidLoad()
}

extension ViewState {
    func viewDidLoad() {}
}
