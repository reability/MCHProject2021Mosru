//
//  OnBoardingCollectionCell.swift
//  MSKCityHack
//
//  Created by Ванурин Алексей Максимович on 12.06.2021.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

let titles = ["П Р О Г У Л К И", "Т Е А Т Р  Д Л Я  В С Е Х", "И С Т О Р И Я  М О С К В Ы", "К У Л Ь Т У Р Н А Я  С Т О Л И Ц А", "М У З Е И", ""]
let locations = ["Рядом с вами", "В 500 метрах", "", "", "", "", ""]

final class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    private var photoHeight: Constraint!
    
    private lazy var holderView: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    private lazy var photoView: UIImageView = {
        return $0
    }(UIImageView())
    
    private lazy var catrgorytitleView: UILabel = {
        $0.numberOfLines = 0
        $0.text = ""
        $0.textColor = .gray
        $0.font = UIFont(name: "Roboto-Light", size: 10.0)
        return $0
    }(UILabel())
    
    
    private lazy var titleView: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont(name: "Roboto", size: 14.0)
        return $0
    }(UILabel())
    
    private lazy var freeTitleView: UILabel = {
        $0.numberOfLines = 0
        $0.text = "Бесплатно"
        $0.font = UIFont(name: "Roboto", size: 12.0)
        return $0
    }(UILabel())
    
    private lazy var chechImageView: UIImageView = {
        $0.image = #imageLiteral(resourceName: "indus")
        return $0
    }(UIImageView())
    
    private lazy var locationBubble: UIView = {
        $0.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        $0.layer.cornerRadius = 4.0
        return $0
    }(UIView())
    
    private lazy var locationtile: UILabel = {
        $0.numberOfLines = 0
        $0.text = ""
        $0.font = UIFont(name: "Roboto", size: 12.0)
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func commonInit() {
        holderView.layer.cornerRadius = 12.0
        
        photoView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        photoView.layer.cornerRadius = 12.0
        photoView.clipsToBounds = true
        
        holderView.layer.borderColor = UIColor.clear.cgColor
        holderView.layer.masksToBounds = true

        holderView.layer.shadowColor = UIColor.black.cgColor
        holderView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        holderView.layer.shadowRadius = 0.5
        holderView.layer.shadowOpacity = 0.1
        holderView.layer.masksToBounds = false
        //holderView.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.holderView.layer.cornerRadius).cgPath
        
        
        contentView.addSubview(holderView)
        holderView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(UIEdgeInsets(top: 4.0, left: 4.0, bottom: 1.0, right: 1.0))
        }
        
        holderView.addSubview(photoView)
        photoView.snp.makeConstraints { maker in
            maker.leading.trailing.top.equalToSuperview()
            self.photoHeight = maker.height.equalTo(140.0).constraint
        }
        
        photoView.addSubview(locationBubble)
        locationBubble.addSubview(locationtile)
        
        locationBubble.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().offset(-5)
            maker.bottom.equalToSuperview().offset(-3.0)
            maker.height.equalTo(30.0)
            maker.width.equalTo(90.0)
        }
        
        locationtile.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
        
        contentView.addSubview(chechImageView)
        
        holderView.addSubview(titleView)
        holderView.addSubview(catrgorytitleView)
        holderView.addSubview(freeTitleView)
        
        catrgorytitleView.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview()
            maker.leading.equalToSuperview().offset(12.0)
            maker.top.equalTo(photoView.snp.bottom).offset(3.0)
        }
        
        titleView.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview()
            maker.leading.equalToSuperview().offset(12.0)
            maker.top.equalTo(catrgorytitleView.snp.bottom)
        }
        
        freeTitleView.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview()
            maker.leading.equalToSuperview().offset(12.0)
            maker.bottom.equalToSuperview().offset(-8.0)
        }
        
        contentView.addSubview(chechImageView)
        chechImageView.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
        chechImageView.isHidden = true
    }
    
    
    func setup(title: String, photo: String, free: Bool, redraw: Bool=true, location: String?, subtitle: String?) {
        titleView.text = title
        
        freeTitleView.isHidden = !free
        
        if let subtext = subtitle {
            catrgorytitleView.text = subtext
        } else {
            catrgorytitleView.text = titles.randomElement()!
        }
        
        if photo == "brain" {
            catrgorytitleView.text = "Рекомендации"
            freeTitleView.text = "Жми"
            freeTitleView.isHidden = false
            locationBubble.isHidden = true
            photoView.backgroundColor = .blue
            photoView.image = #imageLiteral(resourceName: "brain")
            photoView.contentMode = .center
        } else {
            if let url = URL(string: photo) {
                photoView.kf.setImage(with: url)
            }
            if let locationText = location {
                if locationText != "" {
                    locationtile.text = locationText
                    locationBubble.isHidden = false
                } else {
                    locationBubble.isHidden = true
                }
            } else {
                let t = locations.randomElement()!
                if t != "" {
                    locationtile.text = t
                    locationBubble.isHidden = false
                } else {
                    locationBubble.isHidden = true
                }
            }
        }
    }
    
    func shrink() {
        photoHeight.layoutConstraints.first!.constant = 120.0
    }
    
    func setSelected(value: Bool) {
        chechImageView.isHidden = !value
    }
    
}
