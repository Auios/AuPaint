#include "fbgfx.bi"
#include "crt.bi"
#include "aulib.bi"

#define DEBUG FALSE

using fb,auios

type AuBrush
    'Modes:
    '0  Circle
    
    as ubyte mode
    as ulong clr
    as ulong size,prePos
end type

declare sub init()
declare sub initAuBrush(byref thisAuBrush as AuBrush)

dim shared as AuWindow wnd
dim shared as AuMouse ms,oldMs
dim shared as AuBrush br

dim as any ptr canvas

const numOfLines = 2

wnd = AuWindowSet(800,600,16,1,0)
AuWindowCreate(wnd)

canvas = imageCreate(wnd.w,wnd.h,rgb(200,200,200),16)

init()
initAuBrush(br)

do
    AuMouseGet(ms)
    if(AuMouseCompare(ms,oldMs) <> 0) then
        oldMs = ms
        
        'Mouse wheel
        if(br.prePos <> ms.wheel) then
            if(br.prePos < ms.wheel) then
                br.size+=1
            else
                if(br.size > 1) then br.size-=1
            end if
            
            br.prePos = ms.wheel
        end if
        
        screensync
        
        screenlock
            put(0,0),canvas,trans
            
            line(0,0)-(wnd.w-1,(numOfLines*10)+5),rgb(200,100,100),bf
                draw string(5,5),"" & ms.x & " : " & ms.y
                draw string(5,15),"" & ms.state & " : " & ms.buttons
            
            circle(ms.x,ms.y),br.size,rgb(255,255,255)
            
            if(ms.buttons = 1) then
                circle canvas,(ms.x,ms.y),br.size,br.clr,,,,f
            elseif(ms.buttons = 2) then
                circle canvas,(ms.x,ms.y),br.size,rgb(200,200,200),,,,f
            end if
            
        screenunlock
        
    #if (DEBUG = TRUE)
        printf(!"Change!\n")
    else
        printf(!"No change!\n")
    #endif
    end if
    
    sleep 1,1
loop until inkey = chr(27)

imageDestroy(canvas)
end AuWindowDestroy(wnd)

sub init()
    AuMouseGet(ms)
    br.prePos = ms.wheel
    
    line(0,0)-(wnd.w-1,wnd.h-1),rgb(200,200,200),bf
end sub

sub initAuBrush(byref thisBrush as AuBrush)
    thisBrush.size = 15
    thisBrush.clr = rgb(100,100,100)
end sub
