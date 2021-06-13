//
//  EventImageCollectionCell.swift
//  MCHProject
//
//  Created by Савченко Максим Олегович on 12.06.2021.
//

import UIKit

protocol EventImageTapDelegate: AnyObject {
    func didImageTapEvent()
}

final class EventImageCollectionCell: UICollectionViewCell {
    
    weak var delegate: EventImageTapDelegate?
    @IBOutlet private weak var iconImageView: UIImageView!
}

extension EventImageCollectionCell: Setupable {
    
    func setup(_ object: Any) {
        guard let model = object as? EventImageEntity else { fatalError("Model cannot be created") }
        
        
    }
    
}

struct EventImageEntity: CommonEntity {
  
    let image: UIImage
    let type: EventTypeCells
    let isSelected: Bool
    
    var size: CGSize { .zero }
    var identifier: String { type.rawValue }
}
