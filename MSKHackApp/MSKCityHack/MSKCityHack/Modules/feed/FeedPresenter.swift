//
//  FeedPresenter.swift
//  MSKCityHack
//
//  Created by Ванурин Алексей Максимович on 13.06.2021.
//

import Foundation
import Starscream

final class FeedPresenter {
    
    weak var view: FeedViewController?
    
    func fetch() {
        let url = URL(string: ServiceConstants.feed)!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(AfishasResult.self, from: data) {
                    DispatchQueue.main.async {
                        var temp = decodedResponse.result.shuffled()
                        temp.insert(Afisha(id: -1, title: "Афиша событий, подобранная специально для вас", text: "", free: true, img: "brain", subtitle: nil, locationText: nil), at: 3)
                        self.view?.model = temp
                        
                    }
                }
            }
        }.resume()
    }
    
    func connectAndSendSocket() {
        
        HowdiWebsocketService.shared.connect()
        HowdiWebsocketService.shared.sendMessage("")
        
    }
    
}
