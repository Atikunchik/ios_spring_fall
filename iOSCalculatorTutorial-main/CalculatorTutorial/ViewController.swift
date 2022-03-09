
import UIKit

class ViewController: UIViewController
{

	@IBOutlet weak var calculatorWorkings: UILabel!
	
    var workings: String = ""
    
    var Expressions: [String] = []
    var OpenedBrackets: Int = 0
    
    var LastIsOperation: Bool = false
    
    var dotPressed: Bool = false
    
	override func viewDidLoad()
	{
		super.viewDidLoad()
		clearAll()
	}
	
	func clearAll()
	{
        Expressions = [""]
		calculatorWorkings.text = ""
        OpenedBrackets = 0
        dotPressed = false
	}

	@IBAction func equalsTap(_ sender: Any)
	{
        dotPressed = false
        while(Expressions.count > 1){
            let expression = NSExpression(format: Expressions.removeLast())
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let lastExpression = Expressions.removeLast()
            Expressions.append(lastExpression + String(format: "%f", result))
        }
        let expression = NSExpression(format: Expressions.removeLast())
        let result = expression.expressionValue(with: nil, context: nil) as! Double
        Expressions.append(String(format: "%.2f", result))
        calculatorWorkings.text = formatResult(result: result)
	}
    
    func calcLastExpression(value: String){
        workings = Expressions.removeLast()
        if(!workings.isEmpty){
            dotPressed = false
            if(LastIsOperation){
                workings.removeLast()
            }
            LastIsOperation = true
            let expression = NSExpression(format: workings)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            
            workings = formatResult(result: result)
            
            workings += value
        }
        Expressions.append(workings)
        calculatorWorkings.text = workings
    }
    
	func formatResult(result: Double) -> String
	{
		if(result.truncatingRemainder(dividingBy: 1) == 0)
		{
			return String(format: "%.0f", result)
		}
		else
		{
			return String(format: "%.2f", result)
		}
	}
	
	@IBAction func allClearTap(_ sender: Any)
	{
		clearAll()
	}
	
	
	func addToWorkings(value: String)
	{
        var now: String = Expressions.removeLast()
        now += value
        Expressions.append(now)
        calculatorWorkings.text = Expressions.last
	}
	
	
	@IBAction func divideTap(_ sender: Any)
	{
        calcLastExpression(value: "/")
	}
	
	@IBAction func timesTap(_ sender: Any)
	{
        calcLastExpression(value: "*")
	}
	
	@IBAction func minusTap(_ sender: Any)
	{
        calcLastExpression(value: "-")
	}
	
	@IBAction func plusTap(_ sender: Any)
	{
        calcLastExpression(value: "+")
	}
	
	@IBAction func decimalTap(_ sender: Any)
	{
        if(!Expressions.last!.isEmpty){
            dotPressed = true
            addToWorkings(value: ".")
        }
	}
	
	@IBAction func zeroTap(_ sender: Any)
	{
        if(Expressions.last != "0"){
            LastIsOperation = false
            addToWorkings(value: "0")
        }
	}
	
	@IBAction func oneTap(_ sender: Any)
	{
        LastIsOperation = false
		addToWorkings(value: "1")
	}
	
	@IBAction func twoTap(_ sender: Any)
	{
        LastIsOperation = false
		addToWorkings(value: "2")
	}
	
	@IBAction func threeTap(_ sender: Any)
	{
        LastIsOperation = false
		addToWorkings(value: "3")
	}
	
	@IBAction func fourTap(_ sender: Any)
	{
        LastIsOperation = false
		addToWorkings(value: "4")
	}
	
	@IBAction func fiveTap(_ sender: Any)
	{
        LastIsOperation = false
		addToWorkings(value: "5")
	}
	
	@IBAction func sixTap(_ sender: Any)
	{
        LastIsOperation = false
		addToWorkings(value: "6")
	}
	
	@IBAction func sevenTap(_ sender: Any)
	{
        LastIsOperation = false
		addToWorkings(value: "7")
	}
	
	@IBAction func eightTap(_ sender: Any)
	{
        LastIsOperation = false
		addToWorkings(value: "8")
	}
	
	@IBAction func nineTap(_ sender: Any)
	{
        LastIsOperation = false
		addToWorkings(value: "9")
	}
    @IBAction func OpenBracketTap(_ sender: Any){
        if(LastIsOperation){
            OpenedBrackets += 1
            Expressions.append("")
        }
    }
    @IBAction func CloseBracketTap(_ sender: Any){
        if(!LastIsOperation && OpenedBrackets > 0){
            OpenedBrackets -= 1
            calcLastExpression(value: "")
        }
    }
}

