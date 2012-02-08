integer MEMORY_LENGTH = 25;
list gAvatars;
add_avatar(string name) {
    gAvatars += name;
    if (llGetListLength(gAvatars) > MEMORY_LENGTH) {
       gAvatars = llDeleteSubList(gAvatars,0,0);
    }
}
default {
    state_entry() {
       llVolumeDetect(TRUE);
    }
    touch_start(integer num) { // report who received notecard
       
        llSay(0,"Gave a"+llGetInventoryName(INVENTORY_OBJECT,0)+" to "+llList2String(gAvatars,0));
    }
    collision_start(integer total_number) {
        integer i;
        integer numAvs = llGetListLength(gAvatars);
               
        for (i=0; i<total_number; i++) {
           if (llListFindList(gAvatars,[llDetectedName(i)]) == -1) {
               add_avatar(llDetectedName(i));
               
            if (llDetectedName(i)==llList2String(gAvatars,0)) {  
             //llGiveInventory(llDetectedKey(i),llGetInventoryName(INVENTORY_OBJECT,0)); 
             llSay(0,llList2String(gAvatars,0)); 
            }
            else{
                llSay(0,"Fuck off mate");
            }
        }
    }
}
}