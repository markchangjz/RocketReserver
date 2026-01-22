//
//  AuthorizationInterceptor.swift
//  RocketReserver
//
//  Created by Mark Chang on 2026/1/22.
//

import Foundation
import Apollo
import ApolloAPI
import KeychainSwift

class AuthorizationInterceptor: ApolloInterceptor {
    public var id: String = UUID().uuidString
    
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) where Operation : GraphQLOperation {
        let keychain = KeychainSwift()
        if let token = keychain.get(LoginView.loginKeychainKey) {
            request.addHeader(name: "Authorization", value: token)
        }

        chain.proceedAsync(
            request: request,
            response: response,
            completion: completion)
    }
    
}
