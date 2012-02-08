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
        if (llDetectedKey(0) == llGetOwner()){
            integer i;
            integer numAvs = llGetListLength(gAvatars);
            for (i=0; i<numAvs; i++){
                llOwnerSay("Gave"+"a"+""+llGetInventoryName(INVENTORY_OBJECT,0)+llList2String(gAvatars, i));
            }
            gAvatars = []; 
        }
    }
    collision_start(integer total_number) {
       integer i;
       for (i=0; i<total_number; i++) {
           if (llListFindList(gAvatars,[llDetectedName(i)]) == -1) {
               // Pick out the first NOTECARD and offer it
               llGiveInventory(llDetectedKey(i),llGetInventoryName(INVENTORY_OBJECT,0));
               add_avatar(llDetectedName(i));
           }
       }
    }
}
