//
//  ConnectivityLink.swift
//  Hyperconnectivity
//
//  Created by Bruno Miguns on 13/10/2022.
//

import Foundation

public enum ConnectivityLink {
    case url(URL)
    case request(URLRequest)
}

extension URLSession {
    func dataTaskPublisher(for link: ConnectivityLink) -> URLSession.DataTaskPublisher {
        switch link {
        case .url(let url):
            return dataTaskPublisher(for: url)
        case .request(let urlRequest):
            return dataTaskPublisher(for: urlRequest)
        }
    }
}
