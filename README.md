# Result

![alt text](https://github.com/salah-mohammed/TestAccountKit/blob/master/TestAccountKitExample/ezgif-4-e1e15af0b22a.gif?raw=true)

# TestAccountKit

TestAccountKit used for manage your accounts that used for login to your system .

# Where Can Use TestAccountKit
* This tool build for login in debug to make it easier for the programmer to login to the system .
* Don't write your account in login screen to enter to your system, you can choose it from saved list.

# Advantages
* The system can be used if the login screen by username or email or phonenumber.
* You can Search By phoneNumber or by password or by username or by email or by account description.
* When use .indirect , last item you choose it appear at top(Sorted by The last item was selected) sorting depend on id You must enter id in plist, if one account doesn't have id The Sorting will not work .
* When use .direct , the accounts will appear from plist data with out sort by selection.

# Requirements
* IOS 13+ 
* Swift 5+

# How used (configuration): 
# Pod install
```ruby
pod 'TestAccountKit',:git => "https://github.com/salah-mohammed/TestAccountKit.git"
 
```
- First

add plist file it must be like this schema :
https://github.com/salah-mohammed/TestAccountKit/blob/master/TestAccountKitExample/Plist/TestAccountListProducation.plist
- Second

if your login screen login with username and password.
```swift

    @IBAction func btnLogin(_ sender: Any) {
           #if DEBUG
               if (self.txtUserName.text ?? "").count == 0 {
                       UIAlertController.showTestAccounts(.development, TestAccountList.FetchType.inDirect,{ (item) -> String in
                           return "(\(item.accountDescription ?? "")) \(item.username ?? "")"
                       }, selectedHandler: { object in
               self.txtUserName.text=object.username
               self.txtPassword.text=object.password
                            self.login()
                       } )
           }else{
               self.login()
           }
           #else
                self.login()
           #endif
    }
    func login(){
        
    }

 ```
 
if your login screen login with email and password.
 
 ```swift

    @IBAction func btnLogin(_ sender: Any) {
           #if DEBUG
               if (self.txtEmail.text ?? "").count == 0 {
                    UIAlertController.showTestAccounts(.development,TestAccountList.FetchType.direct,selectedHandler: { object in
                        self.txtEmail.text = object.email ?? "";
                        self.txtPassword.text = object.password ?? "";
                        self.login()
                    } )
                
           }else{
               self.login()
           }
           #else
                self.login()
           #endif
    }
    func login(){
        
    }

```
if your login screen login with phone number .

 ```swift

    @IBAction func btnLogin(_ sender: Any) {
           #if DEBUG
               if (self.txtPhoneNumber.text ?? "").count == 0 {
                UIAlertController.showTestAccounts(.development,TestAccountList.FetchType.direct,{ (item) -> String in
                    return "(\(item.accountDescription ?? "")) \(item.phoneNumber ?? "")"
                }, selectedHandler:  { object in
                               self.txtPhoneNumber.text = object.phoneNumber ?? "";
                               self.login()
                          })
                
           }else{
               self.login()
           }
           #else
                self.login()
           #endif
    }
    func login(){
        
    }

 ```


# Configure Successfully

## License

TestAccountKit is released under the MIT license. [See LICENSE](https://github.com/salah-mohammed/TestAccountKit/blob/master/LICENSE) for details.

# Developer's information to communicate

- salahalimohamed1995@gmail.com
- https://www.facebook.com/salah.shaker.7
- +972597105861 (whatsApp And PhoneNumber)
- https://www.linkedin.com/in/salah-mohamed-676b6a17a (Linkedin)
