//
//  String+Extension.swift
//  ReactiveStudy
//
//  Created by Young Kim on 2018-05-04.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import Foundation
import UIKit

//Shared Code for CIBC
public struct CIBCExtension<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol CIBCExtensionCompatible {
    associatedtype Compatible
    var cibc: CIBCExtension<Compatible> { get set }
    static var cibc: CIBCExtension<Compatible>.Type { get set }
}

public extension CIBCExtensionCompatible {
    public var cibc: CIBCExtension<Self> {
        get { return CIBCExtension(self) }
        set { // this enables using Extension to "mutate" base object
        }
    }
    public static var cibc: CIBCExtension<Self>.Type {
        get { return CIBCExtension<Self>.self }
        set { // this enables using Extension to "mutate" base type
        }
    }
}

//Shared Code for SIMPLII
public struct SIMPLIIExtension<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol SIMPLIIExtensionCompatible {
    associatedtype Compatible
    var simplii: SIMPLIIExtension<Compatible> { get set }
    static var simplii: SIMPLIIExtension<Compatible>.Type { get set }
}

public extension SIMPLIIExtensionCompatible {
    public var simplii: SIMPLIIExtension<Self> {
        get { return SIMPLIIExtension(self) }
        set { // this enables using Extension to "mutate" base object
        }
    }
    public static var simplii: SIMPLIIExtension<Self>.Type {
        get { return SIMPLIIExtension<Self>.self }
        set { // this enables using Extension to "mutate" base type
        }
    }
}

//CIBC : String Extension
public extension CIBCExtension where Base == String {
    public func greet() -> String {
        return "Hello, \(base)"
    }
}

//SIMPLII : String Extension
extension SIMPLIIExtension where Base == String {
    func greet() -> String {
        return "Hi, \(base)"
    }
}

extension String: CIBCExtensionCompatible, SIMPLIIExtensionCompatible {
    
}

//CIBC : ViewController Extension
extension CIBCExtension where Base == ViewController {
    func business() -> String {
        return "CIBC \(base.title ?? ""): Banking that fits your life."
    }
}

//SIMPLII : ViewController Extension
extension SIMPLIIExtension where Base == ViewController {
    func business() -> String {
        return "SIMPLII \(base.title ?? ""): Banking that's simple and easy, just the way you want."
    }
}

extension ViewController: CIBCExtensionCompatible, SIMPLIIExtensionCompatible {

}

