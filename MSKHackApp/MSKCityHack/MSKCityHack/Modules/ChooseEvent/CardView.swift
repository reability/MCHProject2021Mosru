//
//  CardView.swift
//  MSKCityHack
//
//  Created by Савченко Максим Олегович on 13.06.2021.
//

import UIKit
import SnapKit
import Kingfisher

protocol CardViewTapDelegate: AnyObject {
    func didTapLike()
    func didTapDislike()
}

class CardView: UIView {
    
    weak var delegate: CardViewTapDelegate?
    
    private lazy var cardImageView: UIImageView = {
        $0.image = #imageLiteral(resourceName: "Rectangle 30")
        $0.contentMode = .scaleAspectFill
        
        return $0
    }(UIImageView())
    
    private lazy var genreLabel: UILabel = {
        $0.text = "Концерт, джаз, музыка"
        $0.font = UIFont(name: "Roboto-Regular", size: 16)
        $0.textAlignment = .center
        $0.textColor = #colorLiteral(red: 0.3529411765, green: 0.3529411765, blue: 0.3529411765, alpha: 1)
        return $0
    }(UILabel())
    
    private lazy var nameLabel: UILabel = {
        $0.font = UIFont(name: "Roboto-Medium", size: 24)
        $0.textAlignment = .center
        $0.text = "Выпуск избранных концертов 2020 годов"
        $0.numberOfLines = 3
        return $0
    }(UILabel())
    
    private lazy var descriptionCardLabel: UILabel = {
        $0.text = """
Московский международный дом музыки Космодамианская набережная, дом 52, строение 8
"""
        $0.font = UIFont(name: "Roboto-Regular", size: 14)
        $0.textAlignment = .center
        $0.numberOfLines = 3
        $0.textColor = #colorLiteral(red: 0.3529411765, green: 0.3529411765, blue: 0.3529411765, alpha: 1)
        
        return $0
    }(UILabel())
    
    private lazy var likeCardButton: UIButton = {
        $0.setImage(#imageLiteral(resourceName: "icons-3"), for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.8795312047, green: 0.8953673244, blue: 0.9784886241, alpha: 1)
        $0.layer.cornerRadius = 28
        $0.imageView?.image = $0.imageView?.image?.withRenderingMode(.alwaysTemplate)
        $0.imageView?.tintColor = #colorLiteral(red: 0, green: 0.3823694587, blue: 0.8253552318, alpha: 1)
        $0.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var dislikeCardButton: UIButton = {
        $0.setImage(#imageLiteral(resourceName: "Group-3"), for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.8795312047, green: 0.8953673244, blue: 0.9784886241, alpha: 1)
        $0.layer.cornerRadius = 28
        $0.imageView?.tintColor = #colorLiteral(red: 0, green: 0.3823694587, blue: 0.8253552318, alpha: 1)
        $0.addTarget(self, action: #selector(didTapDislike), for: .touchUpInside)
        return $0
    }(UIButton())
    
    init(image: String, genre: String, name: String, description: String) {
        super.init(frame: .zero)
        
        if let url = URL(string: image) {
            cardImageView.kf.setImage(with: url)
            cardImageView.superview?.layoutIfNeeded()
        }
        
        genreLabel.text = genre
        descriptionCardLabel.text = description
        
        makeLayout()
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardImageView.roundCorners(corners: [.topLeft, .topRight], radius: 16)
        cardImageView.clipsToBounds = true
    }
    
    private func makeLayout() {
        
        self.addSubview(cardImageView)
        self.addSubview(genreLabel)
        self.addSubview(nameLabel)
        self.addSubview(descriptionCardLabel)
        self.addSubview(likeCardButton)
        self.addSubview(dislikeCardButton)
        
        cardImageView.snp.makeConstraints { maker in
            maker.top.equalTo(self.snp.top)
            maker.leading.equalTo(self.snp.leading)
            maker.trailing.equalTo(self.snp.trailing)
            maker.height.equalTo(246)
        }
        
        genreLabel.snp.makeConstraints { maker in
            maker.top.equalTo(cardImageView.snp.bottom).offset(16)
            maker.leading.equalTo(self.snp.leading).offset(12)
            maker.trailing.equalTo(self.snp.trailing).inset(12)
        }
        
        nameLabel.snp.makeConstraints { maker in
            maker.top.equalTo(genreLabel.snp.bottom).offset(12)
            maker.leading.equalTo(self.snp.leading).offset(12)
            maker.trailing.equalTo(self.snp.trailing).inset(12)
        }
        
        descriptionCardLabel.snp.makeConstraints { maker in
            maker.top.equalTo(nameLabel.snp.bottom).offset(12)
            maker.leading.equalTo(self.snp.leading).offset(12)
            maker.trailing.equalTo(self.snp.trailing).inset(12)
        }
        
        likeCardButton.snp.makeConstraints { maker in
            maker.top.equalTo(descriptionCardLabel.snp.bottom).offset(16)
            maker.height.width.equalTo(56)
            maker.centerX.equalTo(self.snp.centerX).offset(48)
        }
        
        dislikeCardButton.snp.makeConstraints { maker in
            maker.top.equalTo(descriptionCardLabel.snp.bottom).offset(16)
            maker.height.width.equalTo(56)
            maker.centerX.equalTo(self.snp.centerX).offset(-48)
        }
        
    }
    
    private func configView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightText.cgColor
    }
    
    @objc func didTapLike() {
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) {
            self.likeCardButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        } completion: { ended in
            if ended {
                self.likeCardButton.transform = .identity
            }
        }

        delegate?.didTapLike()
    }
    
    @objc func didTapDislike() {
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) {
            self.dislikeCardButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        } completion: { ended in
            if ended {
                self.dislikeCardButton.transform = .identity
            }
        }
        
        delegate?.didTapDislike()
    }
    
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
