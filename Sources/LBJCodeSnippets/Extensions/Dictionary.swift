extension Dictionary {
    public func withAllValuesFrom(_ other: Dictionary) -> Dictionary {
        var result = self
        other.forEach { result[$0] = $1 }
        return result
    }
}
