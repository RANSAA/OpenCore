/*
 * GPI0 enable
 * 
 * old name:SSDT-OCGPI0-GPEN
 * now name:SSDT-GPI0
 *
 */
DefinitionBlock("", "SSDT", 2, "OCLT", "GPI0", 0)
{
    External(GPEN, FieldUnitObj)
    External(SBRG, FieldUnitObj)
    
    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            GPEN = One
            SBRG = One
        }
    }
}
//EOF