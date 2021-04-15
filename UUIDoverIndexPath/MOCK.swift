//
//  MOCK.swift
//  UUIDoverIndexPath
//
//  Created by Rafał P. on 07/04/2021.
//  Copyright © 2021 Rafał P. All rights reserved.
//

import Foundation

final class MOCK {

    static func getPepe() -> PepesModel {
        let pepes = mock().decodeJson(for: [Pepe].self)!
        return PepesModel(pepes: pepes.map({PepeDTO(pepe: $0)}))
    }
    
    private static func mock() -> Data {
          let json =
"""
[
        {
            "name": "pepe1",
        },
        {
            "name": "pepe3",
        },
        {
            "name": "pepe2",
        },
        {
            "name": "pepe3",
        },
        {
            "name": "pepe2",
        },
        {
            "name": "pepe3",
        },
]
"""
          return json.data(using: .utf8)!
      }
}

struct PepesModel {
    var pepes: [PepeDTO]
}

struct PepeDTO {
    let id = UUID()
    let pepe: Pepe
}

struct Pepe: Decodable {
    let name: String
}

extension Data {
    func decodeJson<T:Decodable>(for type: T.Type) -> T? {
        var model: T?
        do {
            model = try JSONDecoder().decode(T.self, from: self)
        } catch  {
            print("[JSON PARSING ERROR] \(error.localizedDescription)")
        }
        
        return model
    }
}
