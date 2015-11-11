#include "fbgfx.bi"
#include "aulib.bi"

using auios

type AuMouse
    as long state
    as long x,y
    as long wheel
    as long buttons
    as long clip
end type

type AuBrush
    'Modes:
    '0  Circle
    '
    as ubyte mode
    as ulong clr
    as ulong size
end type

declare function AuMouseGet() as AuMouse
declare sub drawOnScreen(x1 as long,y1 as long,x2 as long,y2 as long,tmpBrush as AuBrush)

dim as AuWindow wnd = AuWindowSet()
dim as AuMouse ms

AuWindowCreate(wnd)

do
    ms = AuMouseGet()
    
    screenlock
    cls
    draw string(5,5),"" & ms.x & " : " & ms.y
    draw string(5,15),"" & ms.state & " : " & ms.buttons
    screenunlock
    
    sleep 1,1
loop while inkey <> chr(27)

AuWindowDestroy(wnd)

function AuMouseGet() as AuMouse
    dim as AuMouse thisMs
    with thisMs
        .state = getMouse(.x,.y,.wheel,.buttons,.clip)
    end with
    return thisMs
end function