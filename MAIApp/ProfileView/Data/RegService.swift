//
//  RegService.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 09.05.2025.
//

import Foundation
import Firebase
import FirebaseAuth

class RegService {
    
    func createNewUser(user: UserData, completion: @escaping (Result<Bool, Error>) -> Void){
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
            guard let self = self else { return }
            guard error == nil else {
                print("Error creating user: \(error)")
                
                completion(.failure(error!))
                return
            }
            
            result?.user.sendEmailVerification()
            signOut()
            completion(.success(true))
            
            
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
        }
        
        catch {
                print(error)
        }
    }
    
}
