/*
 * PS keyboard mapping
 *
 * old name:SSDT-Swap-CommandOption
 * now name:SSDT-HASEE-PS2
 *
 * contain:
 *        1.SSDT-Swap-CommandOption
 *        2.RMCF Key
 *
 * ps:If you need multiple RMCF mappings, you need to integrate them into one RMCF.
 * 
 */
DefinitionBlock ("", "SSDT", 2, "HASEE", "PS2", 0)
{
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)
    
    Name(_SB.PCI0.LPCB.PS2K.RMCF, Package()
    {
        "Keyboard", Package()
        {
            //SSDT-Swap-CommandOption:
            "Swap command and option", ">y",                
      
            //If you need other key mapping, you can directly add it in this area
            
     /*               
            //RMCF Key mapping
             "Custom PS2 Map", Package()
             {
                  Package(){},
                  "e037=64", // PrtSc=F13
                  "42=65",   // F8=F14
                  "43=66",   // F9=F15
                  "e02e=65",   // Fn+F5 = F14
                  "e030=66",   // Fn+F6 = F15

                  "e005=65",   // Fn+F8 = F14
                  "e006=66",   // Fn+F9 = F15                
             }
   */
                                                        
        }
    })
}
//EOF
