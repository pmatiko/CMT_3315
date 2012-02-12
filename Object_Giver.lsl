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
       
        llSay(0,"Gave a folder to "+llList2String(gAvatars,0));
    }
    collision_start(integer total_number) {
        
        integer i;
        integer numAvs = llGetListLength(gAvatars);
        string folder = "Paul";
        list inventory;
        string name;
        
        for(i=0; i<llGetInventoryNumber(INVENTORY_OBJECT);i++){
            name = llGetInventoryName(INVENTORY_OBJECT,i);
            if(llGetScriptName() != name){
                inventory+=name;
            }
        }
               
        for (i=0; i<total_number; i++) {
           if (llListFindList(gAvatars,[llDetectedName(i)]) == -1) {
               add_avatar(llDetectedName(i));
            if (llDetectedName(i)==llList2String(gAvatars,0)) { 
                 
             llGiveInventoryList(llDetectedKey(i),folder,inventory);  
            }
            else{
                llSay(0,"Fuck off mate");
            }
        }
    }
}
}