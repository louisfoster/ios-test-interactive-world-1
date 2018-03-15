//
//  InputIntent.swift
//  ios-test-input-system-1
//
//  Created by Louie on 11/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import UIKit
import SceneKit

// MARK: Intent Data Structures

struct SelectIntentData {
    
    var hitTestResults: [SCNHitTestResult]
}

struct HorizontalScrollIntentData {
    
    var translation: Float
    var gestureStateEnded: Bool
}

// MARK: Intent Sender Protocols

protocol SelectIntentSenderProtocol {
    
    var sceneView: SCNView? { get }
}

extension SelectIntentSenderProtocol {
    
    func sendSelectIntent(_ selectIntentData: SelectIntentData) {
        
        NotificationCenter.default.post(name: .selectIntent, object: selectIntentData)
    }
}

protocol HorizontalScrollIntentSenderProtocol {}

extension HorizontalScrollIntentSenderProtocol {
    
    func sendHorizontalScrollIntent(_ horizontalScrollIntentData: HorizontalScrollIntentData) {
        
        NotificationCenter.default.post(name: .horizontalScrollIntent, object: horizontalScrollIntentData)
    }
}

// MARK: Intent Observer Protocols

protocol SelectIntentObserverProtocol {
    
    var id: Int { get }
    var inputIntent: InputIntent? { get }
    func onSelectIntent(selectIntentData: SelectIntentData)
}

extension SelectIntentObserverProtocol {
    
    func registerSelectIntentObserver() {
        
        self.inputIntent?.addSelectIntentObserver(id: self.id, onSelectIntent: self.onSelectIntent)
    }
    
    func deregisterSelectIntentObserver() {
        
        self.inputIntent?.removeSelectIntentObserver(id: self.id)
    }
}

protocol HorizontalScrollIntentObserverProtocol {
    
    var id: Int { get }
    var inputIntent: InputIntent? { get }
    func onHorizontalScrollIntent(horizontalScrollIntentData: HorizontalScrollIntentData)
}

extension HorizontalScrollIntentObserverProtocol {
    
    func registerHorizontalScrollIntentObserver() {
        
        self.inputIntent?.addHorizontalScrollIntentObserver(id: self.id, onHorizontalScrollIntent: self.onHorizontalScrollIntent)
    }
    
    func deregisterHorizontalScrollIntentObserver() {
        
        self.inputIntent?.removeHorizontalScrollIntentObserver(id: self.id)
    }
}

// MARK: Input Intent

protocol InputIntentProtocol {
    
    var selectIntentObservers: Dictionary<Int, OnSelectIntentClosure> { get }
    var horizontalScrollIntentObservers: Dictionary<Int, OnHorizontalScrollIntentClosure> { get }
    
    func selectIntentReceived(notification: Notification)
    func horizontalScrollIntentReceived(notification: Notification)
    
    func addSelectIntentObserver(id: Int, onSelectIntent: @escaping OnSelectIntentClosure)
    func addHorizontalScrollIntentObserver(id: Int, onHorizontalScrollIntent: @escaping OnHorizontalScrollIntentClosure)
    
    func removeSelectIntentObserver(id: Int)
    func removeHorizontalScrollIntentObserver(id: Int)
}

class InputIntent: InputIntentProtocol {
    
    // MARK: Properties
    
    private(set) var selectIntentObservers: Dictionary<Int, OnSelectIntentClosure>
    private(set) var horizontalScrollIntentObservers: Dictionary<Int, OnHorizontalScrollIntentClosure>

    // MARK: Initializers
    
    init() {
        
        self.selectIntentObservers = [:]
        self.horizontalScrollIntentObservers = [:]
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(InputIntent.selectIntentReceived(notification:)),
                                               name: .selectIntent,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(InputIntent.horizontalScrollIntentReceived(notification:)),
                                               name: .horizontalScrollIntent,
                                               object: nil)
    }
    
    // MARK: Actions
    
    @objc
    func selectIntentReceived(notification: Notification) {
        
        if let selectIntentData = notification.object as? SelectIntentData {
        
            for (_, onSelectIntent) in self.selectIntentObservers {
                
                onSelectIntent(selectIntentData)
            }
        }
    }
    
    @objc
    func horizontalScrollIntentReceived(notification: Notification) {
        
        if let horizontalScrollIntentData = notification.object as? HorizontalScrollIntentData {
            
            for (_, onHorizontalScrollIntent) in self.horizontalScrollIntentObservers {
                
                onHorizontalScrollIntent(horizontalScrollIntentData)
            }
        }
    }
    
    func addSelectIntentObserver(id: Int, onSelectIntent: @escaping OnSelectIntentClosure) {
        
        self.selectIntentObservers[id] = onSelectIntent
    }
    
    func addHorizontalScrollIntentObserver(id: Int, onHorizontalScrollIntent: @escaping OnHorizontalScrollIntentClosure) {
        
        self.horizontalScrollIntentObservers[id] = onHorizontalScrollIntent
    }
    
    func removeSelectIntentObserver(id: Int) {
        
        self.selectIntentObservers[id] = nil
    }
    
    func removeHorizontalScrollIntentObserver(id: Int) {
        
        self.horizontalScrollIntentObservers[id] = nil
    }
}
