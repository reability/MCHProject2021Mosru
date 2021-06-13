//
//  ChooseEvent.swift
//  MSKCityHack
//
//  Created by Савченко Максим Олегович on 13.06.2021.
//

import UIKit
import Koloda
import SnapKit
    
final class ChooseEventViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        $0.font = UIFont(name: "Roboto-Bold", size: 24)
        $0.text = "Какие события интересны?"
        return $0
    }(UILabel())
    
    private lazy var descriptionLabel: UILabel = {
        $0.text = "Чтобы сформировать совместную подборку событий, сыграйте с нами в простую игру. Мы показываем событие, а вы решаете - интересно оно или нет"
        $0.font = UIFont(name: "Roboto-Regular", size: 14)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = #colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
        return $0
    }(UILabel())
    
    private lazy var textCounterLabel: UILabel = {
        $0.font = UIFont(name: "Roboto-Regular", size: 12)
        $0.textColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)
        $0.text = "0 из 10"
        return $0
    }(UILabel())
    
    private lazy var kolodaViews: KolodaView = {
        $0.delegate = self
        $0.dataSource = self
        return $0
    }(KolodaView())
    
    var arrayOfCards: [CardView] = []
    let model: [Afisha]
    
    init(model: [Afisha]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.model = []
        super.init(coder: coder)
    }
    
    var arrayOfGenre = ["КОНЦЕРТ", "МУЗЕИ", "КУЛЬТУРНАЯ СТОЛИЦА"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<model.count - 10 {
            let element = model[i]
            let cardView = CardView(image: element.img,
                                genre: arrayOfGenre.randomElement() ?? "",
                                name: element.title,
                                description: element.text)
            cardView.delegate = self
            arrayOfCards.append(cardView)
        }
        
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        makeLayout()
        kolodaViews.reloadData()
    }
    
    private func makeLayout() {
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(textCounterLabel)
        view.addSubview(kolodaViews)
        
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(view.snp.top).offset(60)
            maker.centerX.equalTo(view.snp.centerX)
        }
        
        descriptionLabel.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom).offset(8)
            maker.leading.equalTo(view.snp.leading).offset(18)
            maker.trailing.equalTo(view.snp.trailing).inset(18)
            maker.width.equalTo(64)
        }
        
        textCounterLabel.snp.makeConstraints { maker in
            maker.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            maker.centerX.equalTo(view.snp.centerX)
        }
        
        kolodaViews.snp.makeConstraints { maker in
            maker.top.equalTo(textCounterLabel.snp.bottom).offset(20)
            maker.leading.equalToSuperview().offset(24)
            maker.trailing.equalToSuperview().inset(24)
            maker.height.equalTo(500)
        }
        
    }
    
}

extension ChooseEventViewController: KolodaViewDelegate, KolodaViewDataSource, CardViewTapDelegate {
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return arrayOfCards[index]
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return arrayOfCards.count
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        FeedViewController.id = 3
        self.dismiss(animated: true, completion: nil)
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        textCounterLabel.text = "\(koloda.currentCardIndex) из 10"
    }
    
    func didTapLike() {
        kolodaViews.swipe(.right)
    }
    
    func didTapDislike() {
        kolodaViews.swipe(.left)
    }
}
