//
//  Colors.swift
//  pokemon_homework
//
//  Created by Field Employee on 11/1/20.
//

import UIKit

enum Type_Colors: String {
    case grass
    case fire
    case normal
    case ice
    case dragon
    case bug
    case electric
    case psychic
    case fighting
    case water
    case ground
    case fairy
    case rock
    case ghost
    case poison
    case flying
    case steel
    
    func get_color() -> UIColor {
        switch self {
        case .grass:
            return RGB_to_UIColor(red: 82, green: 253, blue: 170)
        case .fire:
            return RGB_to_UIColor(red: 233, green: 129, blue: 221)
        case .normal:
            return RGB_to_UIColor(red: 24, green: 134, blue: 183)
        case .ice:
            return RGB_to_UIColor(red: 150, green: 199, blue: 203)
        case .dragon:
            return RGB_to_UIColor(red: 35, green: 139, blue: 44)
        case .bug:
            return RGB_to_UIColor(red: 234, green: 39, blue: 9)
        case .electric:
            return RGB_to_UIColor(red: 213, green: 178, blue: 5)
        case .psychic:
            return RGB_to_UIColor(red: 66, green: 26, blue: 0)
        case .fighting:
            return RGB_to_UIColor(red: 238, green: 168, blue: 111)
        case .water:
            return RGB_to_UIColor(red: 175, green: 249, blue: 209)
        case .ground:
            return RGB_to_UIColor(red: 89, green: 94, blue: 56)
        case .fairy:
            return RGB_to_UIColor(red: 229, green: 228, blue: 217)
        case .rock:
            return RGB_to_UIColor(red: 253, green: 248, blue: 220)
        case .ghost:
            return RGB_to_UIColor(red: 0, green: 236, blue: 194)
        case .poison:
            return RGB_to_UIColor(red: 229, green: 57, blue: 169)
        case .flying:
            return RGB_to_UIColor(red: 215, green: 203, blue: 43)
        case .steel:
            return RGB_to_UIColor(red: 70, green: 69, blue: 89)
        }
    }
}

func RGB_to_UIColor(red: Int, green: Int, blue: Int) -> UIColor {
    let cg_red = CGFloat(Double(red) / 255.0)
    let cg_green = CGFloat(Double(green) / 255.0)
    let cg_blue = CGFloat(Double(blue) / 255.0)
    
    let swift_color = UIColor(red: cg_red, green: cg_green, blue: cg_blue, alpha: CGFloat(1.0))
    return swift_color
}

