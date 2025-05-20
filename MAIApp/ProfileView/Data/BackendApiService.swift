//
//  ProfileData.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 10.03.2025.
//

import Foundation
import SwiftUI


// MARK: - Data Layer
class APIService {
    
    @EnvironmentObject var profileVM: ProfileViewModel
    
    private let baseURL = "https://mai-students.ru/api/"
//    private let baseUrl = "http://127.0.0.1:8000/api"


    func register(email: String, password: String, completion: @escaping (Result<TokenInfo, Error>) -> Void) {
        // Создаем URL для запроса
        guard let url = URL(string: "\(baseURL)/v1/auth/register") else {
            completion(.failure(NSError(domain: "APIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Неверный URL"])))
            return
        }
        
        let parameters = ["email": email, "password": password]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Отправляемые данные: \(jsonString)")
            }
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка запроса: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            // Выводим информацию о запросе для отладки
            if let httpResponse = response as? HTTPURLResponse {
                print("Код ответа: \(httpResponse.statusCode)")
            }
            
            // Выводим тело ответа для отладки
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Тело ответа: \(responseString)")
            }
            
            // Проверяем статус ответа
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "APIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Неверный ответ"])))
                return
            }
            
            // Обрабатываем ответ в зависимости от статуса
            if (200...299).contains(httpResponse.statusCode) {
                // Успешный ответ
                if let data = data {
                    do {
                        // Пытаемся распарсить JSON в TokenInfo
                        let tokenInfo = try JSONDecoder().decode(TokenInfo.self, from: data)
                        print("Успешная регистрация: \(tokenInfo)")
                        completion(.success(tokenInfo))
                    } catch {
                        print("Ошибка парсинга JSON: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NSError(domain: "APIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Пустой ответ"])))
                }
            } else if httpResponse.statusCode == 409 {
                // Пользователь уже существует
                completion(.failure(NSError(domain: "APIService", code: 409, userInfo: [NSLocalizedDescriptionKey: "Пользователь с таким email уже существует"])))
            } else {
                // Другая ошибка
                let errorMessage = "Ошибка сервера: \(httpResponse.statusCode)"
                print(errorMessage)
                
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Тело ошибки: \(responseString)")
                }
                
                completion(.failure(NSError(domain: "APIService", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
            }
        }.resume()
    }
    
    
    
    // Функция для получения информации о пользователе
    func getUserInfo(token: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/v1/auth/me") else {
            completion(.failure(NSError(domain: "APIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Неверный URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "APIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Неверный ответ"])))
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                            completion(.success(json))
                        } else {
                            completion(.failure(NSError(domain: "APIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Неверный формат ответа"])))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NSError(domain: "APIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Пустой ответ"])))
                }
            } else {
                completion(.failure(NSError(domain: "APIService", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Ошибка сервера: \(httpResponse.statusCode)"])))
            }
        }.resume()
    }
    
    func login(email: String, password: String, completion: @escaping (Result<TokenInfo, Error>) -> Void) {
        // Создаем URL для запроса
        guard let url = URL(string: "\(baseURL)/v1/auth/register") else {
            completion(.failure(NSError(domain: "APIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Неверный URL"])))
            return
        }
        
        let parameters = ["email": email, "password": password]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Отправляемые данные: \(jsonString)")
            }
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка запроса: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            // Выводим информацию о запросе для отладки
            if let httpResponse = response as? HTTPURLResponse {
                print("Код ответа: \(httpResponse.statusCode)")
            }
            
            // Выводим тело ответа для отладки
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Тело ответа: \(responseString)")
            }
            
            // Проверяем статус ответа
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "APIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Неверный ответ"])))
                return
            }
            
            // Обрабатываем ответ в зависимости от статуса
            if (200...299).contains(httpResponse.statusCode) {
                // Успешный ответ
                if let data = data {
                    do {
                        // Пытаемся распарсить JSON в TokenInfo
                        let tokenInfo = try JSONDecoder().decode(TokenInfo.self, from: data)
                        print("Успешная регистрация: \(tokenInfo)")
                        completion(.success(tokenInfo))
                    } catch {
                        print("Ошибка парсинга JSON: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NSError(domain: "APIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Пустой ответ"])))
                }
            } else if httpResponse.statusCode == 409 {
                // Пользователь уже существует
                completion(.failure(NSError(domain: "APIService", code: 409, userInfo: [NSLocalizedDescriptionKey: "Пользователь с таким email уже существует"])))
            } else {
                // Другая ошибка
                let errorMessage = "Ошибка сервера: \(httpResponse.statusCode)"
                print(errorMessage)
                
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Тело ошибки: \(responseString)")
                }
                
                completion(.failure(NSError(domain: "APIService", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
            }
        }.resume()
    }
    
    
    
}
//    func register() {
//        let parameters: [String: Any] = ["email": "IOSTEST@gmail.com", "password": "123"]
//        
//        let url = URL(string: "\(baseURL)/v1/auth/register")!
//        
//        let session = URLSession.shared
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        
//        do {
//          // convert parameters to Data and assign dictionary to httpBody of request
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
//        } catch let error {
//          print(error.localizedDescription)
//          return
//        }
//        
//        let task = session.dataTask(with: request) { data, response, error in
//            if let error = error  {
//                print("Отправка пост запроса: ОШИБКА \(error.localizedDescription)")
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode)
//            else {
//              print("Invalid Response received from the server")
//                print(data!, response!)
//              return
//            }
//            
//            
//            guard let responseData = data else {
//              print("nil Data received from the server")
//              return
//            }
//            
//            do {
//              // create json object from data or use JSONDecoder to convert to Model stuct
//              if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
//                print(jsonResponse)
//                // handle json response
//              } else {
//                print("data maybe corrupted or in wrong format")
//                throw URLError(.badServerResponse)
//              }
//            } catch let error {
//              print(error.localizedDescription)
//            }
//          }
//          // perform the task
//          task.resume()
//        }

    
    
    
    
    
    
    
    
    
    
    

