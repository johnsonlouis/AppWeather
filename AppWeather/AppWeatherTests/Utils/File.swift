//
//  File.swift
//  AppWeatherTests
//
//  Created by Johnson-Riche Louis on 26/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import Foundation

public class File {

    public static func read(filename: String) -> Data? {
        guard !filename.isEmpty,
            let path = Bundle(for: self).path(forResource: filename, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: []) else {
                return nil
        }
        return data
    }
}

