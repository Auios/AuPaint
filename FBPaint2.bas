#include "fbgfx.bi"
#include "aulib.bi"

using fb,auios

type AuBrush
    'Modes:
    '0  Circle
    
    as ubyte mode
    as ulong clr
    as ulong size,prePos
    
    declare constructor()
end type

dim as AuWindow wnd
dim as AuMouse ms
dim as AuBrush br

wnd = AuWindowSet(800,600,16,1,0)
AuWindowCreate(wnd)

do
    AuMouseGet(ms)
    
    'Mouse wheel
    if(br.prePos <> ms.wheel) then
        if(br.prePos < ms.wheel) then
            br.size+=1
        else
            if(br.size > 1) then br.size-=1
        end if
        
        br.prePos = ms.wheel
    end if
    
    'Clicking
    
    
    screenlock
        cls
        
        draw string(5,5),"" & ms.x & " : " & ms.y
        draw string(5,15),"" & ms.state & " : " & ms.buttons
        
        if(ms.buttons = 1) then
            circle(ms.x,ms.y),br.size,,,,,f
        else
            circle(ms.x,ms.y),br.size
        end if
        
    screenunlock
    
    sleep 1,1
loop until inkey = chr(27)

end AuWindowDestroy(wnd)

constructor AuBrush
    this.size = 15
end constructor
