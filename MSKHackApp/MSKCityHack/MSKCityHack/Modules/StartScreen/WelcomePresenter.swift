//
//  WelcomePresenter.swift
//  MCHProject
//
//  Created by Савченко Максим Олегович on 12.06.2021.
//

import Foundation

protocol WelcomePresenterInput: ViewState {
    func tapToFindButton()
    func tapToPhotoImage()
}

final class WelcomePresenterImp {
    
    unowned var view: WelcomeViewInput?
    
    var router: WelcomeRouter!
    
    init(view: WelcomeViewInput) {
        self.view = view
    }
    
}

extension WelcomePresenterImp: WelcomePresenterInput {
    func tapToPhotoImage() {
        router.goToPhotoScreen()
    }
    
    func tapToFindButton() {
        router.goToMainScreen()
    }
    
    func viewDidLoad() {
        var dateEntity: [CommonEntity] = []
        var eventEntity: [CommonEntity] = []
        
        eventEntity += [EventTitleEntity(title: "Активный отдых", type: .title, isSelected: false),
                        EventTitleEntity(title: "Бесплатно", type: .title, isSelected: false),
                        EventTitleEntity(title: "Выставка", type: .title, isSelected: false),
                        EventTitleEntity(title: "Квест", type: .title, isSelected: false),
                        EventTitleEntity(title: "Кино", type: .title, isSelected: false),
                        EventTitleEntity(title: "Мюзикл", type: .title, isSelected: false),
                        EventTitleEntity(title: "С детьми", type: .title, isSelected: false),
                        EventTitleEntity(title: "Стендап", type: .title, isSelected: false),
                        EventTitleEntity(title: "Спектакль", type: .title, isSelected: false),
                        EventTitleEntity(title: "Спорт", type: .title, isSelected: false),
                        EventTitleEntity(title: "Театр", type: .title, isSelected: false),
                        EventTitleEntity(title: "Специально для вас", type: .title, isSelected: false),
                        EventImageEntity(image: #imageLiteral(resourceName: "Group"), type: .image, isSelected: false)]
        
        dateEntity += [DateTitleEntity(title: "Сегодня", type: .title, isSelected: false),
                       DateTitleEntity(title: "Завтра", type: .title, isSelected: false),
                       DateTitleEntity(title: "На выходных", type: .title, isSelected: false),
                       DateImageEntity(image: #imageLiteral(resourceName: "icons"), type: .image, isSelected: false)]
        
        view?.updateEvent(eventEntity)
        view?.updateDate(dateEntity)
    }
    
}
