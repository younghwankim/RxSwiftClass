//
//  ExtensionCompatible.swift
//  ReactiveStudy
//
//  Created by Young Kim on 2018-05-06.
//  Copyright © 2018 Young Kim. All rights reserved.
//
// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html
// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Declarations.html#//apple_ref/doc/uid/TP40014097-CH34-XID_543
import Foundation

public struct Extension<Base> {
    public let base: Base // Generic Type (Base)
    public init(_ base: Base) {
        self.base = base
    }
}

//  Associated Types
//
//  When defining a protocol, it’s sometimes useful to declare one or more associated types as part of the protocol’s definition.
//  An associated type gives a placeholder name to a type that is used as part of the protocol. The actual type to use for
//  that associated type isn’t specified until the protocol is adopted. Associated types are specified with the associatedtype keyword.

public protocol ExtensionCompatible {
    associatedtype Compatible
    var ex: Extension<Compatible> { get }
}

//  Protocol Associated Type Declaration
//
//  Protocols declare associated types using the associatedtype keyword. An associated type provides an alias for a type that is used
//    as part of a protocol’s declaration. Associated types are similar to type parameters in generic parameter clauses, but they’re
//    associated with Self in the protocol in which they’re declared. In that context, Self refers to the eventual type that conforms
//    to the protocol. For more information and examples, see Associated Types.

// Generic Conforming
public extension ExtensionCompatible {
    //Self refers to the eventual type that conforms to the protocol
    public var ex: Extension<Self> {
        get {
            return Extension(self)
        }
    }
}

extension Int: ExtensionCompatible { }

public extension Extension where Base == Int {
    public var cube: Int {
        return base * base * base
    }
}

//MARK: Extension Two

public struct ExtensionTwo<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ExtensionTwoCompatible {
    associatedtype Compatible
    var ext: ExtensionTwo<Compatible> { get set }
    static var ext: ExtensionTwo<Compatible>.Type
    { get set }
}

public extension ExtensionTwoCompatible {
    public var ext: ExtensionTwo<Self> {
        get {
            return ExtensionTwo(self)
        }
        set {
            // this enables using Extension to "mutate" base object
        }
    }
    public static var ext: ExtensionTwo<Self>.Type {
        get {
            return ExtensionTwo<Self>.self
        }
        set {
            // this enables using Extension to "mutate" base type
        }
    }
}

extension Int: ExtensionTwoCompatible { }

public extension ExtensionTwo where Base == Int {
    public var cube: Int {
        return base * base * base
    }
    public static var almostMax: Int {
        return Int.max - 1
    }
}



public struct ViewModelInputExtension<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ViewModelInputExtensionCompatible {
    associatedtype Compatible
    var input: ViewModelInputExtension<Compatible> { get set }
    static var input: ViewModelInputExtension<Compatible>.Type { get set }
}

public extension ViewModelInputExtensionCompatible {
    public var input: ViewModelInputExtension<Self> {
        get {
            return ViewModelInputExtension(self)
        }
        set {
            // this enables using Extension to "mutate" base object
        }
    }
    public static var input: ViewModelInputExtension<Self>.Type {
        get {
            return ViewModelInputExtension<Self>.self
        }
        set {
            // this enables using Extension to "mutate" base type
        }
    }
}

public struct ViewModelOutputExtension<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ViewModelOutputExtensionCompatible {
    associatedtype Compatible
    var output: ViewModelOutputExtension<Compatible> { get set }
    static var output: ViewModelOutputExtension<Compatible>.Type { get set }
}

public extension ViewModelOutputExtensionCompatible {
    public var output: ViewModelOutputExtension<Self> {
        get {
            return ViewModelOutputExtension(self)
        }
        set {
            // this enables using Extension to "mutate" base object
        }
    }
    public static var output: ViewModelOutputExtension<Self>.Type {
        get {
            return ViewModelOutputExtension<Self>.self
        }
        set {
            // this enables using Extension to "mutate" base type
        }
    }
}
