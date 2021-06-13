//
//  DateCollectionViewCell.swift
//  MCHProject
//
//  Created by Савченко Максим Олегович on 12.06.2021.
//

import UIKit

enum DateTypeCells: String {
    case title = "DateTitleCollectionCell"
    case image = "DateImageCollectionCell"
}

protocol DateTitleTapDelegate: AnyObject {
    func didTitleTapEvent()
}

final class DateTitleCollectionCell: UICollectionViewCell {
    
    weak var delegate: DateTitleTapDelegate?
    @IBOutlet private weak var nameLabel: UILabel!
    
}

extension DateTitleCollectionCell: Setupable {
    
    func setup(_ object: Any) {
        guard let model = object as? DateTitleEntity else { fatalError("Model cannot be created") }
        
        nameLabel.text = model.title
        
        if model.isSelected == true {
            self.contentView.backgroundColor = #colorLiteral(red: 0, green: 0.3823694587, blue: 0.8253552318, alpha: 1)
            self.nameLabel.textColor = .white
        } else {
            self.contentView.backgroundColor = #colorLiteral(red: 0.9466845393, green: 0.9542574286, blue: 0.9908118844, alpha: 1)
            self.nameLabel.textColor = #colorLiteral(red: 0, green: 0.3823694587, blue: 0.8253552318, alpha: 1)
        }
    }
    
}

class DateTitleEntity: CommonEntity {
    var title: String = ""
    var type: DateTypeCells = .title
    var isSelected: Bool = false
    
    init(title: String, type: DateTypeCells, isSelected: Bool) {
        self.title = title
        self.type = type
        self.isSelected = isSelected
    }
    
    var size: CGSize { .zero }
    var identifier: String { type.rawValue }
}
