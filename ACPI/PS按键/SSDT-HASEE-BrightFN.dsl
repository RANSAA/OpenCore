/*
 * Brightness shortcut key mapping
 *
 * Need to be renamed
 *
 * In config ACPI, Rename _Q11 to XQ11
 * Find:     5F513131 00
 * Replace:  58513131 00
 *
 * In config ACPI, Rename _Q12 to XQ12
 * Find:     5F513132 00
 * Replace:  58513132 00
 *
 */
DefinitionBlock("", "SSDT", 2, "OCLT", "BrightFN", 0)
{
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    External(_SB.PCI0.LPCB.EC.XQ11, MethodObj)
    External(_SB.PCI0.LPCB.EC.XQ12, MethodObj)

    //
    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (_Q11, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
                Notify(\_SB.PCI0.LPCB.PS2K, 0x20)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ11()
            }
        }
        
        Method (_Q12, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {      
                Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
                Notify(\_SB.PCI0.LPCB.PS2K, 0x20)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ12()
            }
        }
        
      
        
        
        
    }
}
//EOF
