//
//  InventorySocketManager.swift
//  InventorySocketManager
//
//  Created by Manu on 16/05/2020.
//  Copyright © 2020 Manu. All rights reserved.
//

import Foundation
import Network


class InventorySocketManager {
    
    var connection: NWConnection
    
    init(serverIp: String, serverPort: Int32, typeProtocol: NWParameters, autostart: Bool) {
        if(IPv4Address(serverIp) == nil){
            print("IP IS INVALID.")
            fatalError()
        }
        else
        {
            let host = NWEndpoint.Host(serverIp)
            let port = NWEndpoint.Port("\(serverPort)")!
            self.connection = NWConnection(host: host, port: port, using: typeProtocol)
            if autostart {
                print("Autostart is enabled, starting...")
                self.start()
            }
            print("IP IS VALID: \(serverIp):\(serverPort)")
        }
    }
    
    func retriveSocketResponseType(data: String) -> (Type: String,Message: String) {
        var type = data.components(separatedBy: ":")
        switch type[0] {
        case "T": // T = Titolo
            return (type[0],type[1])
        case "D": // D = Descrizione
            return (type[0],type[1])
        case "DU": // DU = Durabilita'
            return (type[0],type[1])
        case "DUR": // T = Durabilita
            return (type[0],type[1])
        case "HP": // T = Healt Points
            return (type[0],type[1])
        case "HPMAX": // T = Max Healt Point
            return (type[0],type[1])
        case "N": // T = Nome
            return (type[0],type[1])
        case "NC": // T = Name Character o Nome Categoria o numero oggetti Categoria
            return (type[0],type[1])
        case "NOB":
            return (type[0],type[1])
        case "NOC": // Numero oggetti cateogira
            return (type[0],type[1])
        case "NOU": // Numero utenti online
            return (type[0],type[1])
        case "NS":
            return (type[0],type[1])
        case "NU":
            return (type[0],type[1])
        case "NUO": // T = Titolo
            return (type[0],type[1])
        case "NUOS": // T = Titolo
            return (type[0],type[1])
        case "PE": // T = Peso
            return (type[0],type[1])
        case "PO": // T = Potenza
            return (type[0],type[1])
        case "Q": // T = Quantità
            return (type[0],type[1])
        case "QI": // T = Quantita dell'elemento
            return (type[0],type[1])
        case "QU": // T = Titolo
            return (type[0],type[1])
        case "R": // T = Titolo
            return (type[0],type[1])
        case "RC": // T = Rarita' colore
            return (type[0],type[1])
        case "S": // T = Sottotitolo
            return (type[0],type[1])
        case "T": // T = Titolo
            return (type[0],type[1])
        case "TP": // T = Tipo potenza
            return (type[0],type[1])
        case "V": // T = Valore
            return (type[0],type[1])
        default:
            fatalError()
        }
    }
    
    func start() {
        NSLog("Starting handler..")
        self.connection.stateUpdateHandler = self.didChange(state:)
        self.connection.start(queue: .main)
    }
    
    func stop() {
        
        self.connection.cancel()
        NSLog("Stopping handler..")
    }
    
    private func didChange(state: NWConnection.State) {
        switch state {
        case .setup:
            break
        case .waiting(let error):
            NSLog("is waiting: %@", "\(error)")
        case .preparing:
            break
        case .ready:
            break
        case .failed(let error):
            NSLog("did fail, error: %@", "\(error)")
            self.stop()
        case .cancelled:
            NSLog("was cancelled")
            self.stop()
        @unknown default:
            break
        }
    }
    
    func startReceive(completionHandler: @escaping (String) -> Void) {
        var result = ""
        self.connection.receive(minimumIncompleteLength: 1, maximumLength: 30) { data, _, isDone, error in
            if let data = data, !data.isEmpty {
                NSLog("did receive, data: %@", data as NSData)
                result = String(decoding: data, as: UTF8.self)
            }
            if let error = error {
                NSLog("did receive, error: %@", "\(error)")
                self.stop()
                result = error.debugDescription
                print(result)
                fatalError()
            }
            if isDone {
                NSLog("did receive, EOF")
                self.stop()
                result = String(decoding: data!, as: UTF8.self)
            }
            completionHandler(result)
        }
    }
    
