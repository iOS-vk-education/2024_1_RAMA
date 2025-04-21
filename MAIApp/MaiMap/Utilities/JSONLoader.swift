import Foundation

class JSONLoader {
    static func load<T: Decodable>(_ filename: String) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
//            print("Файл \(filename) не найден в бандле")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            print("Ошибка в данных файла \(filename):", context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Отсутствует ключ '\(key)' в \(filename):", context)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Несоответствие типа \(type) в \(filename):", context)
        } catch {
            print("Неизвестная ошибка при загрузке \(filename):", error)
        }
        return nil
    }
}



