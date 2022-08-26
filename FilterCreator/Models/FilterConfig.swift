//
//  FilterConfig.swift
//  FilterCreator
//
//  Created by Jack Smith on 8/25/22.
//

import Foundation

struct FilterConfig : Codable, Identifiable {
    var id: String {
        return name
    }
    
    let name: String
    
    let instant: Bool
    let fade: Bool
    let transfer: Bool
    let process: Bool
    
    let exposure: Float
    let contrast: Float
    let brightness: Float
    let saturation: Float
    let highlight: Float
    let shadow: Float
    let temp: Float
    let tint: Float
    let sharpness: Float
    let vibrance: Float
    let rr: Float
    let rg: Float
    let rb: Float
    let gr: Float
    let gg: Float
    let gb: Float
    let br: Float
    let bg: Float
    let bb: Float
}
