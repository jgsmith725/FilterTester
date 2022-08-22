//
//  FilterManager.swift
//  FilterTester
//
//  Created by Jack Smith on 8/21/22.
//

import Foundation
import UIKit
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

final class FilterManager: ObservableObject {
    static let shared = FilterManager()
    
    let exposureFilter = CIFilter.exposureAdjust()
    static let exposureDef = PropDefinition(name: "exposure", min: -10, max: 10, defaultValue: 0)
    
    let colorFilter = CIFilter.colorControls()
    static let contrastDef = PropDefinition(name: "contrast", min: 0.25, max: 4, defaultValue: 1)
    static let brightnessDef = PropDefinition(name: "brightness", min: -1, max: 1, defaultValue: 0)
    static let saturationDef = PropDefinition(name: "saturation", min: 0, max: 2, defaultValue: 1)
    
    let highlightFilter = CIFilter.highlightShadowAdjust()
    static let highlightDef = PropDefinition(name: "highlight", min: 0, max: 1, defaultValue: 1)
    static let shadowDef = PropDefinition(name: "shadow", min: -1, max: 1, defaultValue: 0)
    
    let colorMonochromeFilter = CIFilter.colorMonochrome()
    let tempAndTintFilter = CIFilter.temperatureAndTint()
    static let tempDef = PropDefinition(name: "temp", min: -3000, max: 3000, defaultValue: 0)
    static let tintDef = PropDefinition(name: "tint", min: -100, max: 100, defaultValue: 0)
    
    let vibranceFilter = CIFilter.vibrance()
    static let vibranceDef = PropDefinition(name: "vibrance", min: -1, max: 1, defaultValue: 0)
//    static let photoEffectChrome = CIFilter.photoEffectChrome()
//    static let sharpenLuminescance = CIFilter.sharpenLuminance()
//    static let hardLightBlend = CIFilter.hardLightBlendMode()
    let colorMatrix = CIFilter.colorMatrix()
    static let rrDef = PropDefinition(name: "rr", min: 0, max: 1, defaultValue: 1)
    static let rgDef = PropDefinition(name: "rg", min: 0, max: 1, defaultValue: 0)
    static let rbDef = PropDefinition(name: "rb", min: 0, max: 1, defaultValue: 0)
    static let grDef = PropDefinition(name: "gr", min: 0, max: 1, defaultValue: 0)
    static let ggDef = PropDefinition(name: "gg", min: 0, max: 1, defaultValue: 1)
    static let gbDef = PropDefinition(name: "gb", min: 0, max: 1, defaultValue: 0)
    static let brDef = PropDefinition(name: "br", min: 0, max: 1, defaultValue: 0)
    static let bgDef = PropDefinition(name: "bg", min: 0, max: 1, defaultValue: 0)
    static let bbDef = PropDefinition(name: "bb", min: 0, max: 1, defaultValue: 1)
    
    let photoEffectInstant = CIFilter.photoEffectInstant()
    let photoEffectFade = CIFilter.photoEffectFade()
    let photoEffectNoir = CIFilter.photoEffectNoir()
    let randomGenerator = CIFilter.randomGenerator()
    let sourceOverCompositor = CIFilter.sourceOverCompositing()
    let multiplyCompositing = CIFilter.multiplyCompositing()
    
    
    @Published var exposure: Float = FilterManager.exposureDef.defaultValue //-10 to 10
    @Published var contrast: Float = FilterManager.contrastDef.defaultValue //.25 to 4, 1 is center
    @Published var brightness: Float = FilterManager.brightnessDef.defaultValue //-10 to 10
    @Published var saturation: Float = FilterManager.saturationDef.defaultValue //-10 to 10
    @Published var highlight: Float = FilterManager.highlightDef.defaultValue
    @Published var shadow: Float = FilterManager.shadowDef.defaultValue
    @Published var temp: Float = FilterManager.tempDef.defaultValue
    @Published var tint: Float = FilterManager.tintDef.defaultValue
    @Published var vibrance: Float = FilterManager.vibranceDef.defaultValue
    @Published var rr: Float = FilterManager.rrDef.defaultValue
    @Published var rg: Float = FilterManager.rgDef.defaultValue
    @Published var rb: Float = FilterManager.rbDef.defaultValue
    @Published var gr: Float = FilterManager.grDef.defaultValue
    @Published var gg: Float = FilterManager.ggDef.defaultValue
    @Published var gb: Float = FilterManager.gbDef.defaultValue
    @Published var br: Float = FilterManager.brDef.defaultValue
    @Published var bg: Float = FilterManager.bgDef.defaultValue
    @Published var bb: Float = FilterManager.bbDef.defaultValue
    
    
//    @Published var highlightAmount: Float = FilterManager.exposureDefault
//    @Published var shadowAmount: Float = FilterManager.exposureDefault
//    @Published var temp: Float = FilterManager.exposureDefault
//    @Published var tint: Float = FilterManager.exposureDefault
//    @Published var vibrance: Float = FilterManager.exposureDefault
    
    
    func resetToDefaults() {
        exposure = FilterManager.exposureDef.defaultValue
        contrast = FilterManager.contrastDef.defaultValue
        brightness = FilterManager.brightnessDef.defaultValue
        saturation = FilterManager.saturationDef.defaultValue
        highlight = FilterManager.highlightDef.defaultValue
        shadow = FilterManager.shadowDef.defaultValue
        temp = FilterManager.tempDef.defaultValue
        tint = FilterManager.tintDef.defaultValue
        vibrance = FilterManager.vibranceDef.defaultValue
        rr = FilterManager.rrDef.defaultValue
        rg = FilterManager.rgDef.defaultValue
        rb = FilterManager.rbDef.defaultValue
        gr = FilterManager.grDef.defaultValue
        gg = FilterManager.ggDef.defaultValue
        gb = FilterManager.gbDef.defaultValue
        br = FilterManager.brDef.defaultValue
        bg = FilterManager.bgDef.defaultValue
        bb = FilterManager.bbDef.defaultValue
    }
    
