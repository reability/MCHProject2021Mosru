//
//  EventCollectionViewCell.swift
//  MCHProject
//
//  Created by Савченко Максим Олегович on 12.06.2021.
//

import UIKit

enum EventTypeCells: String {
    case title = "EventTitleCollectionCell"
    case image = "EventImageCollectionCell"
}

protocol EventTitleTapDelegate: AnyObject {
    func didTitleTapEvent()
}

final class EventTitleCollectionCell: UICollectionViewCell {
    
    weak var delegate: EventTitleTapDelegate?
    @IBOutlet private weak var nameLabel: UILabel!
    
}

extension EventTitleCollectionCell: Setupable {
    
    func setup(_ object: Any) {
        guard let model = object as? EventTitleEntity else { fatalError("Model cannot be created") }
        
        nameLabel.text = model.title
    }
    
}

class EventTitleEntity: CommonEntity {
    var title: String = ""
    var type: EventTypeCells = .title
    var isSelected: Bool = false
    
    init(title: String, type: EventTypeCells, isSelected: Bool) {
        self.title = title
        self.type = type
        self.isSelected = isSelected
    }
    
    var size: CGSize { .zero }
    var identifier: String { type.rawValue }
}
