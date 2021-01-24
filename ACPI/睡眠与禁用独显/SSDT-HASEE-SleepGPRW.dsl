/*
 * Sleep second wake patch
 * 0D/6D patch 
 *
 * old name:SSDT-GPRW
 * now name:SSDT-HASEE-SleepGPRW
 *
 * Need to be renamed
 *
 * In config ACPI, GPRW to XPRW
 * Find:     47505257 02 
 * Replace:  58505257 02 
 * 
 * In config ACPI, 6D-04 to 00
 * Find:     0A6D0A04 
 * Replace:  0A6D0A00 
 *
 */
DefinitionBlock ("", "SSDT", 2, "HASEE", "GPRW", 0)
{
    External(XPRW, MethodObj)
    Method (GPRW, 2, NotSerialized)
    {
        If (_OSI ("Darwin"))
        {
            If ((0x6D == Arg0))
            {
                Return (Package ()
                {
                    0x6D, 
                    Zero
                })
            }

            If ((0x0D == Arg0))
            {
                Return (Package ()
                {
                    0x0D, 
                    Zero
                })
            }
        }
        Return (XPRW (Arg0, Arg1))
    }
}

