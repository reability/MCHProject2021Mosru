//
//  CommonEntityProtocol.swift
//  MCHProject
//
//  Created by Савченко Максим Олегович on 12.06.2021.
//

import Foundation
import UIKit

// MARK: - Common Entity for size and model

protocol CommonEntity {
    var identifier: String { get }
    var size: CGSize { get }
}
