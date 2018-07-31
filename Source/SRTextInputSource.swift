//
//  SRTextInputSource.swift
//  SRTextInputSourceManager
//
//  Copyright 2015-2018 Seorenn. All rights reserved.
//

import Foundation
import Carbon

public struct SRTextInputSource: CustomDebugStringConvertible {
    let inputSource: TISInputSource
    
    public init(inputSource: TISInputSource) {
        self.inputSource = inputSource
    }
    
    public var localizedName: String {
        let ptr = TISGetInputSourceProperty(inputSource, kTISPropertyLocalizedName)
        return unsafeBitCast(ptr, to: CFString.self) as String
    }
    
    public var identifier: String {
        let ptr = TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceID)
        return unsafeBitCast(ptr, to: CFString.self) as String
    }
    
    public var type: String {
        let ptr = TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceType)
        return unsafeBitCast(ptr, to: CFString.self) as String
    }
    
    public var debugDescription: String {
        return "<SRTextInputSource: \(localizedName)(\(identifier))"
    }
    
    public var isSelectCapable: Bool {
        let ptr = TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceIsSelectCapable)
        let cfbool = unsafeBitCast(ptr, to: CFBoolean.self)
        return CFBooleanGetValue(cfbool)
    }
    
    public var iconImageURL: URL? {
        if let ptr = TISGetInputSourceProperty(inputSource, kTISPropertyIconImageURL) {
            return unsafeBitCast(ptr, to: CFURL.self) as URL
        } else {
            return nil
        }
    }
    
    public var iconImage: NSImage? {
        guard let url = iconImageURL else {
            return nil
        }
        
        if let image = NSImage(contentsOf: url) {
            return image
        }
        
        if url.pathExtension != "png" {
            return nil
        }
        
        let tiffurl = URL(fileURLWithPath: url.deletingPathExtension().path + ".tiff")
        print("orig url = \(url), tiff = \(tiffurl)")
        if let image = NSImage(contentsOf: tiffurl) {
            return image
        }
        return nil
    }
    
    private let inputableTypes = [kTISTypeKeyboardLayout as String,
                                  kTISTypeKeyboardInputMode as String,
                                  kTISTypeKeyboardInputMethodModeEnabled as String]
    
    public var isInputable: Bool {
        return inputableTypes.contains(type)
    }
    
    public func activate() {
        TISSelectInputSource(inputSource)
    }
}
