# TodayWidget
  
Embedded framework:  
1. Editor -> Add target (library and framework)  
2. General tab -> check App Extensions (Allow app extension API only)  
3. Move API files to custom framework folder and make related API public  
4. Check the target membership belongs to custom framework  
5. import custom framework in related files  
  
Create Today Widget:  
1. Editor -> Add target (Today Extension)  
2. Generat tab -> Add custom framewrok to Linked Frameworks and Libraries  
3. Run the extension will bring up Notification Center in Today View  
  
Share data between container app and extension:  
1. Through UserDefaults(suiteName: "group.unique.identifier")  
2. Container app -> Capabilities tab -> Turn on App Groups -> Add Container with group.unique.identifier 
3. Extension     -> Capabilities tab -> Turn on App Groups -> Add Container with group.unique.identifier 
