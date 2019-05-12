//
//  ViewController.swift
//  Calculator
//
//  Created by Artem Esolnyak on 12/05/2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayResultLabel: UILabel!
    //создаем перемнную которая проверят вводится ли число
    var stillTyping = false
    //переменаня для хранения певрого операнда
     var firstOperand : Double = 0
    //переменная для хранения второго опперанда
    var secondOperand : Double = 0
    //переменная для хранения знака кнопки
    var operationSigt: String  = ""
    //переменная для указывания ставили ли мы уже дробную часть числа (точку)
    var dotIsPlaced = false
    
    
    //переменная нужная для перевода нашего текста на дисплее в дабл
    var correntInput : Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            //разделям с троку за разделитель принимает "."
            let  valueArray = value.components(separatedBy: ".")
            //проверяем правую часть
            if valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            } else {
                displayResultLabel.text = "\(newValue)"
            }
            
            stillTyping = false
        }
    }
    
    //меняем цвет статусбара на белый (вестимо черещ код)
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
       
        //если стил тайпинг будет тру то выводим цифру на экран
        if stillTyping {
        
        //ограничеваем кол-во символов которое можнг вводить на дисплей
        if (displayResultLabel.text?.count)! < 20 {
            //считываем название цифры при нажатии на кнопку
        displayResultLabel.text = displayResultLabel.text! + number
        }
        // если фолс то просто заменяем хранилище нажатой цифрой (убираем первый ноль)
        } else {
            displayResultLabel.text = number
            stillTyping = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func twoOperandsSignPressed(_ sender: UIButton) {
        operationSigt = sender.currentTitle!
        //текущее значение нажатой кнопки сохраняется в первый операнд
        firstOperand = correntInput
        stillTyping = false
        dotIsPlaced = false
        
    }
    
    // функция принимающее значение двух операндов и делающее какое-то действие с ними
    func operateWith2Operands(operation:(Double,Double) -> Double) {
        correntInput = operation(firstOperand, secondOperand)
        //после нажатию на кнопку операции больше не хотим добавлять знаки
        stillTyping = false
    }
    
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        if stillTyping {
            //если тру текущее значение записываем во второй операнд
            secondOperand = correntInput
        }
        
        dotIsPlaced = false
        
        //тут мы выбираем действие исходя из значения нажатого тайтла
        switch operationSigt {
        case "+": operateWith2Operands{$0 + $1}
        case "-": operateWith2Operands{$0 - $1}
        case "×": operateWith2Operands{$0 * $1}
        case "÷": operateWith2Operands{$0 / $1}
        default: break
        }
    }
    
    
    @IBAction func sqrootButtonPressed(_ sender: UIButton) {
        //вычисляем корень
        correntInput = sqrt(correntInput)
    }
    @IBAction func precentButtonPressed(_ sender: UIButton) {
        // формула по вычислению процентов
        if firstOperand == 0 {
            correntInput = correntInput / 100
        } else {
            secondOperand = firstOperand * correntInput / 100
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        //обнуляем все  ведь кнопка обнулить=)
        firstOperand = 0
        secondOperand = 0
        correntInput = 0
        displayResultLabel.text = "0"
        stillTyping = false
        dotIsPlaced = false
        operationSigt = ""
        
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        //кнопка меняем + на -
        correntInput = -correntInput
    }
    @IBAction func dotButttonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPlaced = true
        }
            //когда ничего еще не ввели но уже хотим дробное число .0
        else if !stillTyping && !dotIsPlaced{
            displayResultLabel.text = "0."
        }
        
    }
}

