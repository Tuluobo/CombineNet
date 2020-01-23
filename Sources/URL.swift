//
//  URL.swift
//  Example
//
//  Created by Hao Wang on 2020/1/23.
//  Copyright © 2020 Tuluobo. All rights reserved.
//

import Foundation

extension URL {
    func appendingQueryParameters(_ parametersDictionary: [String: String]) -> URL {
        if parametersDictionary.count <= 0 {
            return self
        }
        let URLString: String
        if (self.absoluteString.contains("?")) {
            URLString = String(format: "%@&%@", self.absoluteString, parametersDictionary.urlQuery())
        } else {
            URLString = String(format: "%@?%@", self.absoluteString, parametersDictionary.urlQuery())
        }
        return URL(string: URLString)!
    }
}

extension Dictionary {
    func urlQuery() -> String {
        var querys: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            querys.append(part as String)
        }
        return querys.joined(separator: "&")
    }
}
