//
//  CommonDataSource.swift
//  MCHProject
//
//  Created by Савченко Максим Олегович on 12.06.2021.
//

import UIKit

typealias CollectionProtocols = UICollectionViewDelegate
    & UICollectionViewDataSource
    & UICollectionViewDelegateFlowLayout


protocol DataSource: AnyObject {
    associatedtype Model
    func update(_ model: [Model])
    var model: [Model] { get set }
}
