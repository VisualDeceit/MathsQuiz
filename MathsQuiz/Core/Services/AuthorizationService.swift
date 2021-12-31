//
//  AuthorizationService.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 31.12.2021.
//

import Foundation
import FirebaseAuth

protocol AuthorizationProtocol: AnyObject {
    var currentUser: User? { get }
    
    func createUser(with email: String,
                    password: String,
                    completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func signIn(with credentials: Credentials,
                completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func signIn(with credentials: AuthCredential,
                completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func signIn(with credentials: OAuthCredential,
                completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func signOut(completion: @escaping (Error?) -> Void)
    func updatePassword(to password: String, completion: @escaping (Error?) -> Void)
    func sendPasswordReset(to email: String, completion: @escaping (Error?) -> Void)
    func deleteCurrentUser(_ completion: @escaping (Error?) -> Void)
}

class AuthorizationService: AuthorizationProtocol {
    
    var currentUser: User? {
        return Auth.auth().currentUser
    }
    
    func createUser(with email: String,
                    password: String,
                    completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (loginResult, error) in
            if let loginResult = loginResult {
                completion(.success(loginResult))
                return
            }
            if let error = error {
                completion(.failure(error))
                return
            }
        }
    }
        
    func signIn(with credentials: AuthCredential,
                completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(with: credentials) { (loginResult, error) in
            if let loginResult = loginResult {
                completion(.success(loginResult))
                return
            }
            if let error = error {
                completion(.failure(error))
                return
            }
        }
    }
    
    func signIn(with credentials: OAuthCredential,
                completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(with: credentials) { (loginResult, error) in
            if let loginResult = loginResult {
                completion(.success(loginResult))
                return
            }
            if let error = error {
                completion(.failure(error))
                return
            }
        }
    }
    
    func signIn(with credentials: Credentials,
                completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: credentials.email,
                           password: credentials.password) { (loginResult, error) in
            if let loginResult = loginResult {
                completion(.success(loginResult))
                return
            }
            if let error = error {
                completion(.failure(error))
                return
            }
        }
    }
    
    func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
        } catch let error {
            completion(error)
        }
    }
    
    func updatePassword(to password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().currentUser?.updatePassword(to: password, completion: completion)
    }
    
    func sendPasswordReset(to email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
    
    func deleteCurrentUser(_ completion: @escaping (Error?) -> Void) {
        self.currentUser?.delete(completion: completion)
    }
}
