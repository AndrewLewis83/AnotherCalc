# AnotherCalc

## Description:
AnotherCalc is a basic calculator that also comes with a tip calculator. For an example of how to implement, check out LCARS_calc at https://github.com/AndrewLewis83/LCARS_calc

## Using in project UIViewController:

```swift
import UIKit
import AnotherCalc

@IBOutlet weak var mainReadout: UILabel!
@IBOutlet weak var secondaryReadout: UILabel!

var calculator: AnotherCalc!

override func viewDidLoad() {
    super.viewDidLoad()
    
    calculator = AnotherCalc(recordHistory: false)
}
```

The intent of the AnotherCalc object is provide all the basic operations of a cheap calculator, the same way you'd expect:

To add a digit to the calculator, use:

```swift
calculator.addNewDigit(digit: Int)

mainReadout.text = calculator.primaryReadout
secondaryReadout.text = calculator.secondaryReadout
```
While the addNewDigit(digit: Int) method was intended to receive one digit at a time, you can also provide it larger numbers (ie: 2345). For decimal values, you will need to use the addDecimal() method, and then call addDigit again with the decimal values. For example, to enter 745.23:

```swift
calculator.addNewDigit(digit: 745)
calculator.addDecimal()
calculator.addNewDigit(digit: 23)
```

The AnotherCalc object also handles the following calls:
- plus() -> Bool
- minus() -> Bool
- divide() -> Bool
- times() -> Bool
- equals() -> Bool
- addDecimal() -> Bool
- backSpace() -> Bool
- negative() -> Bool
- clear() -> Bool
- calculateTip(_ tipPercentage: Double) -> Bool

All of these methods return a bool, true or false depending on the situation. A false return is meant to be used for providing an appropriate error sound, haptic feedback, and/or error message (ie: dividing by 0 will generate a false return when equals() is called)

## History

If you wish to implement a history feed, pass 'true' to the AnotherCalc initializer.

```swift
 calculator = AnotherCalc(recordHistory: true)
```

Then, you can access the following methods:
- clearHistory()
- logOperation(operation: Operation, index: Int)
- removeOperation(index: Int)

A get-only variable, operationHistory, will give you access to the operation log's contents as an array of type struct Operation.

```swift 
public struct Operation {
    
    let primaryValue: Double
    let secondaryValue: Double?
    let operation: Operations
    let tipPercentage: Double?
}
```        

Operation.secondaryValue is optional (for when you're calculating a tip). In that case, you only need the primaryValue and the tip percentage. For most operations, you shouldn't need to insert your own values. It will be done for you if you pass a true Boolean to the initalizer. You only need to read the return. 

The intended use is as follows:
1. access the appropriate element of the array.
2. perform the appropriate calculation. Think (primaryValue) (operation) (secondaryValue), or for example, 43 x 23. *You do the calculation, and then display the result.* If you retrieve a value from history and want to use it in the calculator, pass it to the primaryReadout as a String. When primaryReadout is being set, it checks to ensure that the string is a number. If the string isn't a number, it will fail silently.

```swift
public enum Operations {
    
    case addition
    case subtraction
    case multiplication
    case division
    case tip
    case none
}
```
The enum Operations has the above options. You should not need to use .tip or .none. The other options are available to appropriately deal with Operation returns 

## tip calculator

to calculate a tip, call the calculateTip method:

```swift
    calculateTip(_ tipPercentage: 0.15)
```

The method expects a number between 0 and 1. A tip of 15% should be passed as 0.15. The method will return false if:

- a tip is being calculated on a negative value.
- a tipPercentage not between 0 and 1 is passed as a parameter 


