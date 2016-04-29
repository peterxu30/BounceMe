//
//  MultipeerSendableData.swift
//  BounceMe
//
//  Created by Peter Xu on 4/29/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol MultipeerSendableMessage {
    
    func convertTOSendableObject(sender: MCPeerID, recipient: MCPeerID?) -> NSDictionary
    
}