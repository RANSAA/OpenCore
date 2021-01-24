/*
 * Sleep button patch
 * 
 * old name:SSDT-FnF4_Q13-X1C5th
 * now name:SSDT-HASEE-SleepBTN
 *
 * Need to be renamed
 *
 * In config ACPI, Rename _Q15 to XQ15
 * Find:     5F513135 00
 * Replace:  58513135 00
 *
 */

DefinitionBlock("", "SSDT", 2, "HASEE", "SleepBTN", 0)
{
    External(_SB.PCI9.FNOK, IntObj)
    External(_SB.PCI9.MODE, IntObj)
    External(_SB.LID, DeviceObj)
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    External(_SB.PCI0.LPCB.EC.XQ15, MethodObj)

    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (_Q15, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If (\_SB.PCI9.MODE == 1) //PNP0C0E
                {
                    \_SB.PCI9.FNOK =1
                    \_SB.PCI0.LPCB.EC.XQ15()
                }
                Else //PNP0C0D
                {
                    If (\_SB.PCI9.FNOK!=1)
                    {
                        \_SB.PCI9.FNOK =1
                    }
                    Else
                    {
                        \_SB.PCI9.FNOK =0
                    }
                    Notify (\_SB.LID, 0x80)
                }
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ15()
            }
        }
    }
}
//EOF