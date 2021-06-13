
//
//  OnBoardingViewController.swift
//  MSKCityHack
//
//  Created by Ванурин Алексей Максимович on 12.06.2021.
//

import UIKit
import SnapKit

final class FeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    var presenter = FeedPresenter()
    
    static var id: Int?
    
    var model: [Afisha]! { didSet { collectionView.reloadData() } }
    
    private let pannableView: UIView = {
        
            let view = UIView(frame: CGRect(origin: .zero,
                                            size: CGSize(width: 200.0, height: 200.0)))

            view.backgroundColor = .white
            view.layer.cornerRadius = 16

            return view
        }()
    
    var timeHeightConstraint: Constraint?
    
    private let pannableHeaderView: UIView = {
        
            let view = UIView(frame: CGRect(origin: .zero,
                                            size: CGSize(width: 200.0, height: 200.0)))

            view.backgroundColor = .blue

            return view
    }()
    
    private let titleLabel: UILabel = {
        
        $0.text = "Cовместная сессия"
        $0.font = UIFont(name: "Roboto-Bold", size: 24)

        return $0

    }(UILabel())
    
    private let descriptionLabel: UILabel = {
        
        $0.text = "Чтобы присоединиться к совместной сессии, обменяйтесь кодами-приглашениями с другом. Отправьте код другу:"
        $0.numberOfLines = 0
        $0.font = UIFont(name: "Roboto-Regular", size: 14)
        $0.textColor = #colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
        $0.textAlignment = .center
        
        return $0

    }(UILabel())
    
    private let codeLabel: UILabel = {
        
        $0.text = "dgLf43Eq"
        $0.font = UIFont(name: "Roboto-Bold", size: 24)

        return $0

    }(UILabel())
    
    private let hintLabel: UILabel = {
        
        $0.text = "Или введите код, полученный от друга"
        $0.numberOfLines = 1
        $0.font = UIFont(name: "Roboto-Regular", size: 14)
        $0.textColor = #colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
        
        return $0

    }(UILabel())
    
    private let enterCodeTextEdit: UITextField = {
        
        $0.placeholder = "Введите код-приглашение"
        $0.borderStyle = .roundedRect
        $0.font = UIFont(name: "Roboto-Regular", size: 14)
        $0.textColor = #colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
        $0.backgroundColor = #colorLiteral(red: 0.9466845393, green: 0.9542574286, blue: 0.9908118844, alpha: 1)
        
        return $0
        
    }(UITextField())
    
    private let startButton: UIButton = {
        
        $0.setTitle("Найти", for: .normal)
        $0.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)!
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0, green: 0.3823694587, blue: 0.8253552318, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        
        return $0

    }(UIButton())
    
    private lazy var header: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    private lazy var backgroundBlackScreen: UIView = {
        
        $0.backgroundColor = .black
        $0.alpha = 0
        
        return $0
    }(UIView())
    
    private lazy var headerTileLabel: UILabel = {
        $0.font = UIFont(name: "Roboto-Bold", size: 16)!
        $0.textAlignment = .center
        $0.text = "Привет!\nМы сделали для тебя подборку интересных событий на завтра"
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private var currentHeight: CGFloat = 399
    private var initialCenter: CGPoint = .zero
    
    private var isOpen: Bool = false
    
    private lazy var linkButton: UIButton = {
        //$0.setTitle("Найти", for: .normal)
        $0.setImage(#imageLiteral(resourceName: "hands"), for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(tapToLinkButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        let totalWidth = view.bounds.width
        let hInset: CGFloat = 10.0
        let spacing: CGFloat = 5.0
        
        navigationItem.title = "Лента"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = nil
        
        let layout = UICollectionViewFlowLayout()
        
        //let calculatedHeight: CGFloat =
        
        layout.itemSize = CGSize(width: CGFloat(totalWidth/2) - 2.0 * hInset - spacing, height: 240.0)
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: hInset, bottom: 0.0, right: hInset)
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        makelayout()
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        collectionView.register(OnBoardingCollectionViewCell.self, forCellWithReuseIdentifier: "1")
        presenter.view = self
        
        //presenter.fetch()
        presenter.connectAndSendSocket()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        pannableView.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if FeedViewController.id != nil {
            var n = model
            n!.shuffle()
            let h = n![0]
            
            let vc = AfishaCardViewController(eventId: h.id)
            present(vc, animated: true, completion: nil)
        } else {
            presenter.fetch()
        }
    }

    @objc func startButtonAction() {
        
        let chooseVC = ChooseEventViewController(model: model)
        chooseVC.modalPresentationStyle = .fullScreen
        self.showOrClosePanView()
        
        self.navigationController?.present(chooseVC, animated: true, completion: {
        })
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let firstTouchView = touches.first?.view
        
        if firstTouchView == backgroundBlackScreen {
            
            UIView.animate(withDuration: 0.2) {
                self.backgroundBlackScreen.alpha = 0
            } completion: { ended in
                if ended {
                    UIView.animate(withDuration: 0.3) {
                        self.pannableView.snp.updateConstraints { maker in
                            maker.height.equalTo(0)
                        }
                        self.pannableView.superview?.layoutIfNeeded()
                    }
                    self.isOpen = false
                }
            }

            
        }
        
        enterCodeTextEdit.endEditing(true)
    }
    
    @objc private func didPan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
            case .began:
                initialCenter = pannableView.center
            case .changed:
                let translation = sender.translation(in: view)
                
                let positiveHeight = currentHeight + (translation.y * -1)
                
                self.pannableView.snp.updateConstraints { maker in
                    maker.height.equalTo(round(positiveHeight))
                }
                

            case .ended,
                 .cancelled:
                
                findNearestPoint(pannableView.bounds.height)
                
            default:
                break
            }
    }
    
    func findNearestPoint(_ translation: CGFloat) {
        
        let topPoint = UIScreen.main.bounds.height - 60
        let middlePoint: CGFloat = 399
        let startPoint = 0
        
        let differenceTop = topPoint - translation
        let differenceMiddle = translation - middlePoint
//        let diffenceStartPoint = translation - startPoint
        
        print("Top", differenceTop)
        print("Middle", differenceMiddle)
        print("result", differenceTop > differenceMiddle)
        
        if differenceTop < differenceMiddle {
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) {
                            self.pannableView.snp.updateConstraints { maker in
                                maker.height.equalTo(topPoint)
                            }
                            
                            self.currentHeight = topPoint
                            self.pannableView.superview?.layoutIfNeeded()
                        }
        } else if translation >= middlePoint / 2 {
            
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) {
                            self.pannableView.snp.updateConstraints { maker in
                                maker.height.equalTo(middlePoint)
                            }
                
                            self.currentHeight = middlePoint
                            self.pannableView.superview?.layoutIfNeeded()
                        }
            
            
        } else if translation < middlePoint / 2 {
            
            UIView.animate(withDuration: 0.2) {
                            self.backgroundBlackScreen.alpha = 0
                        } completion: { ended in
                            if ended {
                                UIView.animate(withDuration: 0.3) {
                                    self.pannableView.snp.updateConstraints { maker in
                                        maker.height.equalTo(0)
                                    }
                                    self.currentHeight = middlePoint
                                    self.pannableView.superview?.layoutIfNeeded()
                                }
                                self.isOpen = false
                            }
                        }
            
        }
        
