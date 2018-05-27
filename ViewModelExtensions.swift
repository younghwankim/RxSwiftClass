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

class ViewModel: ViewModelOutputExtensionCompatible, ViewModelInputExtensionCompatible {}

let vm = ViewModel()
vm.input
vm.output