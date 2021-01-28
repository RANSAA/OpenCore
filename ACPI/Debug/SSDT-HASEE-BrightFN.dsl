/*
 * Brightness shortcut key mapping
 *
 * Need to be renamed
 *
 * In config ACPI, Rename _Q12 to XQ12
 * Find:     5F513132 00
 * Replace:  58513132 00
 *
 */
DefinitionBlock("", "SSDT", 2, "HASEE", "BrightFN", 0)
{
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    External(_SB.PCI0.LPCB.EC.XQ12, MethodObj)
    External(_SB.PCI0.LPCB.EC.OEM2, FieldUnitObj)

    
//Debug
    External(RMDT.P1, MethodObj)
    External(RMDT.P2, MethodObj)
    External(_SB.PCI9.TPTS, IntObj)
    External(_SB.PCI9.TWAK, IntObj)        

 
    Scope (_SB.PCI0.LPCB.EC)
    {
        //The defined temporary variable is used to store the changed value of Fn+F8/Fn+F9.
        Name (TKBR, Zero)
        Method (_Q12, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {      
                Name (OEM8, Zero)

//                //Debug...

                \RMDT.P1 ("ABCD-KEYBOARD-Q12")
                \RMDT.P2 ("ABCD-OEM2=", \_SB.PCI0.LPCB.EC.OEM2)
                \RMDT.P2 ("ABCD-TKBR=", \_SB.PCI0.LPCB.EC.TKBR)                

//                //Debug...
    
                
                If ((OEM2 == 0x00))//Fn+F8
                {
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
                }
                ElseIf((OEM2 == 0x07))//Fn+F9
                {
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
                }
                Else
                {
                    If ((OEM2 > TKBR))//Fn+F9
                    {
                        Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
                    }
                    Else//Fn+F8
                    {
                        Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
                    }
                }
                TKBR = OEM2
                            
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ12()
            }
        }
       
    }
}
//EOF
