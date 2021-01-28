// battery hot patch
//
//
// In config ACPI, UPBI to XPBI
// Find:     55504249 00
// Replace:  58504249 00
//
// In config ACPI, UPBS to XPBS
// Find:     55504253 00
// Replace:  58504253 00
//
// In config ACPI, GCMD to XCMD 
// Find:     47434D44 0B
// Replace:  58434D44 0B
//
// In config ACPI, _Q37 to XQ37
// Find:     5F513337 00
// Replace:  58513337 00
// In config ACPI, _Q35 to XQ35
// Find:     5F513335 00
// Replace:  58513335 00
//


DefinitionBlock ("", "SSDT", 2, "HASEE", "BAT0", 0x00000000)
{
    External (_SB.PCI0.LPCB.EC, DeviceObj)
    External (_SB.PCI0.PEG0.PEGP, DeviceObj)
    External (_SB.BAT0, DeviceObj)    // 0 Arguments
    External (_SB.WMI, DeviceObj)    // 0 Arguments

    External (_SB.WMI.GCMD, MethodObj)    // 0 Arguments
    External (_SB.BAT0.IVBI, MethodObj)    // 0 Arguments
    External (_SB.BAT0.IVBS, MethodObj)    // 0 Arguments
    External (_SB.BAT0.PBST, PkgObj)
    External (_SB.BAT0.PBIF, PkgObj)
    
    External (GNVS, FieldUnitObj)
    External (NVBB, FieldUnitObj)
    External (BSCP, FieldUnitObj)
    External (PSF2, FieldUnitObj)
    External (BAEE, FieldUnitObj)
    External (BTCP, FieldUnitObj)
    External (PSF0, FieldUnitObj)
    External (P80H, FieldUnitObj)
    External (PSF1, FieldUnitObj)
    External (PSST, FieldUnitObj)
    External (VGAS, FieldUnitObj)
    
    External (_SB.PCI0.LPCB.EC.FCMD, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC.FDAT, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC.BBST, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC.BAT0, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC.FBUF, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC.FBF1, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC.FBF2, FieldUnitObj)
    
    External (_SB.PCI0.LPCB.EC.B15C, IntObj)
    External (_SB.PCI0.LPCB.EC.SLFG, IntObj)
    External (_SB.PCI0.LPCB.EC.ECOK, IntObj)
    External (_SB.AC.ACFG, IntObj)
    External (_SB.WMI.INDX, IntObj)
    External (_SB.WMI.EVNT, IntObj)
    External (_SB.WMI.HKDR, IntObj)
    External (_SB.BAT0.BFCC, IntObj)
    External (_TZ.TZ0.PPFG, IntObj)
    External (_SB.AC.ADJP, MethodObj)
    External (_SB.PCI0.GFX0.PDDS, MethodObj)
    
    External (_SB.WMI.XCMD, MethodObj)    // 3 Arguments
    External (_SB.PCI0.LPCB.EC.XQ35, MethodObj)    // 0 Arguments
    External (_SB.PCI0.LPCB.EC.XQ37, MethodObj)    // 0 Arguments
    External (_SB.BAT0.XPBI, MethodObj)    // 0 Arguments
    External (_SB.BAT0.XPBS, MethodObj)    // 0 Arguments
    
        
     // 16 bits chaifeng
     Method (B1B2, 2, NotSerialized)
    {
        Return ((Arg0 | (Arg1 << 0x08)))
    }

    // 32 bits chaifeng
    Method (B1B4, 4, NotSerialized)
    {
        Local0 = (Arg2 | (Arg3 << 0x08))
        Local0 = (Arg1 | (Local0 << 0x08))
        Local0 = (Arg0 | (Local0 << 0x08))
        Return (Local0)
    }           
                
                
                
    Scope (_SB.BAT0)
    {
            Method (UPBI, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                    If (\_SB.PCI0.LPCB.EC.BAT0)
                    {
                        Local0 = (B1B4 (^^PCI0.LPCB.EC.BD0C, ^^PCI0.LPCB.EC.BD1C, ^^PCI0.LPCB.EC.BD2C, ^^PCI0.LPCB.EC.BD3C) & 0xFFFF)
                        PBIF [One] = Local0
                        Local0 = (B1B4 (^^PCI0.LPCB.EC.BF0C, ^^PCI0.LPCB.EC.BF1C, ^^PCI0.LPCB.EC.BF2C, ^^PCI0.LPCB.EC.BF3C) & 0xFFFF)
                        PBIF [0x02] = Local0
                        BFCC = Local0
                        Local0 = (B1B4 (^^PCI0.LPCB.EC.BD0V, ^^PCI0.LPCB.EC.BD1V, ^^PCI0.LPCB.EC.BD2V, ^^PCI0.LPCB.EC.BD3V) & 0xFFFF)
                        PBIF [0x04] = Local0
                        Local0 = (B1B4 (^^PCI0.LPCB.EC.BC0W, ^^PCI0.LPCB.EC.BC1W, ^^PCI0.LPCB.EC.BC2W, ^^PCI0.LPCB.EC.BC3W) & 0xFFFF)
                        PBIF [0x05] = Local0
                        Local0 = (B1B4 (^^PCI0.LPCB.EC.BC0L, ^^PCI0.LPCB.EC.BC1L, ^^PCI0.LPCB.EC.BC2L, ^^PCI0.LPCB.EC.BC3L) & 0xFFFF)
                        PBIF [0x06] = Local0
                        PBIF [0x09] = "BAT"
                        PBIF [0x0A] = "0001"
                        PBIF [0x0B] = "LION"
                        PBIF [0x0C] = "Notebook"
                    }
                    Else
                    {
                        IVBI ()
                    }
                }
                Else
                {
                    \_SB.BAT0.XPBI ()
                }
            }
            
            Method (UPBS, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                    If (\_SB.PCI0.LPCB.EC.BAT0)
                    {
                        Local0 = Zero
                        Local1 = Zero
                        If (^^AC.ACFG)
                        {
                            If (((B1B4 (^^PCI0.LPCB.EC.BS0T, ^^PCI0.LPCB.EC.BS1T, ^^PCI0.LPCB.EC.BS2T, ^^PCI0.LPCB.EC.BS3T) & 0x02) == 0x02))
                            {
                                Local0 |= 0x02
                                Local1 = (B1B4 (^^PCI0.LPCB.EC.BP0R, ^^PCI0.LPCB.EC.BP1R, ^^PCI0.LPCB.EC.BP2R, ^^PCI0.LPCB.EC.BP3R) & 0xFFFF)
                            }
                        }
                        Else
                        {
                            Local0 |= One
                            Local1 = (B1B4 (^^PCI0.LPCB.EC.BP0R, ^^PCI0.LPCB.EC.BP1R, ^^PCI0.LPCB.EC.BP2R, ^^PCI0.LPCB.EC.BP3R) & 0xFFFF)
                        }

                        Local7 = (Local1 & 0x8000)
                        If ((Local7 == 0x8000))
                        {
                            Local1 ^= 0xFFFF
                        }

                        Local2 = (B1B4 (^^PCI0.LPCB.EC.BR0C, ^^PCI0.LPCB.EC.BR1C, ^^PCI0.LPCB.EC.BR2C, ^^PCI0.LPCB.EC.BR3C) & 0xFFFF)
                        Local3 = (B1B4 (^^PCI0.LPCB.EC.BP0V, ^^PCI0.LPCB.EC.BP1V, ^^PCI0.LPCB.EC.BP2V, ^^PCI0.LPCB.EC.BP3V) & 0xFFFF)
                        PBST [Zero] = Local0
                        PBST [One] = Local1
                        PBST [0x02] = Local2
                        PBST [0x03] = Local3
                        If ((BFCC != B1B4 (^^PCI0.LPCB.EC.BF0C, ^^PCI0.LPCB.EC.BF1C, ^^PCI0.LPCB.EC.BF2C, ^^PCI0.LPCB.EC.BF3C)))
                        {
                            Notify (BAT0, 0x81) // Information Change
                        }
                    }
                    Else
                    {
                        IVBS ()
                    }
                }
                Else
                {
                   \_SB.BAT0.XPBS ()
                }
            }

    }                
                
                
                
                
                
    Scope (_SB.WMI)
    {
        Method (GCMD, 3, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                Name (ARGS, Zero)
                If (SizeOf (Arg2))
                {
                    ARGS = Arg2
                }

                Local0 = Zero
                If ((ToInteger (Arg1) == One))
                {
                    If (\_SB.WMI.HKDR)
                    {
                        Local0 = \_SB.WMI.EVNT /* External reference */
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x05))
                {
                    If (^^PCI0.LPCB.EC.ECOK)
                    {
                        ^^PCI0.LPCB.EC.FDAT = 0xA1
                        ^^PCI0.LPCB.EC.FCMD = 0xB8
                        If (One)
                        {
                            Local1 = ^^PCI0.LPCB.EC.FDAT /* External reference */
                            If ((B1B2 (^^PCI0.LPCB.EC.OE0M, ^^PCI0.LPCB.EC.OE1M) & 0x08))
                            {
                                If ((Local1 & 0x02))
                                {
                                    Local0 = One
                                }
                                Else
                                {
                                    Local0 = Zero
                                }
                            }
                            Else
                            {
                                Local0 = 0x02
                            }

                            ^^PCI0.LPCB.EC.FCMD = Zero
                        }
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x06))
                {
                    If (^^PCI0.LPCB.EC.ECOK)
                    {
                        ^^PCI0.LPCB.EC.FDAT = 0xA1
                        ^^PCI0.LPCB.EC.FCMD = 0xB8
                        If (One)
                        {
                            Local1 = ^^PCI0.LPCB.EC.FDAT /* External reference */
                            If ((B1B2 (^^PCI0.LPCB.EC.OE0M, ^^PCI0.LPCB.EC.OE1M) & 0x04))
                            {
                                If ((Local1 & One))
                                {
                                    Local0 = One
                                }
                                Else
                                {
                                    Local0 = Zero
                                }
                            }
                            Else
                            {
                                Local0 = 0x02
                            }

                            ^^PCI0.LPCB.EC.FCMD = Zero
                        }
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x07))
                {
                    If (^^PCI0.LPCB.EC.ECOK)
                    {
                        ^^PCI0.LPCB.EC.FDAT = 0xA1
                        ^^PCI0.LPCB.EC.FCMD = 0xB8
                        If (One)
                        {
                            Local1 = ^^PCI0.LPCB.EC.FDAT /* External reference */
                            If ((B1B2 (^^PCI0.LPCB.EC.OE0M, ^^PCI0.LPCB.EC.OE1M) & 0x10))
                            {
                                If ((Local1 & 0x04))
                                {
                                    Local0 = One
                                }
                                Else
                                {
                                    Local0 = Zero
                                }
                            }
                            Else
                            {
                                Local0 = 0x02
                            }

                            ^^PCI0.LPCB.EC.FCMD = Zero
                        }
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x09))
                {
                    If (^^PCI0.LPCB.EC.ECOK)
                    {
                        ^^PCI0.LPCB.EC.FDAT = 0xA1
                        ^^PCI0.LPCB.EC.FCMD = 0xB8
                        If (One)
                        {
                            Local1 = ^^PCI0.LPCB.EC.FDAT /* External reference */
                            If ((Local1 & 0x10))
                            {
                                Local0 = One
                            }
                            Else
                            {
                                Local0 = Zero
                            }

                            ^^PCI0.LPCB.EC.FCMD = Zero
                        }
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x0A))
                {
                    If (^^PCI0.LPCB.EC.ECOK)
                    {
                        ^^PCI0.LPCB.EC.FDAT = 0xA1
                        ^^PCI0.LPCB.EC.FCMD = 0xB8
                        If (One)
                        {
                            Local1 = ^^PCI0.LPCB.EC.FDAT /* External reference */
                            If ((B1B2 (^^PCI0.LPCB.EC.OE0M, ^^PCI0.LPCB.EC.OE1M) & 0x20))
                            {
                                If ((Local1 & 0x08))
                                {
                                    Local0 = One
                                }
                                Else
                                {
                                    Local0 = Zero
                                }
                            }
                            Else
                            {
                                Local0 = 0x02
                            }

                            ^^PCI0.LPCB.EC.FCMD = Zero
                        }
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x10))
                {
                    If (^^PCI0.LPCB.EC.SLFG)
                    {
                        Local0 |= One
                    }

                    If (\_TZ.TZ0.PPFG)
                    {
                        Local0 |= 0x02
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x11))
                {
                    If (^^PCI0.LPCB.EC.ECOK)
                    {
                        ^^PCI0.LPCB.EC.FDAT = 0xA1
                        ^^PCI0.LPCB.EC.FCMD = 0xB8
                        If (One)
                        {
                            Local1 = ^^PCI0.LPCB.EC.FDAT /* External reference */
                            If ((Local1 & 0x40))
                            {
                                Local0 = One
                            }
                            Else
                            {
                                Local0 = Zero
                            }

                            ^^PCI0.LPCB.EC.FCMD = Zero
                        }
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x12))
                {
                    If (^^PCI0.LPCB.EC.ECOK)
                    {
                        If ((B1B2 (^^PCI0.LPCB.EC.OE0M, ^^PCI0.LPCB.EC.OE1M) & 0x0800))
                        {
                            Local0 = One
                        }
                        Else
                        {
                            Local0 = Zero
                        }
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x32))
                {
                    If (^^PCI0.LPCB.EC.ECOK)
                    {
                        Local0 = B1B4 (^^PCI0.LPCB.EC.BD0C, ^^PCI0.LPCB.EC.BD1C, ^^PCI0.LPCB.EC.BD2C, ^^PCI0.LPCB.EC.BD3C)
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x33))
                {
                    If (^^PCI0.LPCB.EC.ECOK){}
                    Else
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x34))
                {
                    If (^^PCI0.LPCB.EC.ECOK){}
                    Else
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x38))
                {
                    Local0 = One
                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x39))
                {
                    Return (Zero)
                }

                If ((ToInteger (Arg1) == 0x3B))
                {
                    Noop
                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x3C))
                {
                    If (((PSF0 & 0x10) == Zero))
                    {
                        If (^^PCI0.GFX0.PDDS (0x0300))
                        {
                            Local0 = One
                        }
                        Else
                        {
                            Local0 = Zero
                        }
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x3D))
                {
                    If (^^PCI0.LPCB.EC.ECOK)
                    {
                        P80H = 0x61
                        ^^PCI0.LPCB.EC.FDAT = One
                        ^^PCI0.LPCB.EC.FCMD = 0xCA
                        Local0 = ^^PCI0.LPCB.EC.FBUF /* External reference */
                    }
                    Else
                    {
                        Local0 = Zero
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x3F))
                {
                    Local0 = Zero
                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x43))
                {
                    If (^^PCI0.LPCB.EC.ECOK){}
                    Else
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x44))
                {
                    ^^PCI0.LPCB.EC.FDAT = 0x03
                    ^^PCI0.LPCB.EC.FCMD = 0xCD
                    Local0 = ^^PCI0.LPCB.EC.FBUF /* External reference */
                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x45))
                {
                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x51))
                {
                    Noop
                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x52))
                {
                    PSF1 = (Local0 | 0x40000000)
                    PSF1 |= 0x00200000
                    Return (PSF1) /* External reference */
                }

                If ((ToInteger (Arg1) == 0x54))
                {
                    Return (VGAS) /* External reference */
                }

                If ((ToInteger (Arg1) == 0x62))
                {
                    Return (Zero)
                }

                If ((ToInteger (Arg1) == 0x63))
                {
                    If (^^PCI0.LPCB.EC.ECOK)
                    {
                        ^^PCI0.LPCB.EC.FDAT = 0x02
                        ^^PCI0.LPCB.EC.FCMD = 0xC0
                        Local1 = ^^PCI0.LPCB.EC.FDAT /* External reference */
                        Local2 = ^^PCI0.LPCB.EC.FBF2 /* External reference */
                        ^^PCI0.LPCB.EC.FDAT = 0x03
                        ^^PCI0.LPCB.EC.FCMD = 0xC0
                        Local1 = ^^PCI0.LPCB.EC.FDAT /* External reference */
                        Local0 = ^^PCI0.LPCB.EC.FBF2 /* External reference */
                        Local0 = ((Local0 << 0x08) | Local2)
                        Local0 = ((Local0 << 0x08) | Local1)
                        ^^PCI0.LPCB.EC.FCMD = Zero
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x64))
                {
                    If (^^PCI0.LPCB.EC.ECOK)
                    {
                        ^^PCI0.LPCB.EC.FDAT = Zero
                        ^^PCI0.LPCB.EC.FCMD = 0xC0
                        If (One)
                        {
                            Local0 = ^^PCI0.LPCB.EC.FDAT /* External reference */
                            Local2 = ^^PCI0.LPCB.EC.FBUF /* External reference */
                            Local3 = ^^PCI0.LPCB.EC.FBF1 /* External reference */
                            Local0 = ((Local0 << 0x08) | Local2)
                            Local0 = ((Local0 << 0x08) | Local3)
                            ^^PCI0.LPCB.EC.FCMD = Zero
                        }
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x6E))
                {
                    If (^^PCI0.LPCB.EC.ECOK)
                    {
                        ^^PCI0.LPCB.EC.FDAT = One
                        ^^PCI0.LPCB.EC.FCMD = 0xC0
                        If (One)
                        {
                            Local0 = ^^PCI0.LPCB.EC.FDAT /* External reference */
                            Local2 = ^^PCI0.LPCB.EC.FBUF /* External reference */
                            Local3 = ^^PCI0.LPCB.EC.FBF1 /* External reference */
                            Local0 = ((Local0 << 0x08) | Local2)
                            Local0 = ((Local0 << 0x08) | Local3)
                            ^^PCI0.LPCB.EC.FCMD = Zero
                        }
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x6F))
                {
                    If (^^PCI0.LPCB.EC.ECOK)
                    {
                        ^^PCI0.LPCB.EC.FDAT = 0x02
                        ^^PCI0.LPCB.EC.FCMD = 0xC0
                        If (One)
                        {
                            Local1 = ^^PCI0.LPCB.EC.FDAT /* External reference */
                            Local0 = ^^PCI0.LPCB.EC.FBF2 /* External reference */
                            Local0 |= (Local0 << 0x08)
                            Local0 = ((Local0 << 0x08) | Local1)
                            ^^PCI0.LPCB.EC.FCMD = Zero
                        }
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x70))
                {
                    If (^^PCI0.LPCB.EC.ECOK)
                    {
                        ^^PCI0.LPCB.EC.FDAT = 0x03
                        ^^PCI0.LPCB.EC.FCMD = 0xC0
                        If (One)
                        {
                            Local1 = ^^PCI0.LPCB.EC.FBUF /* External reference */
                            Local0 = ^^PCI0.LPCB.EC.FBF1 /* External reference */
                            Local0 |= (Local1 << 0x08)
                            ^^PCI0.LPCB.EC.FCMD = Zero
                        }

                        ^^PCI0.LPCB.EC.FDAT = 0x04
                        ^^PCI0.LPCB.EC.FCMD = 0xC0
                        If (One)
                        {
                            Local2 = ^^PCI0.LPCB.EC.FDAT /* External reference */
                            Local1 = ^^PCI0.LPCB.EC.FBUF /* External reference */
                            Local1 |= (Local2 << 0x08)
                            Local0 |= (Local1 << 0x10)
                            ^^PCI0.LPCB.EC.FCMD = Zero
                        }
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x71))
                {
                    If (^^PCI0.LPCB.EC.ECOK)
                    {
                        ^^PCI0.LPCB.EC.FDAT = 0x05
                        ^^PCI0.LPCB.EC.FCMD = 0xC0
                        If (One)
                        {
                            Local1 = ^^PCI0.LPCB.EC.FDAT /* External reference */
                            Local0 = ^^PCI0.LPCB.EC.FBUF /* External reference */
                            Local0 |= (Local1 << 0x08)
                            ^^PCI0.LPCB.EC.FCMD = Zero
                        }

                        ^^PCI0.LPCB.EC.FDAT = 0x02
                        ^^PCI0.LPCB.EC.FCMD = 0xC0
                        If (One)
                        {
                            Local2 = ^^PCI0.LPCB.EC.FBUF /* External reference */
                            Local1 = ^^PCI0.LPCB.EC.FBF1 /* External reference */
                            Local1 |= (Local2 << 0x08)
                            Local0 |= (Local1 << 0x10)
                            ^^PCI0.LPCB.EC.FCMD = Zero
                        }
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x73))
                {
                    Local1 = (INDX & 0xFFFF)
                    Local2 = ((INDX >> 0x10) & 0xFFFF)
                    If ((Local2 > 0x02))
                    {
                        Local2 = Zero
                    }

                    If ((Local1 > 0xFF))
                    {
                        Return (Zero)
                    }

                    Local2 = (One << Local2)
                    Local3 = Local2
                    Local3--
                    If (((Local1 + Local3) > 0xFF))
                    {
                        Return (Zero)
                    }

                    Local0 = (Local1 + 0xFF700100)
                    Name (RBUF, Buffer (0x04)
                    {
                         0x00, 0x00, 0x00, 0x00                           // ....
                    })
                    If (^^PCI0.LPCB.EC.ECOK)
                    {
                        OperationRegion (RH2M, SystemMemory, Local0, Local2)
                        Switch (ToInteger (Local2))
                        {
                            Case (One)
                            {
                                Field (RH2M, ByteAcc, Lock, Preserve)
                                {
                                    RHMB,   8
                                }

                                RBUF = RHMB /* \_SB_.WMI_.GCMD.RHMB */
                            }
                            Case (0x02)
                            {
                                Field (RH2M, ByteAcc, Lock, Preserve)
                                {
                                    RHMW,   16
                                }

                                RBUF = RHMW /* \_SB_.WMI_.GCMD.RHMW */
                            }
                            Case (0x04)
                            {
                                Field (RH2M, ByteAcc, Lock, Preserve)
                                {
                                    RHMD,   32
                                }

                                RBUF = RHMD /* \_SB_.WMI_.GCMD.RHMD */
                            }

                        }
                    }

                    Return (RBUF) /* \_SB_.WMI_.GCMD.RBUF */
                }

                If ((ToInteger (Arg1) == 0x77))
                {
                    Local0 = (BAEE >> One)
                    Local0 |= (BSCP << 0x08)
                    Local0 |= (BTCP << 0x10)
                    Return (Local0)
                }

                If ((ToInteger (Arg1) == 0x7A))
                {
                    Local0 = (PSF2 & 0xFFFFFFFFFFFFFBFF)
                    If (PSST)
                    {
                        Local0 |= 0x0400
                    }

                    If (PSST)
                    {
                        Local0 |= 0x0400
                    }

                    Local0 |= 0x02
                    Local0 |= 0x04
                    Local0 |= 0x10
                    Local0 |= 0x40
                    Local0 |= 0x4000
                    Local0 |= 0x00020000
                    Local0 |= 0x00080000
                    Local0 |= 0x00100000
                    Return (Local0)
                }

                Return (Ones)
            }
            Else
            {
                Return (\_SB.WMI.XCMD (Arg0, Arg1, Arg2))
            }
        }
    }

                      
                
    Scope (\_SB.PCI0.LPCB.EC)
    {
        OperationRegion (XRAM, SystemMemory, 0xFF700100, 0x0100)
        Field (XRAM, ByteAcc, Lock, Preserve)
        {
            Offset (0x16), 
            BD0C,   8, 
            BD1C,   8, 
            BD2C,   8, 
            BD3C,   8, 
            BF0C,   8, 
            BF1C,   8, 
            BF2C,   8, 
            BF3C,   8, 
            Offset (0x22), 
            BD0V,   8, 
            BD1V,   8, 
            BD2V,   8, 
            BD3V,   8, 
            BS0T,   8, 
            BS1T,   8, 
            BS2T,   8, 
            BS3T,   8, 
            BP0R,   8, 
            BP1R,   8, 
            BP2R,   8, 
            BP3R,   8, 
            BR0C,   8, 
            BR1C,   8, 
            BR2C,   8, 
            BR3C,   8, 
            BP0V,   8, 
            BP1V,   8, 
            BP2V,   8, 
            BP3V,   8, 
            Offset (0x3A), 
            BC0W,   8, 
            BC1W,   8, 
            BC2W,   8, 
            BC3W,   8, 
            BC0L,   8, 
            BC1L,   8, 
            BC2L,   8, 
            BC3L,   8, 
            Offset (0xCA), 
            OE0M,   8, 
            OE1M,   8
        }

        Method (_Q35, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                P80H = 0x35
                If (^^^^WMI.HKDR)
                {
                    If ((B1B2 (OE0M, OE1M) & 0x8000))
                    {
                        SLFG = One
                        ^^^^WMI.EVNT = 0xDE
                    }
                    Else
                    {
                        SLFG = Zero
                        ^^^^WMI.EVNT = 0xDF
                    }
                }

                Notify (WMI, 0xD0) // Hardware-Specific
                ^^^^AC.ADJP (Zero)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ35 ()
            }
        }

        Method (_Q37, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                P80H = 0x37
                Local0 = B1B2 (OE0M, OE1M)
                If ((Local0 & 0x2000))
                {
                    B15C = One
                }
                Else
                {
                    B15C = Zero
                }

                If ((NVBB & 0xFFFF))
                {
                    If (((PSF1 & 0x30) != 0x20))
                    {
                        BBST = Zero
                        Local1 = (NVBB & 0x0F)
                    }
                    Else
                    {
                        If ((Local0 & 0x2000))
                        {
                            Local1 = (((NVBB >> 0x08) & 0xFF) + (NVBB & 0xFF
                                ))
                            Local1--
                        }
                        Else
                        {
                            Local1 = (NVBB & 0x0F)
                        }

                        BBST = (((NVBB >> 0x04) & 0xF0) | Local1)
                    }

                    Notify (^^^PEG0.PEGP, (Local1 | 0xD0))
                }

                ^^^^AC.ADJP (Zero)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ37 ()
            }
        }
    }
                
                
                
                
                
                        
}