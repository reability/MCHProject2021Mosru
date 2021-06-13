//
//  Socket.swift
//  MSKCityHack
//
//  Created by Савченко Максим Олегович on 13.06.2021.
//

import Starscream

enum ServiceState {
    case offline
    case online
}

protocol HowdiDelegate: class {
    func getMessageFrom(_ message: String)
}

public class HowdiWebsocketService: NSObject, WebSocketDelegate {
    
    public static let shared = HowdiWebsocketService()
    
    var isConnected = false
    private var state: ServiceState = .offline
    
    weak var delegate: HowdiDelegate?
    var socket: WebSocket!
    
    func connect() {
        
        var request = URLRequest(url: URL(string: ServiceConstants.baseUrl2)!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    func sendMessage(_ message: String) {
        
        let jsonForm = """
        {
         "userId": -1,
         "action": "new",
         "code": "bgf321vb",
         "afisha": 1,
         "value": 1,
        }
        """
        
        socket.write(string: jsonForm, completion: nil)
    }
    
    public func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            delegate?.getMessageFrom(string)
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        }
    }
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }
}
