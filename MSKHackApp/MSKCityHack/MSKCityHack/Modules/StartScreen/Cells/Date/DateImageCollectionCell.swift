//
//  DateImageCollectionCell.swift
//  MCHProject
//
//  Created by Савченко Максим Олегович on 12.06.2021.
//

import UIKit

protocol DateImageTapDelegate: AnyObject {
    func didImageTapEvent()
}

final class DateImageCollectionCell: UICollectionViewCell {
    
    @IBOutlet private weak var iconImageView: UIImageView!
    weak var delegate: DateImageTapDelegate?
}

extension DateImageCollectionCell: Setupable {
    
    func setup(_ object: Any) {
        guard let model = object as? DateImageEntity else { fatalError("Model cannot be created") }
        
//        nameLabel.text = model.title
    }
    
}

struct DateImageEntity: CommonEntity {
    let image: UIImage
    let type: DateTypeCells
    let isSelected: Bool
    
    var size: CGSize { .zero }
    var identifier: String { type.rawValue }
}
