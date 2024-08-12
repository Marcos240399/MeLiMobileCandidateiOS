//
//  NumberUtils.swift
//  MeLiMobileCandidate
//
//  Created by Marcos Bazzano on 12/8/24.
//

import Foundation
struct MathUtils {
    static func RemoveTrailingZeroes(from number: Double) -> String{
        var stringifiedInput = String(format: "%.2f", number)
        if((stringifiedInput.contains(where: { Character in
            Character == "."
        }))){
            let split = stringifiedInput.components(separatedBy: ".")
            if(split[1].allSatisfy({ Character in
                Character == "0"
            })){
                stringifiedInput = split[0]
            }
        }
        return stringifiedInput
    }
}
