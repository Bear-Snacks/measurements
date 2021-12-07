# Units and Measurement

[Units and measurements](https://developer.apple.com/documentation/foundation/units_and_measurement)

- `struct Measurement`:A numeric quantity labeled with a unit of measure, with support for unit conversion and unit-aware calculations.
- `class Unit`: An abstract class representing a unit of measure.
- `class Dimension`: An abstract class representing a dimensional unit of measure.

# Dimension

[Dimension](https://developer.apple.com/documentation/foundation/dimension)
allows you to easily convert between units and display the unit
symbol.

```swift
import Foundation

let distance = 1234.0 // meters as a double
let distMeters = Measurement(value: distance, unit: UnitLength.meters)
let distMiles = distMeters.converted(to: .miles).value
```

## Creating New Custom Units

You also have the ability to create new custom units. For some reason, angular
velocity is not included in the library, so let's make some:

```swift
let radiansPerSecond = UnitFrequency(symbol: "rps", converter: UnitConverterLinear(coefficient: 1/(2*3.14)))
let degreesPerSecond = UnitFrequency(symbol: "dps", converter: UnitConverterLinear(coefficient: 1/(360)))

let r = Measurement(value: 3.14, unit: radiansPerSecond)
r.converted(to: .hertz).value
r.converted(to: degreesPerSecond)
```

## Creating New Units Not in Foundation

For something that doesn't exist in Foundation, you can create a whole new unit.
For example, the unit for radioactivity is not found:

```swift
class CustomRadioactivityUnit: Dimension {
    static let becquerel = CustomRadioactivityUnit(
        symbol: "Bq",
        converter: UnitConverterLinear(coefficient: 1.0))
    static let curie = CustomRadioactivityUnit(
        symbol: "Ci",
        converter: UnitConverterLinear(coefficient: 3.7e10))

    static let baseUnit = CustomRadioactivityUnit.becquerel
}

let rad = Measurement(value: 2, unit: CustomRadioactivityUnit.becquerel)
```
