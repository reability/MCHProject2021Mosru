//
//  OnBoardingViewController.swift
//  MSKCityHack
//
//  Created by Ванурин Алексей Максимович on 12.06.2021.
//

import UIKit
import SnapKit

final class OnBoardingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var presenter = OnBoardPresenter()
    
    var ready: Bool = false
    
    var model: [Afisha]! {
        didSet {
            arrData = model.map { $0.id }
            collectionView.reloadData() }
    }
    
    var arrData = [Int]() // This is your data array
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    var arrSelectedData = [Int]() // This is selected cell data array
    
    private lazy var header: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    private lazy var titleLabel: UILabel = {
        $0.font = UIFont(name: "Roboto-Bold", size: 24.0)
        $0.textAlignment = .center
        $0.text = "Выберите то, что вам интересно: 3 или более"
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var hintLabel: UILabel = {
        $0.font = UIFont(name: "Roboto", size: 14.0)
        $0.textAlignment = .center
        $0.text = "Чтобы сформировать подборку специально для вас, нам нужно узнать ваши предпочтения"
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var completeButton: UIButton = {
        $0.setTitle("Готово", for: .normal)
        $0.backgroundColor = .gray
        $0.isEnabled = false
        $0.layer.cornerRadius = 10.0
        $0.titleLabel?.textColor = .white
        
        return $0
    }(UIButton())
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        let totalWidth = view.bounds.width
        let hInset: CGFloat = 10.0
        let spacing: CGFloat = 5.0
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: CGFloat(totalWidth/2) - 2.0 * hInset - spacing, height: 240.0)
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: hInset, bottom: 0.0, right: hInset)
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        makelayout()
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        //collectionView.backgroundColor = UIColor(red: 229.0/255.0, green: 229.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        
        completeButton.addTarget(self, action: #selector(complete), for: .touchUpInside)
        
        collectionView.register(OnBoardingCollectionViewCell.self, forCellWithReuseIdentifier: "1")
        presenter.view = self
        presenter.fetch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //
    }
    
    @objc func complete() {
        if arrSelectedData.count > 2 {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if model != nil {
            if model.count > 8 {
                return 8
            } else {
                return model.count
            }
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "1", for: indexPath) as! OnBoardingCollectionViewCell
        let m = model[indexPath.row]
        cell.setup(title: m.title, photo: m.img, free: m.free, location: m.locationText, subtitle: m.subtitle)
        
        cell.setSelected(value: arrSelectedIndex.contains(indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let strData = arrData[indexPath.item]

        if arrSelectedIndex.contains(indexPath) {
            arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
            arrSelectedData = arrSelectedData.filter { $0 != strData}
        }
        else {
            arrSelectedIndex.append(indexPath)
            arrSelectedData.append(strData)
        }
        
        if arrSelectedData.count > 2 {
            completeButton.isEnabled = true
            completeButton.backgroundColor = .blue
        } else {
            completeButton.isEnabled = false
            completeButton.backgroundColor = .gray
        }
        
        collectionView.reloadData()
    }
    
    func makelayout() {
        view.addSubview(header)
        header.snp.makeConstraints { maker in
            maker.leading.top.trailing.equalTo(view.safeAreaInsets)
            maker.height.equalTo(170)
            //maker.top.equalTo(navigationController!.view.snp.bottom)
        }
        
        header.addSubview(titleLabel)
        header.addSubview(hintLabel)
        
        titleLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(8.0)
            maker.trailing.equalToSuperview().offset(-8.0)
            maker.top.equalToSuperview().offset(56.0)
        }
        
        hintLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(8.0)
            maker.trailing.equalToSuperview().offset(-8.0)
            maker.top.equalTo(titleLabel.snp.bottom).offset(8.0)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalToSuperview()
            //maker.top.equalToSuperview()
            maker.top.equalTo(header.snp.bottom)
        }
        
        view.addSubview(completeButton)
        completeButton.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().offset(-26.0)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(250.0)
            maker.height.equalTo(45.0)
        }
    }

    
}
