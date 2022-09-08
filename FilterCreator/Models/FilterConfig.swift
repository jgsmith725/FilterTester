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
    let noir: Bool
    
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
    
    enum CodingKeys: String, CodingKey {
        case name
        
        case instant
        case fade
        case transfer
        case process
        case noir
        
        case exposure
        case contrast
        case brightness
        case saturation
        case highlight
        case shadow
        case temp
        case tint
        case sharpness
        case vibrance
        case rr
        case rg
        case rb
        case gr
        case gg
        case gb
        case br
        case bg
        case bb
    }
    
    init(name: String,
         instant: Bool,
    fade: Bool,
    transfer: Bool,
    process: Bool,
    noir: Bool,
    
    exposure: Float,
    contrast: Float,
    brightness: Float,
    saturation: Float,
         highlight: Float,
    shadow: Float,
    temp: Float,
    tint: Float,
    sharpness: Float,
    vibrance: Float,
    rr: Float,
    rg: Float,
    rb: Float,
    gr: Float,
    gg: Float,
    gb: Float,
    br: Float,
    bg: Float,
         bb: Float) {
        
        self.name = name

        self.instant = instant
        self.fade = fade
        self.transfer = transfer
        self.process = process
        self.noir = noir
        
        self.exposure = exposure
        self.contrast = contrast
        self.brightness = brightness
        self.saturation = saturation
        self.highlight = highlight
        self.shadow = shadow
        self.temp = temp
        self.tint = tint
        self.sharpness = sharpness
        self.vibrance = vibrance
        self.rr = rr
        self.rg = rg
        self.rb = rb
        self.gr = gr
        self.gg = gg
        self.gb = gb
        self.br = br
        self.bg = bg
        self.bb = bb
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        
        instant = try values.decode(Bool.self, forKey: .instant)
        fade = try values.decode(Bool.self, forKey: .fade)
        transfer = try values.decode(Bool.self, forKey: .transfer)
        process = try values.decode(Bool.self, forKey: .process)
        noir = (try? values.decodeIfPresent(Bool.self, forKey: .noir)) ?? false
        
        exposure = try values.decode(Float.self, forKey: .exposure)
        contrast = try values.decode(Float.self, forKey: .contrast)
        brightness = try values.decode(Float.self, forKey: .brightness)
        saturation = try values.decode(Float.self, forKey: .saturation)
        highlight = try values.decode(Float.self, forKey: .highlight)
        shadow = try values.decode(Float.self, forKey: .shadow)
        temp = try values.decode(Float.self, forKey: .temp)
        tint = try values.decode(Float.self, forKey: .tint)
        sharpness = try values.decode(Float.self, forKey: .sharpness)
        vibrance = try values.decode(Float.self, forKey: .vibrance)
        rr = try values.decode(Float.self, forKey: .rr)
        rg = try values.decode(Float.self, forKey: .rg)
        rb = try values.decode(Float.self, forKey: .rb)
        gr = try values.decode(Float.self, forKey: .gr)
        gg = try values.decode(Float.self, forKey: .gg)
        gb = try values.decode(Float.self, forKey: .gb)
        br = try values.decode(Float.self, forKey: .br)
        bg = try values.decode(Float.self, forKey: .bg)
        bb = try values.decode(Float.self, forKey: .bb)
    }
}
