import SwiftUI
import Foundation
import CryptoKit

// MARK: - GroupSchedule
struct GroupSchedule: Codable {
    let group: String
    let schedule: [String: DaySchedule]
    
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int?
        init?(intValue: Int) { nil }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        guard let groupKey = DynamicCodingKeys(stringValue: "group") else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Group key not found"))
        }
        self.group = try container.decode(String.self, forKey: groupKey)
        
        var schedule = [String: DaySchedule]()
        for key in container.allKeys where key.stringValue != "group" {
            let date = key.stringValue
            let daySchedule = try container.decode(DaySchedule.self, forKey: key)
            schedule[date] = daySchedule
        }
        self.schedule = schedule
    }
}

// MARK: - DaySchedule
struct DaySchedule: Codable {
    let day: String
    let pairs: [String: [String: Pair]]
}

// MARK: - Pair
struct Pair: Codable {
    let timeStart: String
    let timeEnd: String
    let lector: [String: String]
    let type: [String: Int]
    let room: [String: String]
    let lms: String
    let teams: String
    let other: String
    
    enum CodingKeys: String, CodingKey {
        case timeStart = "time_start"
        case timeEnd = "time_end"
        case lector, type, room, lms, teams, other
    }
}

extension String {
    func md5Hash() -> String {
        let data = Data(self.utf8)
        let hash = Insecure.MD5.hash(data: data)
        print(hash.map { String(format: "%02hhx", $0) }.joined())
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
}

//{
//    "group": "М8О-101БВ-24",
//    "03.09.2024": {
//        "day": "Вт",
//        "pairs": {
//            "13:00:00": {
//                "Математический анализ": {
//                    "time_start": "13:00:00",
//                    "time_end": "14:30:00",
//                    "lector": {
//                        "00000000-0000-0000-0000-000000000000": ""
//                    },
//                    "type": {
//                        "ЛК": 1
//                    },
//                    "room": {
//                        "6d020601-0b8d-11e0-bf99-003048ccec9b": "ГУК Б-460"
//                    },
//                    "lms": "",
//                    "teams": "",
//                    "other": ""
//                }
//            },
//            "14:45:00": {
//                "Математический анализ": {
//                    "time_start": "14:45:00",
//                    "time_end": "16:15:00",
//                    "lector": {
//                        "00000000-0000-0000-0000-000000000000": ""
//                    },
//                    "type": {
//                        "ЛК": 1
//                    },
//                    "room": {
//                        "6d020601-0b8d-11e0-bf99-003048ccec9b": "ГУК Б-460"
//                    },
//                    "lms": "",
//                    "teams": "",
//                    "other": ""
//                }
//            }
//        }
//    }
//}

