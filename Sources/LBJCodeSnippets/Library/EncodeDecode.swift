public func encode<T: Encodable>(_ object: T) -> String? {
  guard let data = try? JSONEncoder().encode(object) else { return nil }
  return String(data: data, encoding: .utf8)
}

public func decode<T: Decodable>(from string: String) -> T? {
  try? JSONDecoder().decode(T.self, from: Data(string.utf8))
}

public func decode<T: Codable, Root: Any>(from keyPath: KeyPath<Root, String?>, in object: Root) -> T? {
  guard let jsonString = object[keyPath: keyPath] else {
    return nil
  }

  guard let jsonData = jsonString.data(using: .utf8) else {
    return nil
  }

  return try? JSONDecoder().decode(T.self, from: jsonData)
}
