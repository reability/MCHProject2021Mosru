//
//  DateWelcomeDataSource.swift
//  MCHProject
//
//  Created by Савченко Максим Олегович on 12.06.2021.
//


import UIKit

protocol DateDataSource: DataSource {}

protocol DateTapDelegate: AnyObject {
    func tapToImage()
    func reloadData()
}

final class DateDataSourceImp: NSObject, DateDataSource {
    
    typealias Model = CommonEntity
    
    var model: [CommonEntity] = []
    
    weak var tapDelegate: DateTapDelegate?
    
    func update(_ model: [CommonEntity]) {
        self.model = model
    }

}

extension DateDataSourceImp: CollectionProtocols {
    
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
        case DateTitleCollectionCell.identifier:
            
            let width = (row as! DateTitleEntity)
                .title
                .width(withConstrainedHeight: 38,
                       font: UIFont(name: "Roboto-Regular",
                                    size: 16)!)
            
            return CGSize(width: width + 30,
                                   height: 38)
            
        case DateImageCollectionCell.identifier:
            return CGSize(width: 38, height: 38)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var row = model[indexPath.row]
        
        switch row.identifier {
        case DateTitleCollectionCell.identifier:
            
            if (row as! DateTitleEntity).isSelected == false {
                (row as! DateTitleEntity).isSelected = true
            } else {
                (row as! DateTitleEntity).isSelected = false
            }
            
            tapDelegate?.reloadData()
        case DateImageCollectionCell.identifier:
            tapDelegate?.tapToImage()
        default:
            break
        }
    }
    
}

// MARK: - Actions

extension DateDataSourceImp: DateTitleTapDelegate, EventImageTapDelegate {
    
    func didImageTapEvent() {
        print("did tap image")
    }
    
    func didTitleTapEvent() {
        print("did tap title")
    }
}

