import Foundation


//---------------------------------------
// Create measurements with units
let distance   = 1234.0 // meters as a double
let distMeters = Measurement(value: distance, unit: UnitLength.meters)
let distMiles  = distMeters.converted(to: .miles).value


//---------------------------------------
// Convert between different units
let tC = Measurement(value: 100, unit: UnitTemperature.celsius)
let tF = tC.converted(to: .fahrenheit)
let tK = tC.converted(to: .kelvin)


//---------------------------------------
// Create new unit types
let radiansPerSecond = UnitFrequency(
    symbol: "rps",
    converter: UnitConverterLinear(coefficient: 1/(2*3.14)))
let degreesPerSecond = UnitFrequency(
    symbol: "dps",
    converter: UnitConverterLinear(coefficient: 1/(360)))

let r = Measurement(value: 3.14, unit: radiansPerSecond)
r.converted(to: .hertz).value
r.converted(to: degreesPerSecond)


//---------------------------------------
// Perform basic math operations
2*r + r/2

// also handles unit conversions in math operations
Measurement(value: 10, unit: UnitLength.centimeters) + Measurement(value: 1, unit: UnitLength.meters)

(Measurement(value: 10, unit: UnitLength.centimeters) + Measurement(value: 1, unit: UnitLength.meters)).converted(to: .feet)

//---------------------------------------
// Extend existing dimension types
extension UnitSpeed {
    static let kitten = UnitSpeed(
        symbol: "ktn",
        converter: UnitConverterLinear(coefficient: 0.5))
}

let me = Measurement(value: 3, unit: UnitSpeed.metersPerSecond)
me.converted(to: .kitten)

//---------------------------------------
// For something that doesn't exist in Foundation, you can create a whole
// new unit
class CustomRadioactivityUnit: Dimension {
    static let becquerel = CustomRadioactivityUnit(
        symbol: "Bq",
        converter: UnitConverterLinear(coefficient: 1.0))
    
    static let curie = CustomRadioactivityUnit(
        symbol: "Ci",
        converter: UnitConverterLinear(coefficient: 3.7e10))
    
    static let baseUnit = becquerel
}

let rads = Measurement(value: 2, unit: CustomRadioactivityUnit.becquerel)
//rads.converted(to: CustomRadioactivityUnit.curie) // error???


//---------------------------------------
// Formatting style for printing
let speed = Measurement(
    value: 1.0,
    unit: UnitSpeed.kilometersPerHour
)

let style = Measurement<UnitSpeed>.FormatStyle(
    width: .wide)
style.format(speed)

typealias MeasStyle = Measurement<UnitSpeed>.FormatStyle
MeasStyle(width: .abbreviated).format(speed)
MeasStyle(width: .narrow).format(speed)
MeasStyle(width: .wide).format(speed)
