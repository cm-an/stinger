//
//  ControllerLifeCycleProtocol.swift
//  stinger
//
//  Created by 안춘모 on 2/1/24.
//

import Foundation

public protocol ControllerLifeCycleProtocol: AnyObject {
    var controllerLifeCycleDelegate: ControllerLifeCycleDelegate? { get set }
    
    var isLocked: Bool { get set }
}

public protocol ControllerLifeCycleDelegate: AnyObject {
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animaged: Bool)
}

