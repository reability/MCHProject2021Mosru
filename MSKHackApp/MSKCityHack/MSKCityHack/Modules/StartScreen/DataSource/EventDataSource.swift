//
//  EventDataSource.swift
//  MCHProject
//
//  Created by Савченко Максим Олегович on 12.06.2021.
//

import UIKit

protocol EventDataSource: DataSource {}

protocol EventTapDelegate: AnyObject {
    func tapToImage()
    func reloadData()
}

final class EventDataSourceImp: NSObject, EventDataSource {
    
    typealias Model = CommonEntity
    
    var model: [CommonEntity] = []
    
    weak var tapDelegate: EventTapDelegate?
    
    func update(_ model: [CommonEntity]) {
        self.model = model
    }

}

extension EventDataSourceImp: CollectionProtocols {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let row = model[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.identifier, for: indexPath)
        
        (cell as? Setupable)?.setup(row)
        (cell as? Delegatable)?.delegate = self
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let row = model[indexPath.row]
        
        switch row.identifier {
        case EventTitleCollectionCell.identifier:
            
            let width = (row as! EventTitleEntity)
                .title
                .width(withConstrainedHeight: 38,
                       font: UIFont(name: "Roboto-Regular",
                                    size: 16)!)
            
            return CGSize(width: width + 30,
                                   height: 38)
            
        case EventImageCollectionCell.identifier:
            return CGSize(width: 38, height: 38)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = model[indexPath.row]
        
        switch row.identifier {
        case EventTitleCollectionCell.identifier:
            
            if (row as! EventTitleEntity).isSelected == false {
                (row as! EventTitleEntity).isSelected = true
            } else {
                (row as! EventTitleEntity).isSelected = false
            }
            
            tapDelegate?.reloadData()
        case EventImageCollectionCell.identifier:
            tapDelegate?.tapToImage()
        default:
            break
        }
    }
    
}

// MARK: - Actions

extension EventDataSourceImp: EventTitleTapDelegate, EventImageTapDelegate {
    
    func didImageTapEvent() {
        print("did tap image")
    }
    
    func didTitleTapEvent() {
        print("did tap title")
    }
}

