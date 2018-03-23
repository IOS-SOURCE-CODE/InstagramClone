//
//  TranslationLayerType.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation


typealias JSONDictionary = [String: Any]

protocol JSONDecodable {
   init?(dictionary: JSONDictionary)
}

protocol TranslationLayerType {
   func decodes<E: Decodable>(data: Data) -> [E]
   func decode<E: Decodable>(data: Data) -> E?
}


class TranslationLayer: TranslationLayerType {
   
   func decodes<E: Decodable>(data: Data) -> [E] {
      do {
         guard let json = try? JSONDecoder().decode([E].self, from: data)
            else { throw APIClientError.CouldNotDecodeJSON  }
         return json
      } catch (let error) {
         debugPrint(error)
      }
      return []
   }
   
   func decode<E: Decodable>(data: Data) -> E? {
      do {
        guard let jsonData = try? JSONDecoder().decode(E.self, from: data) else { throw APIClientError.CouldNotDecodeJSON }
         return jsonData
      } catch (let error) {
         debugPrint(error)
      }
      return nil
   }
   
   
}
