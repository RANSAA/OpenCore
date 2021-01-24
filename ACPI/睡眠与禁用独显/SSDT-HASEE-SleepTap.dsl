/*
 * Extension patch
 * Solve the problem that some machines need to press any key to turn on the screen after waking up
 * 
 * old name:SSDT-EXT3-WakeScreen
 * now name:SSDT-HASEE-SleepTap
 *
 */

DefinitionBlock("", "SSDT", 2, "HASEE", "SleepTap", 0)
{
    External(_SB.LID, DeviceObj)
    External(_SB.LID0, DeviceObj)
    External(_SB.PCI0.LPCB.LID, DeviceObj)
    External(_SB.PCI0.LPCB.LID0, DeviceObj)
    
    Method (EXT3, 1, NotSerialized)
    {   
        If (3 == Arg0)
        {
            If (CondRefOf (\_SB.LID))
            {
                Notify (\_SB.LID, 0x80)
            }
            If (CondRefOf (\_SB.LID0))
            {
                Notify (\_SB.LID0, 0x80)
            }
            //
            If (CondRefOf (\_SB.PCI0.LPCB.LID))
            {
                Notify (\_SB.PCI0.LPCB.LID, 0x80)
            }
            If (CondRefOf (\_SB.PCI0.LPCB.LID0))
            {
                Notify (\_SB.PCI0.LPCB.LID0, 0x80)
            }
        }
    }
}
//EOF
