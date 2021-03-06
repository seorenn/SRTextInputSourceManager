//
//  SRTextInputSourceManager.swift
//  SRTextInputSourceManager
//
//  Copyright 2015-2018 Seorenn. All rights reserved.
//

import Foundation
import Carbon

public class SRTextInputSourceManager {

    public static let shared = SRTextInputSourceManager()

    public var inputSourceSelected: (() -> Void)? = nil

    public init() {
        DistributedNotificationCenter.default().addObserver(forName: Notification.Name(rawValue: kTISNotifySelectedKeyboardInputSourceChanged as String), object: nil, queue: OperationQueue.main) {
            [unowned self] (notification) in
            if let handler = self.inputSourceSelected {
                handler()
            }
        }
    }

    deinit {
        DistributedNotificationCenter.default().removeObserver(self)
    }
    
    public var inputSources: [SRTextInputSource] {
        guard let iss = TISCreateInputSourceList(nil, false)?.takeRetainedValue() as? [TISInputSource] else {
            return []
        }
        
        return iss.map { SRTextInputSource(inputSource: $0) }
    }
    
    public var activatingInputSource: SRTextInputSource? {
        return SRTextInputSource(inputSource: TISCopyCurrentKeyboardInputSource()!.takeRetainedValue())
    }
    
    public func inputSource(identifier: String) -> SRTextInputSource? {
        for source in inputSources {
            if source.identifier == identifier {
                return source
            }
        }
        return nil
    }
    
}
