//
//  File.swift
//  
//
//  Created by apple on 31/08/24.
//

import Foundation
import Combine
import Alamofire

struct User {
    var firsName: String
}

protocol ApiProtocol {
    func fetchData(url: String) -> AnyPublisher<User, AFError>
}

class NetworkService: ApiProtocol {
    func fetchData(url: String) -> AnyPublisher<User, AFError> {
        guard let url = URL(string: url), let request = URLRequest(url: url) else {
            return
            
        }
        
        AF.request(request, method: .get)
            .validate()
            .publishDecodable(type: User.self)
            .value()
            .receive(on: DispatchQueue.main)
    }
}

@available(iOS 13.0, *)
public class ViewModel: ObservableObject  {
    
    var delegate: ApiProtocol
    var anyCancellable: Set<AnyCancellable> = .init()
    
    public init(delegate: ApiProtocol) {
        self.delegate = delegate
    }
    
    public func fetchDetails() -> AnyPublisher<User, AFError> {
        delegate?.fetchData(url: "https://ipapi.co/json/")
            .map { response in
                return response
            }.eraseToAnyPublisher()
    }
    
}