//func postRequest() {
//  // declare the parameter as a dictionary that contains string as key and value combination. considering inputs are valid
//  let parameters: [String: Any] = ["id": 13, "name": "jack"]
//  // create the url with URL
//  let url = URL(string: "www.thisismylink.com/postName.php")! // change server url accordingly
//  // create the session object
//  let session = URLSession.shared
//  // now create the URLRequest object using the url object
//  var request = URLRequest(url: url)
//  request.httpMethod = "POST" //set http method as POST
//  // add headers for the request
//  request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
//  request.addValue("application/json", forHTTPHeaderField: "Accept")
//  do {
//    // convert parameters to Data and assign dictionary to httpBody of request
//    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
//  } catch let error {
//    print(error.localizedDescription)
//    return
//  }
//  // create dataTask using the session object to send data to the server
//  let task = session.dataTask(with: request) { data, response, error in
//    if let error = error {
//      print("Post Request Error: \(error.localizedDescription)")
//      return
//    }
//    // ensure there is valid response code returned from this HTTP response
//    guard let httpResponse = response as? HTTPURLResponse,
//          (200...299).contains(httpResponse.statusCode)
//    else {
//      print("Invalid Response received from the server")
//      return
//    }
//    // ensure there is data returned
//    guard let responseData = data else {
//      print("nil Data received from the server")
//      return
//    }
//    do {
//      // create json object from data or use JSONDecoder to convert to Model stuct
//      if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
//        print(jsonResponse)
//        // handle json response
//      } else {
//        print("data maybe corrupted or in wrong format")
//        throw URLError(.badServerResponse)
//      }
//    } catch let error {
//      print(error.localizedDescription)
//    }
//  }
//  // perform the task
//  task.resume()
//}


