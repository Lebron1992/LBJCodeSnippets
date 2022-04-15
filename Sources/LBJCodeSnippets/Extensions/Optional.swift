import Foundation

public protocol OptionalType {
  associatedtype Wrapped

  var optional: Wrapped? { get }
}

extension Optional: OptionalType {
  public var optional: Wrapped? {
    self
  }
}

extension OptionalType {
  public var isNil: Bool {
    self.optional == nil
  }

  public var isSome: Bool {
    !isNil
  }

  public func forceUnwrap() -> Wrapped {
    self.optional!
  }

  public func doIfSome(_ body: (Wrapped) throws -> Void) rethrows {
    if let value = self.optional {
      try body(value)
    }
  }

  public func filter(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
    if let value = self.optional, predicate(value) {
      return value
    }
    return nil
  }

  public func coalesceWith(_ value: @autoclosure () -> Wrapped) -> Wrapped {
    self.optional ?? value()
  }
}