    func send(line: String) {
        let data = Data("\(line)\r\n".utf8)
        self.connection.send(content: data, completion: NWConnection.SendCompletion.contentProcessed { error in
            if let error = error {
                NSLog("did send, error: %@", "\(error)")
                self.stop()
            } else {
                NSLog("did send, data: %@", data as NSData)
            }
        })
    }
    
    /* Functions by Manu */
    
    func connect(username: String, password: String, connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
        if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
            connectionInstance.send(line: "ios")
            connectionInstance.send(line: "connect")
            connectionInstance.send(line: username)
            connectionInstance.send(line: password)
            connectionInstance.startReceive { (result) in
                if let resultInInt = Int(result)
                {
                    if(resultInInt == -2 || resultInInt == -1)
                    {
                        completion(result)
                    }
                    else
                    {
                        completion(result)
                        connectionInstance.startReceive { (result) in
                            if let resultInInt = Int(result) {
                                completion(result)
                                if(resultInInt != 0)
                                {
                                    for _ in 1...resultInInt {
                                        connectionInstance.startReceive { (result) in
                                            completion(result)
                                            connectionInstance.startReceive { (result) in
                                                completion(result)
                                                connectionInstance.startReceive { (result) in
                                                    completion(result)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            else
                            {
                                completion("not4")
                            }
                        }
                    }
                }
                else
                {
                    completion("-1")
                }
            }
        }
    }
    
    func get_number_user_online_session(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
        print(connectionInstance.connection.state)
        if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
            connectionInstance.send(line: "ios")
            connectionInstance.send(line: "get_number_user_online_session")
            connectionInstance.startReceive { (result) in
                if let resultInInt = Int(result)
                {
                    if(resultInInt == -1)
                    {
                        completion(result)
                    }
                    else
                    {
                        completion(result)
                        connectionInstance.startReceive { (result) in
                            if let resultInInt = Int(result) {
                                completion(result)
                                if(resultInInt != 0)
                                {
                                    for _ in 1...resultInInt {
                                        connectionInstance.startReceive { (result) in
                                            completion(result)
                                        }
                                    }
                                }
                            }
                            else
                            {
                                completion("not4")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func connect_session(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
        print(connectionInstance.connection.state)
        if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
            connectionInstance.send(line: "ios")
            connectionInstance.send(line: "connect_session")
            connectionInstance.startReceive { (result) in
                if let resultInInt = Int(result)
                {
                    if(resultInInt == -1)
                    {
                        completion(result)
                    }
                    else
                    {
                        completion(result)
                        connectionInstance.startReceive { (result) in
                            if let resultInInt = Int(result) {
                                completion(result)
                                if(resultInInt != 0)
                                {
                                    for _ in 1...resultInInt {
                                        connectionInstance.startReceive { (result) in
                                            completion(result)
                                            connectionInstance.startReceive { (result) in
                                                completion(result)
                                                connectionInstance.startReceive { (result) in
                                                    completion(result)
                                                    connectionInstance.startReceive { (result) in
                                                        completion(result)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    
                                }
                                else
                                {
                                    completion("not4")
                                }
                            }
                        }
                    }
                }
            }
        }
        
        func disconnect(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
            print(connectionInstance.connection.state)
            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                connectionInstance.send(line: "ios")
                connectionInstance.send(line: "disconnect")
                connectionInstance.startReceive { (result) in
                    if let resultInInt = Int(result)
                    {
                        if(resultInInt == -1)
                        {
                            completion(result)
                        }
                        else
                        {
                            completion(result)
                            connectionInstance.startReceive { (result) in
                                if let resultInInt = Int(result) {
                                    completion(result)
                                    if(resultInInt != 0)
                                    {
                                        for _ in 1...resultInInt {
                                            connectionInstance.startReceive { (result) in
                                                completion(result)
                                            }
                                        }
                                        
                                    }
                                    else
                                    {
                                        completion("not4")
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            func get_user_id(send_username:String, connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                print(connectionInstance.connection.state)
                if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                    connectionInstance.send(line: "ios")
                    connectionInstance.send(line: "get_user_id")
                    connectionInstance.send(line: send_username)
                    connectionInstance.startReceive { (result) in
                        if let resultInInt = Int(result)
                        {
                            if(resultInInt == -1)
                            {
                                completion(result)
                            }
                            else
                            {
                                completion(result)
                                connectionInstance.startReceive { (result) in
                                    if let resultInInt = Int(result) {
                                        completion(result)
                                        if(resultInInt != 0)
                                        {
                                            for _ in 1...resultInInt {
                                                connectionInstance.startReceive { (result) in
                                                    completion(result)
                                                }
                                            }
                                            
                                        }
                                        else
                                        {
                                            completion("not4")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                
                func create_user(new_username:String,new_password:String,new_email: String, connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                    print(connectionInstance.connection.state)
                    if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                        connectionInstance.send(line: "ios")
                        connectionInstance.send(line: "create_user")
                        connectionInstance.send(line: new_username)
                        connectionInstance.send(line: new_password)
                        connectionInstance.send(line: new_email)

                        connectionInstance.startReceive { (result) in
                            if let resultInInt = Int(result)
                            {
                                if(resultInInt == -1)
                                {
                                    completion(result)
                                }
                                else
                                {
                                    completion(result)
                                    connectionInstance.startReceive { (result) in
                                        if let resultInInt = Int(result) {
                                            completion(result)
                                            if(resultInInt != 0)
                                            {
                                                for _ in 1...resultInInt {
                                                    connectionInstance.startReceive { (result) in
                                                        completion(result)
                                                    }
                                                }
                                                
                                            }
                                            else
                                            {
                                                completion("not4")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    func create_category(c_name: String,c_desc: String,c_numero_slot: String, c_number: String, c_type: String, connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                        print(connectionInstance.connection.state)
                        if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                            connectionInstance.send(line: "ios")
                            connectionInstance.send(line: "create_category")
                            connectionInstance.send(line: c_name)
                            connectionInstance.send(line: c_desc)
                            connectionInstance.send(line: c_numero_slot)
                            connectionInstance.send(line: c_number)
                            connectionInstance.send(line: c_type)

                            connectionInstance.startReceive { (result) in
                                if let resultInInt = Int(result)
                                {
                                    if(resultInInt == -1)
                                    {
                                        completion(result)
                                    }
                                    else
                                    {
                                        completion(result)
                                        connectionInstance.startReceive { (result) in
                                            if let resultInInt = Int(result) {
                                                completion(result)
                                                if(resultInInt != 0)
                                                {
                                                    for _ in 1...resultInInt {
                                                        connectionInstance.startReceive { (result) in
                                                            completion(result)
                                                        }
                                                    }
                                                    
                                                }
                                                else
                                                {
                                                    completion("not4")
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                        
                        func show_category_all(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                            print(connectionInstance.connection.state)
                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                connectionInstance.send(line: "ios")
                                connectionInstance.send(line: "show_category_all")
                                connectionInstance.startReceive { (result) in
                                    if let resultInInt = Int(result)
                                    {
                                        if(resultInInt == -1)
                                        {
                                            completion(result)
                                        }
                                        else
                                        {
                                            completion(result)
                                            connectionInstance.startReceive { (result) in
                                                if let resultInInt = Int(result) {
                                                    completion(result)
                                                    if(resultInInt != 0)
                                                    {
                                                        for _ in 1...resultInInt {
                                                            connectionInstance.startReceive { (result) in
                                                                completion(result)
                                                                connectionInstance.startReceive { (result) in
                                                                    completion(result)
                                                                    connectionInstance.startReceive { (result) in
                                                                        completion(result)
                                                                        connectionInstance.startReceive { (result) in
                                                                            completion(result)
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                    else
                                                    {
                                                        completion("not4")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                            
                            func trading_from(trade_c_name1:String, trade_c_name2: String, number_item_trade_1:String, number_item_trade_2:String, connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                print(connectionInstance.connection.state)
                                if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                    connectionInstance.send(line: "ios")
                                    connectionInstance.send(line: "trading_from")
                                    connectionInstance.send(line: trade_c_name1)
                                    connectionInstance.send(line: trade_c_name2)
                                    connectionInstance.send(line: number_item_trade_1)
                                    connectionInstance.send(line: number_item_trade_2)
                                    connectionInstance.startReceive { (result) in
                                        if let resultInInt = Int(result)
                                        {
                                            if(resultInInt == -1)
                                            {
                                                completion(result)
                                            }
                                            else
                                            {
                                                completion(result)
                                                connectionInstance.startReceive { (result) in
                                                    if let resultInInt = Int(result) {
                                                        completion(result)
                                                        if(resultInInt != 0)
                                                        {
                                                            for _ in 1...resultInInt {
                                                                connectionInstance.startReceive { (result) in
                                                                    completion(result)
                                                                }
                                                            }
                                                        }
                                                        else
                                                        {
                                                            completion("not4")
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                func trading_with(trade_name_c:String, number_item_trade_1: String, number_item_trade_2: String, connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                    print(connectionInstance.connection.state)
                                    if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                        connectionInstance.send(line: "ios")
                                        connectionInstance.send(line: "trading_with")
                                        connectionInstance.send(line: trade_name_c)
                                        connectionInstance.send(line: number_item_trade_1)
                                        connectionInstance.send(line: number_item_trade_2)
                                        connectionInstance.startReceive { (result) in
                                            if let resultInInt = Int(result)
                                            {
                                                if(resultInInt == -1)
                                                {
                                                    completion(result)
                                                }
                                                else
                                                {
                                                    completion(result)
                                                    connectionInstance.startReceive { (result) in
                                                        if let resultInInt = Int(result) {
                                                            completion(result)
                                                            if(resultInInt != 0)
                                                            {
                                                                for _ in 1...resultInInt {
                                                                    connectionInstance.startReceive { (result) in
                                                                        completion(result)
                                                                    }
                                                                }
                                                            }
                                                            else
                                                            {
                                                                completion("not4")
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    func show_user_character(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                        print(connectionInstance.connection.state)
                                        if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                            connectionInstance.send(line: "ios")
                                            connectionInstance.send(line: "show_user_character")
                                            connectionInstance.startReceive { (result) in
                                                if let resultInInt = Int(result)
                                                {
                                                    if(resultInInt == -1)
                                                    {
                                                        completion(result)
                                                    }
                                                    else
                                                    {
                                                        completion(result)
                                                        connectionInstance.startReceive { (result) in
                                                            if let resultInInt = Int(result) {
                                                                completion(result)
                                                                if(resultInInt != 0)
                                                                {
                                                                    for _ in 1...resultInInt {
                                                                        connectionInstance.startReceive { (result) in
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                completion(result)
                                                                                connectionInstance.startReceive { (result) in
                                                                                    completion(result)
                                                                                    connectionInstance.startReceive { (result) in
                                                                                        completion(result)
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                                else
                                                                {
                                                                    completion("not4")
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        
                                        func show_category_objects(c_name:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                            print(connectionInstance.connection.state)
                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                connectionInstance.send(line: "ios")
                                                connectionInstance.send(line: "show_category_objects")
                                                connectionInstance.send(line: c_name)
                                                
                                                connectionInstance.startReceive { (result) in
                                                    if let resultInInt = Int(result)
                                                    {
                                                        if(resultInInt == -1)
                                                        {
                                                            completion(result)
                                                        }
                                                        else
                                                        {
                                                            completion(result)
                                                            connectionInstance.startReceive { (result) in
                                                                if let resultInInt = Int(result) {
                                                                    completion(result)
                                                                    if(resultInInt != 0)
                                                                    {
                                                                        for _ in 1...resultInInt {
                                                                            connectionInstance.startReceive { (result) in
                                                                                completion(result)
                                                                                connectionInstance.startReceive { (result) in
                                                                                    completion(result)
                                                                                    connectionInstance.startReceive { (result) in
                                                                                        completion(result)
                                                                                        connectionInstance.startReceive { (result) in
                                                                                            completion(result)
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                    else
                                                                    {
                                                                        completion("not4")
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            
                                            func show_category(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                print(connectionInstance.connection.state)
                                                if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                    connectionInstance.send(line: "ios")
                                                    connectionInstance.send(line: "show_category")
                                                    connectionInstance.startReceive { (result) in
                                                        if let resultInInt = Int(result)
                                                        {
                                                            if(resultInInt == -1)
                                                            {
                                                                completion(result)
                                                            }
                                                            else
                                                            {
                                                                completion(result)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result) {
                                                                        completion(result)
                                                                        if(resultInInt != 0)
                                                                        {
                                                                            for _ in 1...resultInInt {
                                                                                connectionInstance.startReceive { (result) in
                                                                                    completion(result)
                                                                                    connectionInstance.startReceive { (result) in
                                                                                        completion(result)
                                                                                        connectionInstance.startReceive { (result) in
                                                                                            completion(result)
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                                }
                                                                            }
                                                                            else
                                                                            {
                                                                                completion("not4")
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                func update_user(ob_type:String,ob_data:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                        print(connectionInstance.connection.state)
                                                        if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                            connectionInstance.send(line: "ios")
                                                            connectionInstance.send(line: "update_user")
                                                            connectionInstance.send(line: ob_type)
                                                            connectionInstance.send(line: ob_data)
                                                            connectionInstance.startReceive { (result) in
                                                                if let resultInInt = Int(result)
                                                                {
                                                                    if(resultInInt == -1)
                                                                    {
                                                                        completion(result)
                                                                    }
                                                                    else
                                                                    {
                                                                        completion(result)
                                                                        connectionInstance.startReceive { (result) in
                                                                            if let resultInInt = Int(result) {
                                                                                completion(result)
                                                                                if(resultInInt != 0)
                                                                                {
                                                                                    for _ in 1...resultInInt {
                                                                                        connectionInstance.startReceive { (result) in
                                                                                            completion(result)
                                                                                        }
                                                                                    }
                                                                                    
                                                                                }
                                                                                else
                                                                                {
                                                                                    completion("not4")
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        
                                                        func disconnect_session(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "disconnect_session")
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion("-1")
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        func get_users_session(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "get_users_session")
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                        completion(result)
                                                                                                        connectionInstance.startReceive { (result) in
                                                                                                            completion(result)
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                        
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        func show_user_session(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "show_user_session")
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                        completion(result)
                                                                                                        connectionInstance.startReceive { (result) in
                                                                                                            completion(result)
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                        
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func create_session(s_titolo:String,s_sottotitolo:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "create_session")
                                                                connectionInstance.send(line: s_titolo)
                                                                connectionInstance.send(line: s_sottotitolo)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                        
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func add_session(s_codice_invito:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "add_session")
                                                                connectionInstance.send(line: s_codice_invito)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                        completion(result)
                                                                                                        connectionInstance.startReceive { (result) in
                                                                                                            completion(result)
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                        
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        func show_items_session(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "show_items_session")
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                        completion(result)
                                                                                                        connectionInstance.startReceive { (result) in
                                                                                                            completion(result)
                                                                                                            connectionInstance.startReceive { (result) in
                                                                                                                completion(result)
                                                                                                                connectionInstance.startReceive { (result) in
                                                                                                                    completion(result)
                                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                                        completion(result)
                                                                                                                        connectionInstance.startReceive { (result) in
                                                                                                                            completion(result)
                                                                                                                            connectionInstance.startReceive { (result) in
                                                                                                                                completion(result)
                                                                                                                            }
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func update_session_data(o_nome:String,ob_type:String,ob_data:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "update_session_data")
                                                                connectionInstance.send(line: o_nome)
                                                                connectionInstance.send(line: ob_type)
                                                                connectionInstance.send(line: ob_data)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                        completion(result)
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        func show_users_online(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "show_users_online")
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func unlock_trading(character_nome:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "unlock_trading")
                                                                connectionInstance.send(line: character_nome)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func lock_trading(character_nome:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "lock_trading")
                                                                connectionInstance.send(line: character_nome)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func get_category_data(o_nome:String,ob_type:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "get_category_data")
                                                                connectionInstance.send(line: o_nome)
                                                                connectionInstance.send(line: ob_type)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func update_category_data(o_nome:String,ob_type:String,ob_data:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "update_category_data")
                                                                connectionInstance.send(line: o_nome)
                                                                connectionInstance.send(line: ob_type)
                                                                connectionInstance.send(line: ob_data)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        
                                                    func get_avaible_category_items(ob_type:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "get_avaible_category_items")
                                                                connectionInstance.send(line: ob_type)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                        completion(result)
                                                                                                        connectionInstance.startReceive { (result) in
                                                                                                            completion(result)
                                                                                                            connectionInstance.startReceive { (result) in
                                                                                                                completion(result)
                                                                                                                connectionInstance.startReceive { (result) in
                                                                                                                    completion(result)
                                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                                        completion(result)
                                                                                                                    }
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func get_object_data(o_nome:String,ob_type:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "get_object_data")
                                                                connectionInstance.send(line: o_nome)
                                                                connectionInstance.send(line: ob_type)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func update_object_data(o_nome:String,ob_type:String,ob_data:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "update_object_data")
                                                                connectionInstance.send(line: o_nome)
                                                                connectionInstance.send(line: ob_type)
                                                                connectionInstance.send(line: ob_data)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func add_object_equipment(c_name:String,what_character:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "add_object_equipment")
                                                                connectionInstance.send(line: c_name)
                                                                connectionInstance.send(line: what_character)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func remove_object_equipment(o_nome:String,ob_quantity:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "remove_object_equipment")
                                                                connectionInstance.send(line: o_nome)
                                                                connectionInstance.send(line: ob_quantity)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func add_object_category(c_name:String,o_nome:String,ob_quantity:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "add_object_category")
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func add_object_character(c_name:String,o_nome:String,ob_quantity:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "add_object_character")
                                                                connectionInstance.send(line: c_name)
                                                                connectionInstance.send(line: o_nome)
                                                                connectionInstance.send(line: ob_quantity)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func remove_object_character(o_nome:String,ob_quantity:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "remove_object_character")
                                                                connectionInstance.send(line: o_nome)
                                                                connectionInstance.send(line: ob_quantity)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func create_object(o_nome:String,o_descrizione:String,o_rarita:String,o_campo1:String, o_campo2:String,o_campo3:String,o_campo4:String, o_campo5:String, o_valore:String, o_peso:String,o_potenza:String,o_durabilita:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "create_object")
                                                                connectionInstance.send(line: o_nome)
                                                                connectionInstance.send(line: o_descrizione)
                                                                connectionInstance.send(line: o_rarita)
                                                                connectionInstance.send(line: o_campo1)
                                                                connectionInstance.send(line: o_campo2)
                                                                connectionInstance.send(line: o_campo3)
                                                                connectionInstance.send(line: o_campo4)
                                                                connectionInstance.send(line: o_campo5)
                                                                connectionInstance.send(line: o_valore)
                                                                connectionInstance.send(line: o_peso)
                                                                connectionInstance.send(line: o_potenza)
                                                                connectionInstance.send(line: o_durabilita)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        func close_connection(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "close_connection")
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        
                                                    func get_equipment_from_category(c_name:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "get_equipment_from_category")
                                                                connectionInstance.send(line: c_name)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                        completion(result)
                                                                                                        connectionInstance.startReceive { (result) in
                                                                                                            completion(result)
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        func get_equipment(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "get_equipment")
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                        completion(result)
                                                                                                        connectionInstance.startReceive { (result) in
                                                                                                            completion(result)
                                                                                                            connectionInstance.startReceive { (result) in
                                                                                                                completion(result)
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                            
                                                    func get_quantity_object(trade_name_c:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                        print(connectionInstance.connection.state)
                                                        if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                            connectionInstance.send(line: "ios")
                                                            connectionInstance.send(line: "get_quantity_object")
                                                            connectionInstance.send(line: trade_name_c)
                                                            connectionInstance.startReceive { (result) in
                                                                if let resultInInt = Int(result)
                                                                {
                                                                    if(resultInInt == -1)
                                                                    {
                                                                        completion(result)
                                                                    }
                                                                    else
                                                                    {
                                                                        completion(result)
                                                                        connectionInstance.startReceive { (result) in
                                                                            if let resultInInt = Int(result) {
                                                                                completion(result)
                                                                                if(resultInInt != 0)
                                                                                {
                                                                                    for _ in 1...resultInInt {
                                                                                        connectionInstance.startReceive { (result) in
                                                                                            completion(result)
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                                else
                                                                                {
                                                                                    completion("not4")
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                    
                                                    func get_quantity_object_from_character(c_name:String,trade_name_c:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "get_quantity_object_from_character")
                                                                connectionInstance.send(line: c_name)
                                                                connectionInstance.send(line: trade_name_c)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                        completion(result)
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        
                                                    func get_character_backpack(filter_item:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "get_character_backpack")
                                                                connectionInstance.send(line: filter_item)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                        completion(result)
                                                                                                        connectionInstance.startReceive { (result) in
                                                                                                            completion(result)
                                                                                                            connectionInstance.startReceive { (result) in
                                                                                                                completion(result)
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func get_user_backpack(filter_item:String,send_id:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "get_user_backpack")
                                                                connectionInstance.send(line: filter_item)
                                                                connectionInstance.send(line: send_id)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                        completion(result)
                                                                                                        connectionInstance.startReceive { (result) in
                                                                                                            completion(result)
                                                                                                            connectionInstance.startReceive { (result) in
                                                                                                                completion(result)
                                                                                                                connectionInstance.startReceive { (result) in
                                                                                                                    completion(result)
                                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                                        completion(result)
                                                                                                                        connectionInstance.startReceive { (result) in
                                                                                                                            completion(result)
                                                                                                                            connectionInstance.startReceive { (result) in
                                                                                                                                completion(result)
                                                                                                                            }}}}
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        func get_backpack(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "get_backpack")
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                        completion(result)
                                                                                                        connectionInstance.startReceive { (result) in
                                                                                                            completion(result)
                                                                                                            connectionInstance.startReceive { (result) in
                                                                                                                completion(result)
                                                                                                                connectionInstance.startReceive { (result) in
                                                                                                                    completion(result)
                                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                                        completion(result)
                                                                                                                        connectionInstance.startReceive { (result) in
                                                                                                                            completion(result)
                                                                                                                            connectionInstance.startReceive { (result) in
                                                                                                                                completion(result)
                                                                                                                            }}}}
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        
                                                        func get_peso(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "get_peso")
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        func get_filtered_backpack(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "get_filtered_backpack")
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                        completion(result)
                                                                                                        connectionInstance.startReceive { (result) in
                                                                                                            completion(result)
                                                                                                            connectionInstance.startReceive { (result) in
                                                                                                                completion(result)
                                                                                                                connectionInstance.startReceive { (result) in
                                                                                                                    completion(result)
                                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                                        completion(result)
                                                                                                                        connectionInstance.startReceive { (result) in
                                                                                                                            completion(result)
                                                                                                                            connectionInstance.startReceive { (result) in
                                                                                                                                completion(result)
                                                                                                                            }
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    func update_hp_max(character_nome:String,character_hp:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "update_hp_max")
                                                                connectionInstance.send(line: character_nome)
                                                                connectionInstance.send(line: character_hp)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func update_hp(character_nome:String,character_hp:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "update_hp")
                                                                connectionInstance.send(line: character_nome)
                                                                connectionInstance.send(line: character_hp)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    func update_personaggi_data(o_nome:String,ob_type:String,ob_data:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "update_personaggi_data")
                                                                connectionInstance.send(line: o_nome)
                                                                connectionInstance.send(line: ob_type)
                                                                connectionInstance.send(line: ob_data)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func add_personaggio(character_nome:String, character_hp:String, character_biografia:String, character_razza:String,character_eta:String,character_peso:String,character_altezza:String, character_hp_max:String,what_character:String,character_capelli:String,character_occhi:String,character_mark:String,character_cicatrici:String,character_tatuaggi:String,character_luogo_nascita:String,character_sesso:String,character_colore_pelle:String,character_anno_nascita:String,character_classe:String, connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: character_nome)
                                                                connectionInstance.send(line: character_hp)
                                                                connectionInstance.send(line: character_biografia)
                                                                connectionInstance.send(line: character_razza)
                                                                connectionInstance.send(line: character_eta)
                                                                connectionInstance.send(line: character_peso)
                                                                connectionInstance.send(line: character_altezza)
                                                                connectionInstance.send(line: character_hp_max)
                                                                connectionInstance.send(line: what_character)
                                                                connectionInstance.send(line: character_capelli)
                                                                connectionInstance.send(line: character_occhi)
                                                                connectionInstance.send(line: character_mark)
                                                                connectionInstance.send(line: character_cicatrici)
                                                                connectionInstance.send(line: character_tatuaggi)
                                                                connectionInstance.send(line: character_luogo_nascita)
                                                                connectionInstance.send(line: character_sesso)
                                                                connectionInstance.send(line: character_colore_pelle)
                                                                connectionInstance.send(line: character_anno_nascita)
                                                                connectionInstance.send(line: character_classe)

                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    func add_character(character_nome:String, character_hp:String, character_biografia:String, character_razza:String, character_eta:String, character_peso:String, character_altezza:String, character_hp_max:String, character_capelli:String, character_occhi:String, character_mark:String, character_cicatrici:String, character_tatuaggi:String, character_luogo_nascita:String, character_sesso:String, character_colore_pelle: String, character_anno_nascita:String, character_classe:String, connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "add_character")
                                                                connectionInstance.send(line: character_nome)
                                                                connectionInstance.send(line: character_hp)
                                                                connectionInstance.send(line: character_biografia)
                                                                connectionInstance.send(line: character_razza)
                                                                connectionInstance.send(line: character_eta)
                                                                connectionInstance.send(line: character_peso)
                                                                connectionInstance.send(line: character_altezza)
                                                                connectionInstance.send(line: character_hp_max)
                                                                connectionInstance.send(line: character_capelli)
                                                                connectionInstance.send(line: character_occhi)
                                                                connectionInstance.send(line: character_mark)
                                                                connectionInstance.send(line: character_cicatrici)
                                                                connectionInstance.send(line: character_tatuaggi)
                                                                connectionInstance.send(line: character_luogo_nascita)
                                                                connectionInstance.send(line: character_sesso)
                                                                connectionInstance.send(line: character_colore_pelle)
                                                                connectionInstance.send(line: character_anno_nascita)
                                                                connectionInstance.send(line: character_classe)

                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        func connect_character(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "connect_character")
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        func disconnect_character(connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "disconnect_character")
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        
                                                    func get_personaggi_data(o_nome:String,ob_type:String,connectionInstance: InventorySocketManager, completion: @escaping (String) -> Void) {
                                                            print(connectionInstance.connection.state)
                                                            if connectionInstance.connection.state == .setup && connectionInstance.connection.state != .cancelled {
                                                                connectionInstance.send(line: "ios")
                                                                connectionInstance.send(line: "get_personaggi_data")
                                                                connectionInstance.send(line: o_nome)
                                                                connectionInstance.send(line: ob_type)
                                                                connectionInstance.startReceive { (result) in
                                                                    if let resultInInt = Int(result)
                                                                    {
                                                                        if(resultInInt == -1)
                                                                        {
                                                                            completion(result)
                                                                        }
                                                                        else
                                                                        {
                                                                            completion(result)
                                                                            connectionInstance.startReceive { (result) in
                                                                                if let resultInInt = Int(result) {
                                                                                    completion(result)
                                                                                    if(resultInInt != 0)
                                                                                    {
                                                                                        for _ in 1...resultInInt {
                                                                                            connectionInstance.startReceive { (result) in
                                                                                                completion(result)
                                                                                                connectionInstance.startReceive { (result) in
                                                                                                    completion(result)
                                                                                                    connectionInstance.startReceive { (result) in
                                                                                                        completion(result)
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        completion("not4")
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
