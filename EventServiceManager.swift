//
//  EventServiceManager.swift
//  BounceMe
//
//  Created by Peter Xu on 4/24/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//
//  Much of this class was borrowed from https://www.ralfebert.de/tutorials/ios-swift-multipeer-connectivity/.
//

import UIKit
import MultipeerConnectivity

protocol EventServiceManagerDelegate {
    
    func connectedDevicesChanged(manager : EventServiceManager, connectedDevices: [String])
    func messageReceived(manager: EventServiceManager, message: NSDictionary, sender: MCPeerID)
}

class EventServiceManager: NSObject {
    
    private let EventServiceType = "example-event" //change later
    
    private let myPeerId: MCPeerID!
    private let serviceAdvertiser : MCNearbyServiceAdvertiser
    private var serviceBrowser : MCNearbyServiceBrowser
    var delegate : EventServiceManagerDelegate?
    
    init(peerID: MCPeerID) {
        myPeerId = peerID
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: EventServiceType)
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: EventServiceType)
        
        super.init()
        
        self.serviceAdvertiser.delegate = self
        self.serviceAdvertiser.startAdvertisingPeer()
        
        self.serviceBrowser.delegate = self
        self.serviceBrowser.startBrowsingForPeers()
    }
    
    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
    }
    
    lazy var session : MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.Required)
        session.delegate = self
        return session
    }()
    
    /* 
     * Final Stop before a message is sent out.
     * Converts NSDictionary types (used internally) to NSData type to broadcast.
     */
    func sendMessage(message: NSDictionary) {
        NSLog("%@", "sendJSON: \(message)")
        let eventNSData = NSKeyedArchiver.archivedDataWithRootObject(message)
        if session.connectedPeers.count > 0 {
            do {
                try self.session.sendData(eventNSData, toPeers: session.connectedPeers, withMode: .Reliable)
            } catch {
                NSLog("%@", "\(error)")
            }
            
        }
        
    }
    
}

extension EventServiceManager: MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didNotStartAdvertisingPeer error: NSError!) {
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: (Bool, MCSession) -> Void) {
        NSLog("%@", "didReceiveInvitationFromPeer \(peerID)")
        invitationHandler(true, self.session)
    }
    
}

extension EventServiceManager: MCNearbyServiceBrowserDelegate {
    
//    func browser(browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: NSError) {
//        NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
//    }
    
    func browser(browser: MCNearbyServiceBrowser!, didNotStartBrowsingForPeers error: NSError!) {
        NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
    }
    
    func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        NSLog("%@", "foundPeer: \(peerID)")
        NSLog("%@", "invitePeer: \(peerID)")
        browser.invitePeer(peerID, toSession: self.session, withContext: nil, timeout: 10)
    }
    
//    func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
//        NSLog("%@", "lostPeer: \(peerID)")
//    }
    func browser(browser: MCNearbyServiceBrowser!, lostPeer peerID: MCPeerID!) {
        NSLog("%@", "lostPeer: \(peerID)")
    }
    
    
    
}

extension MCSessionState {
    
    func stringValue() -> String {
        switch(self) {
        case .NotConnected: return "NotConnected"
        case .Connecting: return "Connecting"
        case .Connected: return "Connected"
        default: return "Unknown"
        }
    }
    
}

extension EventServiceManager : MCSessionDelegate {
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        NSLog("%@", "peer \(peerID) didChangeState: \(state.stringValue())")
        print("Delegate is nil: \(self.delegate == nil)")
        self.delegate?.connectedDevicesChanged(self, connectedDevices: session.connectedPeers.map({$0.displayName}))
    }
    
    /*
     * First stop for incoming messages. They are converted to NSDictionaries to be used internally.
     */
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        NSLog("%@", "didReceiveData: \(data)")
        do {
            print("RECEIVED DATA WOOHOO!")
            let msg = try NSKeyedUnarchiver.unarchiveObjectWithData(data) as! NSDictionary
            let sender = msg["sender"] as! MCPeerID
            if let recipient = msg["recipient"] as? MCPeerID {
                if (recipient == myPeerId) {
                    print("Valid recipient")
                    self.delegate?.messageReceived(self, message: msg["content"] as! NSDictionary, sender: sender)
                }
            } else {
                print("All recipients")
                self.delegate?.messageReceived(self, message: msg["content"] as! NSDictionary, sender: sender)
            }
            
        } catch let error {
            print(error)
        }
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
        NSLog("%@", "didReceiveStream")
    }
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
        NSLog("%@", "didFinishReceivingResourceWithName")
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
        NSLog("%@", "didStartReceivingResourceWithName")
    }
    
}
