//
//  ViewController.swift
//  D&D-Tool
//
//  Created by Michele Simonetti on 25/05/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        var i = 0
        
        super.viewDidLoad()
        var inventorySocketManager = InventorySocketManager(serverIp: "2.45.124.19", serverPort: 8181, typeProtocol: .tcp,autostart: true)
        inventorySocketManager.connect(username: "ince", password: "ince", connectionInstance: inventorySocketManager, completion: { result in
            
            if(i == 0)
            {
                print("\nRisposta iniziale = \(result)\n")
            }
            else if(i == 1)
            {
                print("\nNumero Sessioni = \(result)\n")
            }
            
            else
            {
                
                //print("\nVAR = \(result)\n")
                if(result.hasPrefix("T"))
                {
                    var t = result.components(separatedBy: "T:")[1]
                    print("\nTitolo: \(t)\n")
                }
                
                else if(result.hasPrefix("S"))
                {
                    var t = result.components(separatedBy: "S:")[1]
                    print("\nSottoTitolo: \(t)\n")
                }
                
                else if(result.hasPrefix("NU"))
                {
                    var t = result.components(separatedBy: "NU:")[1]
                    print("\nNumero Utenti Online: \(t)\n")
                }
                
            }
            i = i + 1
            })
    }
}
