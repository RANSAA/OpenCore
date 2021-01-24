/*
 * NVGPU disable patch
 * 
 * old name:SSDT-NDGP_OFF
 * now name:SSDT-HASEE-NvGPU_OFF
 *
 * warning:Do not use SSDT to disable the independent display, 
 *         the screen will be black after sleep wakeup.
 *
 */
DefinitionBlock("", "SSDT", 2, "HASEE", "NvGPU", 0)
{
    External(_SB.PCI0.RP13.PXSX._ON, MethodObj)
    External(_SB.PCI0.RP13.PXSX._OFF, MethodObj)
 
    If (_OSI ("Darwin"))
    {
        Device(DGPU)
        {
            Name(_HID, "DGPU1000")
            Method (_INI, 0, NotSerialized)
            {
                _OFF()
            }
            
            Method (_ON, 0, NotSerialized)
            {
                //path:
                If (CondRefOf (\_SB.PCI0.RP13.PXSX._ON))
                {
                    \_SB.PCI0.RP13.PXSX._ON()
                }
            }
            
            Method (_OFF, 0, NotSerialized)
            {
                //path:
                If (CondRefOf (\_SB.PCI0.RP13.PXSX._OFF))
                {
                    \_SB.PCI0.RP13.PXSX._OFF()
                }
            }
        }
    }
}
//EOF
