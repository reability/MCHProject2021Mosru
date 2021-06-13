//
//  Afisha.swift
//  MSKCityHack
//
//  Created by Ванурин Алексей Максимович on 13.06.2021.
//

import Foundation

struct AfishasResult: Codable {
    let result: [Afisha]
}

struct Afisha: Codable {
    let id: Int
    let title: String
    let text: String
    let free: Bool
    let img: String
    
    let subtitle: String?
    let locationText: String?
    
    init(
        id: Int,
        title: String,
        text: String,
        free: Bool,
        img: String,
        subtitle: String?,
        locationText: String?
    ) {
        self.id = id
        self.title = title
        self.text = text
        self.free = free
        self.img = img
        self.subtitle = subtitle
        self.locationText = locationText
    }
}
