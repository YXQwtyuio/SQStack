//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class SQStack<E> {
    
    var stack: [E]
    
    init() {
        self.stack = []
    }
    
    func stackEmpty() -> Bool {
        return stack.count == 0
    }
    
    func getTop() -> E? {
        guard !self.stackEmpty() else {
            return nil
        }
        return stack.last
    }
    
    func push(e: E) -> Void {
        stack.append(e)
    }
    
    func pop() -> E? {
        guard !self.stackEmpty() else {
            return nil
        }
        return stack.removeLast()
    }
}

let stack = SQStack<String>()
stack.push(e: "A")
stack.push(e: "B")
stack.push(e: "C")

stack.pop()
stack.pop()
stack.pop()
stack.pop()
//stack.stack

func conversion(n: Int, to x: Int) {
    let stack = SQStack<Int>()
    var temp = n
    while temp > 0 {
        stack.push(e: temp % x)
        temp = temp / x
    }
    while !stack.stackEmpty() {
        print("\(stack.pop() ?? 0 )")
    }
}

conversion(n: 1348, to: 8)

let data = ["3", "*", "(", "7", "-", "2", ")", "+", "5", "*", "3","*" , "(", "7", "-", "2", ")", "*", "6", "/", "3", "+", "3", "/", "3", "+", "3", "*", "3", "-", "3", "*", "(", "7", "-", "2", ")"]
//let op = SQStack<String>()
//for item in data {
//    op.push(e: item)
//}
//while !op.stackEmpty() {
//    print(op.pop() ?? " ")
//}

struct Oper {
    
    let opers1 = ["("]
    let opers2 = ["*", "/"]
    let opers3 = ["+", "-"]
    let opers4 = [")"]
    
    func canEveOper(op: String) -> Bool {
        return opers2.contains(op) || opers3.contains(op)
    }
    
    func eve(d1: Int, d2: Int, op: String) -> Int {
        switch op {
        case "+":
            return d1 + d2
        case "-":
            return d1 - d2
        case "*":
            return d1 * d2
        case "/":
            return d1 / d2
        default:
            return 0
        }
    }
    
    func high(o1: String, than o2: String) -> Bool {
        return opersValue(o: o1) < opersValue(o: o2)
    }
    
    func opersValue(o: String) -> Int {
        if opers1.contains(o) {
            return 1
        }else if opers2.contains(o) {
            return 2
        }else if opers3.contains(o) {
            return 3
        }else if opers4.contains(o) {
            return 4
        }
        return 99
    }
}

func evaluateExpression(data: [String]) {
    let optr = SQStack<String>()
    let opnd = SQStack<Int>()
    let opers = Oper()
    
    var des: String {
        var d = "计算："
        for item in data {
            d += "\(item) "
        }
        return d
    }
    
    print(des)
    
    func evaluate(o1: Int, o2: Int, op: String) {
        if opers.canEveOper(op: op) {
            print("o2: \(o2), o1: \(o1)， 运算符：\(op)")
            let e = opers.eve(d1: o2, d2: o1, op: op)
            print("计算结果：\(e)")
            opnd.push(e: e)
        }else{
            evaluate(o1: o1, o2: o2, op: optr.pop() ?? "end")
        }
    }
    
    func addOptr(op: String) {
        if opers.high(o1: op, than: optr.getTop() ?? "end") {
//            print("push item optr:\(op)")
            optr.push(e: op)
        }else{
            if !opers.canEveOper(op: optr.getTop() ?? "end") && !opers.high(o1: op, than: optr.getTop() ?? "end") {
//                print("push item optr:--\(op)")
                optr.pop()
//                addOptr(op: op)
                optr.push(e: op)
            }else{
                let o = optr.pop() ?? "end"
                let o1 = opnd.pop() ?? 0
                let o2 = opnd.pop() ?? 0
//                print("计算符：\(o), 待push：\(op)")
//                optr.push(e: op)
                evaluate(o1: o1, o2: o2, op: o)
                if op == "=" {
                    if let opp = optr.pop() {
                        let oo1 = opnd.pop() ?? 0
                        let oo2 = opnd.pop() ?? 0
                        evaluate(o1: oo1, o2: oo2, op: opp)
                    }else{
                        return
                    }
                }else{
                    if opers.canEveOper(op: op) {
                        addOptr(op: op)
                    }
                }
            }
        }
    }
    
    for item in data {
//        print("----当前循环：\(item)")
        if opers.opersValue(o: item) < 99 {
            addOptr(op: item)
        }else{
//            print("item opnd:\(item)")
            opnd.push(e: Int(item)!)
        }
    }
    addOptr(op: "=")
    print("操作符：\(optr.stack)")
    print("操作数：\(opnd.stack)")
    print("最终计算结果：\(des) = \(opnd.pop() ?? 0)")
}

evaluateExpression(data: data)





