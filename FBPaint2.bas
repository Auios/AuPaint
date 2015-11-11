
#include "aulib.bi"

using auios

dim as AuWindow wnd
dim as AuMouse ms

wnd = AuWindowSet()
AuWindowCreate(wnd)

do
    screenlock
    cls
    
    AuMouseGet(ms)
    print ms.x,.ms.y
    screenunlock
    
    sleep 1,1
loop until inkey = chr(27)

AuWindowDestroy(wnd)

end 0