    func resetToCurrentVintageFilter() {
        exposure = Float(0.2)
        contrast = Float(0.93)
        brightness = Float(0)
        saturation = Float(1.05)
        highlight = Float(1)
        shadow = Float(-0.15)
        temp = Float(-30)
        tint = Float(25)
        vibrance = Float(0.05)
        rr = Float(1)
        rg = Float(0)
        rb = Float(0)
        gr = Float(0.2)
        gg = Float(1)
        gb = Float(0.2)
        br = Float(0)
        bg = Float(0)
        bb = Float(1)
        
    }
    
    func applyFilter(image: UIImage) -> UIImage {
        let context = CIContext()
        let beginImage = CIImage(image: image)

        photoEffectFade.inputImage = beginImage
        //photoEffectInstant.inputImage = photoEffectFade.outputImage
        
        //exposureFilter.inputImage = photoEffectFade.outputImage
        exposureFilter.inputImage = beginImage
        exposureFilter.ev = exposure //-10 to 10
        
        colorFilter.inputImage = exposureFilter.outputImage
        colorFilter.contrast = contrast //.25 to 4, 1 is center
        colorFilter.brightness = brightness //-1 to 1
        colorFilter.saturation = saturation //0 to 2
        
        
        highlightFilter.inputImage = colorFilter.outputImage
        highlightFilter.highlightAmount = highlight //0 to 1
        highlightFilter.shadowAmount = shadow //-1 to 1
        //highlightFilter.radius
        
        tempAndTintFilter.inputImage = highlightFilter.outputImage // temp down, tint up
        tempAndTintFilter.neutral = CIVector(x: CGFloat(temp) + 6500, y: CGFloat(tint))
        tempAndTintFilter.targetNeutral = CIVector(x: 6500, y: 0)

        vibranceFilter.inputImage = tempAndTintFilter.outputImage
        vibranceFilter.amount = vibrance //-1 to 1

//        sharpenLuminescance.inputImage = vibranceFilter.outputImage
//        sharpenLuminescance.sharpness = Float(0.95) //0 to 2
        
        //hardLightBlend.inputImage = sharpenLuminescance.outputImage
        
        colorMatrix.inputImage = vibranceFilter.outputImage
        colorMatrix.rVector = CIVector(x:  CGFloat(rr), y:  CGFloat(rg), z:  CGFloat(rb), w: 0) //turn oranges slightly to red
        colorMatrix.gVector = CIVector(x:  CGFloat(gr), y:  CGFloat(gg), z:  CGFloat(gb), w: 0) //add green
        colorMatrix.bVector = CIVector(x: CGFloat(br), y: CGFloat(bg), z: CGFloat(bb), w: 0)
        //let noisyImage = addNoise(image: colorMatrix.outputImage)
        let noisyImage = colorMatrix.outputImage

        
        guard let newImage = noisyImage else {
            return image //return the input
        }
    

        if let cgimg = context.createCGImage(newImage, from: newImage.extent){
            let uiImage = UIImage(cgImage: cgimg, scale: 1, orientation: .right)
            return uiImage
        }
        return image //return the input
    }
    
    private func addNoise(image: CIImage?) -> CIImage? {
        guard let image = image else { return nil }
        let whitenVector = CIVector(x: 0, y: 1, z: 0, w: 0)
        let fineGrain = CIVector(x:0, y:0.005, z:0, w:0)
        let zeroVector = CIVector(x: 0, y: 0, z: 0, w: 0)
        
        let noise = randomGenerator.outputImage
        colorMatrix.inputImage = noise
        colorMatrix.rVector = whitenVector
        colorMatrix.gVector = whitenVector
        colorMatrix.bVector = whitenVector
        colorMatrix.aVector = fineGrain
        colorMatrix.biasVector = zeroVector
        
        let whiteSpecks = colorMatrix.outputImage
        
        sourceOverCompositor.inputImage = whiteSpecks
        sourceOverCompositor.backgroundImage = image
        var combinedImage = sourceOverCompositor.outputImage
        combinedImage = combinedImage?.cropped(to: image.extent)
        return combinedImage
    }
}
