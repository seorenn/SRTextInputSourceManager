//
//  SRTextInputSourceManager.swift
//  SRTextInputSourceManager
//
//  Created by Seorenn on 2015. 8. 3..
//  Copyright © 2015 Seorenn. All rights reserved.
//

import Cocoa

public class SRTextInputSource {
    private let impl: SRTextInputSourceImpl
    
    private init(impl: SRTextInputSourceImpl) {
        self.impl = impl
    }
    
    public var localizedName: String {
        return self.impl.localizedName
    }
    public var ID: String {
        return self.impl.ID
    }
    public var isSelectCapable: Bool {
        return self.impl.isSelectCapable
    }
    public var iconImageURL: NSURL? {
        let res = self.impl.iconImageURL
        if res != nil { return res }
        return nil
    }
    public var iconImage: NSImage? {
        let res = self.impl.iconImage
        if res != nil { return res }
        return nil
    }
    public var isInputable: Bool {
        return self.impl.isInputable
    }
    
    public func activate() {
        self.impl.activate()
    }
}

public class SRTextInputSourceManager {
    // Singleton
    public static let sharedManager: SRTextInputSourceManager = SRTextInputSourceManager()
    
    private let impl = SRTextInputSourceManagerImpl.sharedManager()
    
    public init() {}
    
    public var textInputSources: [SRTextInputSource] {
        return self.impl.inputSources.map() {
            SRTextInputSource(impl: $0 as! SRTextInputSourceImpl)
        }
    }
    
    public var currentTextInputSource: SRTextInputSource {
        return SRTextInputSource(impl: self.impl.currentInputSource)
    }
    
    public var currentInputSourceIndex: Int {
        return self.impl.currentInputSourceIndex
    }
    
    public func refresh() {
        self.impl.refresh()
    }
    
    public func inputSource(inputSourceID: String) -> SRTextInputSource {
        let tisImpl = self.impl.inputSourceWithInputSourceID(inputSourceID)
        return SRTextInputSource(impl: tisImpl)
    }
}
