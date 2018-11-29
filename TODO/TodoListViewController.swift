//
//  ViewController.swift
//  TODO
//
//  Created by Gazelle on 2018/11/7.
//  Copyright © 2018年 LiaoShiCun. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    //创建一个数组
    var itemArray = ["你有没有","那么一瞬间","心疼过我的执着"]
    //本地数据存储
     let defaults = UserDefaults.standard
    //创建计时器
    var timer = Timer()
  
    
    @IBOutlet weak var image2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 如果UserDefaults对象获取的数据是字符串数组，则通过可选绑定的方式赋值给items 把存到沙盒的数据赋值给数组
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]{
            itemArray = items
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    //表视图数据源方法  创建一个label ToDoltemCell 要与故事版中名字相同
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoltemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    //返回数组
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //告诉控制器,用户单击了表格视图中的哪个单元格
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        //通过indexPath参数获取到表格视图中指定单元格对象,然后再通过该单元格对象的accessoryType属性值为.checkmark
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){//如果单元格有勾,就把勾清除,如果没有,就添加
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
        //用户单击单元格以后,灰色高亮会逐渐变淡消失.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //声明一个新的变量，生存期在方法的内部
        var textField = UITextField()
        
       let alert = UIAlertController(title: "添加一个新的ToDo项目", message: "", preferredStyle: .alert)
     let action = UIAlertAction(title: "添加项目", style: .default) { (action) in
        //当用户单击添加项目按钮以后要执行的代码
          self.itemArray.append(textField.text!)
        //添加到沙盒中保存本地数据
         self.defaults.set(self.itemArray, forKey: "ToDoListArray")
        //通过表格视图的reloadData()方法让其重新载入数据来更新表格视图中所显示的数据
          self.tableView.reloadData()
        }

//        alert.addAction(action)
//        //alert 在屏幕中央弹出 actionsheet在屏幕底部弹出
//        present(alert, animated: true, completion: nil)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "创建一个新项目。。。"
            //让textField指向alertTextField,因为出了闭包,alertTextField不存在
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
   

   }


 

    



