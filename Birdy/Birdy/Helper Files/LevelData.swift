//
//  LevelData.swift
//  Birdy
//
//  Created by Леонід Шевченко on 08.04.2022.
//

import Foundation

struct LevelData {
    let birds: [String]
    
    init?(level: Int) {
        guard let levelDictionary = Levels.levelsDictionary["Level\(level)"] as? [String: Any] else {
            return nil
        }
        guard let birds = levelDictionary["Birds"] as? [String] else {
            return nil
        }
        self.birds = birds
    }
}
