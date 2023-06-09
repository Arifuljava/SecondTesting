//
//  ViewController.swift
//  SecondTesting
//
//  Created by sang on 21/5/23.
//

import UIKit
import CoreBluetooth
import Printer
import Printer

class ViewController: UIViewController ,  CBCentralManagerDelegate, CBPeripheralDelegate, UITableViewDelegate, UITableViewDataSource{
    var coreCenter = CBCentralManager();
    private var centralManager: CBCentralManager?
          private var discoveredPeripherals: [CBPeripheral] = []
    //cnc
      var manager:CBCentralManager!
      var peripheral:CBPeripheral!

      let BEAN_NAME = "AC695X_1(BLE)"
      var myCharacteristic : CBCharacteristic!
          
          var isMyPeripheralConected = false
    

   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sec = storyboard?.instantiateViewController(identifier: "kill") as! ImageViewMyController
                            present(sec,animated: true)
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
                     tableView.dataSource = self
                centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
                               tableView.delegate = self
                               tableView.dataSource = self

                        // Do any additional setup after loading the view.
                        
                        manager = CBCentralManager(delegate: self, queue: nil)
    }
    @objc func centralManagerDidUpdateState(_ central: CBCentralManager) {
                if central.state == .poweredOn {
                    if let peripheral = peripheral {
                                if peripheral.state == .connected {
                                    // The peripheral is connected
                                    print("Peripheral is connected.")
                                } else {
                                    // The peripheral is not connected
                                    print("Peripheral is not connected.")
                                    central.scanForPeripherals(withServices: nil, options: nil)
                                }
                            } else {
                                // No peripheral is currently assigned
                                print("No peripheral assigned.")
                                central.scanForPeripherals(withServices: nil, options: nil)
                            }
                    
                } else {
                    print("Bluetooth is not available.")
                }
            }
    func cancelPeripheralConnection(_ peripheral: CBPeripheral)
    {
        
        discoveredPeripherals.dropFirst()
        print("discc")
    }
       func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
                  if !discoveredPeripherals.contains(peripheral) {
                     
                      discoveredPeripherals.append(peripheral)
                      tableView.reloadData()
                      
                  }
                 
           
           
                //  print(mainflagg.description)
                  if peripheral.name?.contains("AC695X_1(BLE)") == true {
                     
                      manager.cancelPeripheralConnection(peripheral)
                      manager.cancelPeripheralConnection(peripheral)
                     
                   
                              self.peripheral = peripheral
                              self.peripheral.delegate = self

                              manager.connect(peripheral, options: nil)
                      peripheral.delegate = self
                      peripheral.discoverServices(nil)
                   
                              print("My  discover peripheral", peripheral)
                      self.manager.stopScan()
      //check pherifiral
                     
                      
                      
                          }
                  
                  
                  
       }
    func cancelConnection() {
        //peripheral.writeValue(x, for: y, type: .withResponse)
    }
       //
       // MARK: - UITableViewDelegate & UITableViewDataSource
     @objc  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let peripheral = discoveredPeripherals[indexPath.row]
          let devicename = peripheral.identifier.uuidString
        
         let sec = storyboard?.instantiateViewController(identifier: "kill") as! ImageViewMyController
                             present(sec,animated: true)
          
      }
          
        @objc   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             /// print("se")
              return discoveredPeripherals.count
          }
          
         @objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: "celll", for: indexPath)
              let peripheral = discoveredPeripherals[indexPath.row]
              cell.textLabel?.text = peripheral.name ?? "Unknown Device"
              cell.detailTextLabel?.text = peripheral.identifier.uuidString
            
              return cell
          }
      func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
          if let error = error {
              print("Failed to connect to peripheral: \(error.localizedDescription)")
          } else {
              print("Failed to connect to peripheral")
          }
          // Perform any necessary error handling or recovery steps
      }
     
      
      
     @objc  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
               isMyPeripheralConected = true //when connected change to true
               peripheral.delegate = self
               peripheral.discoverServices(nil)
           
       
           print("Conn \(peripheral)")
           var statusMessage = "Connected Successfully with this device : "+BEAN_NAME.description
         
           
           
     }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
              isMyPeripheralConected = false //and to falso when disconnected
              var statusMessage = "Can't  connected with this device : "+BEAN_NAME.description
            
              print("dis")
          }
      func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
          print("not connect")
      }
       
       func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
                    guard let services = peripheral.services else { return }
                    
                    for service in services {
                      peripheral.discoverCharacteristics(nil, for: service)
                        print("Discoveri")
                    }
                }
       private var printerCharacteristic: CBCharacteristic!
       func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
                   guard let characteristics = service.characteristics else { return }
                   
                   for characteristic in characteristics {
                       if characteristic.properties.contains(.writeWithoutResponse) {
                           printerCharacteristic = characteristic
                           var ttt = "Bangladesh, to the east of India on the Bay of Bengal, is a South Asian country marked by lush greenery and many waterways. Its Padma (Ganges), Meghna and Jamuna rivers create fertile plains, and travel by boat is common. On the southern coast, the Sundarbans, an enormous mangrove forest shared with Eastern India, is home to the royal Bengal tiger.   \r\n\n\n"
                           
                           
                           
                           var tttui = " On the southern coast, the Sundarbans, an enormous mangrove forest shared with Eastern India, is home to the royal Bengal tiger.   \r\n\n\n"
                           print(characteristic)
                           guard let data = ttt.data(using: .utf8) else { return }
                           
                         //  peripheral.writeValue(data, for: printerCharacteristic, type: .withoutResponse)
                           print("print ready")
                           //
                           
                          //de
                           print("ui")
        
                           guard let image = UIImage(named: "bluetooth") else { return  }
                           print("tyy")
                           
                        
                           guard let imageData = convertImageToBitmap(image : image) else {
                               return }
                           print(imageData)
                           peripheral.writeValue(imageData, for: characteristic, type: .withoutResponse)
                           
                           print("With Response")
                           //second
                           print("Second")
                          // printImageOnPrinter(rasterBytes: imageData, on: peripheral, with: characteristic)
                           
                           var uint8Array = [UInt8](repeating: 0, count: imageData.count)
                           imageData.withUnsafeBytes { (bytes: UnsafePointer<UInt8>) in
                               uint8Array = Array(UnsafeBufferPointer(start: bytes, count: imageData.count))
                           }
                          printImageOnPrinter(rasterBytes: uint8Array, on: peripheral, with: characteristic)
                           break
                       }
                   }
           
          
           
           
   
     
     
    func printImageOnPrinter(rasterBytes: [UInt8], on peripheral: CBPeripheral, with characteristic: CBCharacteristic) {
        // Create the ESC/POS command for printing raster data
        var command: [UInt8] = []
        command.append(0x1B) // ESC character
        command.append(0x2A) // "*" character
        command.append(0x21) // "!" character
        command.append(UInt8(rasterBytes.count & 0xFF)) // LSB of raster data length
        command.append(UInt8((rasterBytes.count >> 8) & 0xFF)) // MSB of raster data length
        command += rasterBytes // Append the raster data
        
        // Send the command to the printer characteristic
        let data = Data(bytes: command)
        print("fff")
        guard let image = UIImage(named: "bluetooth") else { return  }
        
        peripheral.writeValue(data, for: characteristic, type: .withoutResponse)
        guard let imageData = convertImageToBitmap(image : image) else { return }
        peripheral.writeValue(imageData, for: characteristic, type: .withoutResponse)
       /// peripheral.writeValue(convertImageToBitmap("print"), for: characteristic, type: .withoutResponse)
    }
   
}
    func convertImageToBitmap(image: UIImage) -> Data? {
        print("get")
        guard let cgImage = image.cgImage else { return nil }
        
        let width = cgImage.width
        let height = cgImage.height
        let colorSpace = CGColorSpaceCreateDeviceGray()
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        guard let context = CGContext(data: nil,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: 8,
                                      bytesPerRow: 0,
                                      space: colorSpace,
                                      bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }
       
        
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context.draw(cgImage, in: rect)
        guard let bitmapData = context.data else { return nil }
        
        let dataSize = width * height
        let buffer = UnsafeBufferPointer(start: bitmapData.assumingMemoryBound(to: UInt8.self), count: dataSize)
        print("Bitmap Value : "+buffer.debugDescription)
        
        return Data(buffer: buffer)
    }
    func imageDataPrint( dataimge: Data)
    {
       
    }
}
