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

declare sub init()

dim shared as AuWindow wnd
dim shared as AuMouse ms
dim shared as AuBrush br

const numOfLines = 2

wnd = AuWindowSet(800,600,16,1,0)
AuWindowCreate(wnd)

init()

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
    
    screenlock
        line(0,0)-(wnd.w-1,(numOfLines*10)+5),rgb(200,100,100),bf
            draw string(5,5),"" & ms.x & " : " & ms.y
            draw string(5,15),"" & ms.state & " : " & ms.buttons
        
        if(ms.buttons = 1) then
            circle(ms.x,ms.y),br.size,br.clr,,,,f
        elseif(ms.buttons = 2) then
            circle(ms.x,ms.y),br.size,rgb(200,200,200),,,,f
        end if
        
    screenunlock
    
    sleep 1,1
loop until inkey = chr(27)

end AuWindowDestroy(wnd)

sub init()
    AuMouseGet(ms)
    br.prePos = ms.wheel
    
    line(0,0)-(wnd.w-1,wnd.h-1),rgb(200,200,200),bf
end sub

constructor AuBrush
    this.size = 15
    this.clr = rgb(100,100,100)
end constructor
