/*
 * Battery patch
 *
 */


DefinitionBlock ("", "SSDT", 2, "HASEE", "BAT0", 0x00000000)
{
    External(_SB_.PCI0.LPCB.EC, DeviceObj)
    External(_SB_.AC._PSR, MethodObj)
    External(_SB_.AC.ADJP, MethodObj)
    
//    //Rename
//    External(_SB_.BAT0.XBIF, MethodObj)
//    External(_SB_.BAT0.XBST, MethodObj)
    

    Method (B1B2, 2, NotSerialized)//16 Bit Read
    {
        Return ((Arg0 | (Arg1 << 0x08)))
    }

    Method (B1B4, 4, NotSerialized)//32 Bit Read
    {
        Local0 = (Arg2 | (Arg3 << 0x08))
        Local0 = (Arg1 | (Local0 << 0x08))
        Local0 = (Arg0 | (Local0 << 0x08))
        Return (Local0)
    }

    Method (W16B, 3, NotSerialized)//16 Bit Write
    {
        Arg0 = Arg2
        Arg1 = (Arg2 >> 0x08)
    }



    Scope (_SB.PCI0.LPCB.EC)
    {
        //32+ Bit Read
        Method (RE1B, 1, NotSerialized)
        {
            OperationRegion (EC81, EmbeddedControl, Arg0, One)
            Field (EC81, ByteAcc, NoLock, Preserve)
            {
                BYTE,   8
            }

            Return (BYTE) /* \RE1B.BYTE */
        }
        
        Method (RECB, 2, Serialized)//--read
        {
            Arg1 = ((Arg1 + 0x07) >> 0x03)
            Name (TEMP, Buffer (Arg1){})
            Arg1 += Arg0
            Local0 = Zero
            While ((Arg0 < Arg1))
            {
                TEMP [Local0] = RE1B (Arg0)
                Arg0++
                Local0++
            }

            Return (TEMP) /* \RECB.TEMP */
        }
        
        //32+ Bit Write
        Method (WE1B, 2, NotSerialized)
        {
            OperationRegion (EC81, EmbeddedControl, Arg0, One)
            Field (EC81, ByteAcc, NoLock, Preserve)
            {
                BYTE,   8
            }

            BYTE = Arg1
        }


        Method (WECB, 3, Serialized)//--write
        {
            Arg1 = ((Arg1 + 0x07) >> 0x03)
            Name (TEMP, Buffer (Arg1){})
            TEMP = Arg2
            Arg1 += Arg0
            Local0 = Zero
            While ((Arg0 < Arg1))
            {
                WE1B (Arg0, DerefOf (TEMP [Local0]))
                Arg0++
                Local0++
            }
        }
        
        
        
        
        
    }




}

