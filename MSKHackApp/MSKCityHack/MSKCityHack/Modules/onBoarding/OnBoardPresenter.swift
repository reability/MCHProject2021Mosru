//
//  OnBoardPresenter.swift
//  MSKCityHack
//
//  Created by Ванурин Алексей Максимович on 12.06.2021.
//

import Foundation

final class OnBoardPresenter {
    
    fileprivate let titles = ["П Р О Г У Л К И", "Т Е А Т Р  Д Л Я  В С Е Х", "И С Т О Р И Я  М О С К В Ы", "К У Л Ь Т У Р Н А Я  С Т О Л И Ц А", "М У З Е И", ""]
    fileprivate let locations = ["Рядом с вами", "В 500 метрах", "", "", "", "", ""]
    
    weak var view: OnBoardingViewController?

    func fetch() {
        let url = URL(string: ServiceConstants.feed)!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(AfishasResult.self, from: data) {
                    DispatchQueue.main.async {
                        self.view?.model = decodedResponse.result.shuffled().map( {
                            Afisha(id: $0.id, title: $0.title, text: $0.text, free: $0.free, img: $0.img,
                                   subtitle: self.titles.randomElement(),
                                   locationText: self.locations.randomElement())
                        } )
                    }
                }
            }
        }.resume()
    }
    
}