//        if middlePoint > startPoint {
//
//            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) {
//                self.pannableView.snp.updateConstraints { maker in
//                    maker.height.equalTo(middlePoint)
//                }
//                self.pannableView.superview?.layoutIfNeeded()
//            }
//
//        } else if translation <= 0 {
//
//            UIView.animate(withDuration: 0.2) {
//                self.backgroundBlackScreen.alpha = 0
//            } completion: { ended in
//                if ended {
//                    UIView.animate(withDuration: 0.3) {
//                        self.pannableView.snp.updateConstraints { maker in
//                            maker.height.equalTo(0)
//                        }
//                        self.pannableView.superview?.layoutIfNeeded()
//                    }
//                    self.isOpen = false
//                }
//            }
//
//        } else {
//
//            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) {
//                self.pannableView.snp.updateConstraints { maker in
//                    maker.height.equalTo(startPoint)
//                }
//                self.pannableView.superview?.layoutIfNeeded()
//            }
//
//        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if model != nil {
            return model.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "1", for: indexPath) as! OnBoardingCollectionViewCell
        let m = model[indexPath.row]
        let reminder = indexPath.row % 4
        cell.setup(title: m.title, photo: m.img, free: m.free, location: m.locationText, subtitle: m.subtitle)
        
        if (reminder == 0 || reminder == 3) {
            cell.shrink()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let m = model[indexPath.row]
        
        if m.id == -1 {
            openOnBoarding()
        } else {
            let vc = AfishaCardViewController(eventId: m.id)
            present(vc, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = view.bounds.width
        let hInset: CGFloat = 5.0
        let spacing: CGFloat = 5.0
        
        let reminder = indexPath.row % 4
        let height: CGFloat = (reminder == 0 || reminder == 3) ? 270 : 240
        
        //let calculatedHeight: CGFloat =
        return CGSize(width: CGFloat(totalWidth/2) - 2.0 * hInset - spacing, height: height)
    }
    
    //func size
    //func collectis
    
    func makelayout() {
        view.addSubview(header)
        pannableView.center = view.center
        
        header.snp.makeConstraints { maker in
            maker.leading.trailing.top.equalTo(view.safeAreaInsets)
            maker.height.equalTo(200.0)
        }
        
        header.addSubview(headerTileLabel)
        headerTileLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(20.0)
            maker.trailing.equalToSuperview().offset(-5.0)
            maker.top.equalToSuperview().offset(100.0)
        }
        header.addSubview(linkButton)
        linkButton.snp.makeConstraints { maker in
            maker.trailing.equalTo(header.snp.trailing).offset(-30)
            maker.bottom.equalToSuperview()
        }
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalToSuperview()
            maker.top.equalTo(header.snp.bottom)
        }
        
        view.addSubview(backgroundBlackScreen)
        view.addSubview(pannableView)
        
        view.bringSubviewToFront(pannableView)
        
        backgroundBlackScreen.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        pannableView.snp.makeConstraints { maker in
            maker.bottom.leading.trailing.equalToSuperview()
            maker.height.equalTo(0)
        }
        
        isOpen = false
        
        makeLayoutForPannapbleView()
    }
    
    func makeLayoutForPannapbleView() {
        
        pannableView.addSubview(titleLabel)
        pannableView.addSubview(descriptionLabel)
        pannableView.addSubview(codeLabel)
        pannableView.addSubview(hintLabel)
        pannableView.addSubview(enterCodeTextEdit)
        pannableView.addSubview(startButton)
        
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(pannableView.snp.top).offset(24)
            maker.centerX.equalTo(pannableView.snp.centerX)
        }
        
        descriptionLabel.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom).offset(8)
            maker.leading.equalTo(pannableView.snp.leading).offset(18)
            maker.trailing.equalTo(pannableView.snp.trailing).inset(18)
            maker.height.equalTo(50)
        }
        
        codeLabel.snp.makeConstraints { maker in
            maker.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            maker.centerX.equalTo(pannableView.snp.centerX)
        }
        
        hintLabel.snp.makeConstraints { maker in
            maker.top.equalTo(codeLabel.snp.bottom).offset(32)
            maker.centerX.equalTo(pannableView.snp.centerX)
        }
        
        enterCodeTextEdit.snp.makeConstraints { maker in
            maker.top.equalTo(hintLabel.snp.bottom).offset(16)
            maker.leading.equalTo(pannableView.snp.leading).offset(18)
            maker.trailing.equalTo(pannableView.snp.trailing).inset(18)
            maker.height.equalTo(47)
        }
        
        startButton.snp.makeConstraints { maker in
            maker.top.equalTo(enterCodeTextEdit.snp.bottom).offset(24)
            maker.leading.equalTo(pannableView.snp.leading).offset(18)
            maker.trailing.equalTo(pannableView.snp.trailing).inset(18)
            maker.height.equalTo(48)
        }
        
        codeLabel.text = randomNameString(length: 8)
        
    }
    
    @objc func tapToLinkButton() {
        
        UIView.animate(withDuration: 0.2) {
            self.backgroundBlackScreen.alpha = 0.5
        } completion: { ended in
            if ended {
                self.showOrClosePanView()
            }
        }
        
//        let chooseEventVC = ChooseEventViewController()
//
//        self.present(chooseEventVC, animated: true, completion: nil)
    }
    
    
    private func showOrClosePanView() {
        
        if isOpen == false {
        
        UIView.animate(withDuration: 0.3) {
            self.pannableView.snp.updateConstraints { maker in
                maker.height.equalTo(399)
            }
            self.pannableView.superview?.layoutIfNeeded()
        }
            
        isOpen = true
            
        } else {
            
            UIView.animate(withDuration: 0.3) {
                self.pannableView.snp.updateConstraints { maker in
                    maker.height.equalTo(0)
                }
                self.pannableView.superview?.layoutIfNeeded()
            }
            isOpen = false
        }
        
    }
    
    func randomNameString(length: Int = 7)->String{
        
        enum s {
            static let c = Array("abcdefghjklmnpqrstuvwxyz12345789")
            static let k = UInt32(c.count)
        }
        
        var result = [Character](repeating: "-", count: length)
        
        for i in 0..<length {
            let r = Int(arc4random_uniform(s.k))
            result[i] = s.c[r]
        }
        
        return String(result)
    }
    
    func openOnBoarding() {
        let vc = OnBoardingViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        
        present(vc, animated: true, completion: nil)
    }
    
}
