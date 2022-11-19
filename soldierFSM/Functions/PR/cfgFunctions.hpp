/*
*  cfgFunctions.hpp  for headlessClients
*  Author: PapaReap
*/

class SFSM_PR_hc {
    class headlessClient {
        file = "\soldierFSM\Functions\PR\functions\headlessClient";
        // Main headless startup
        class hcCheck { postInit = 1; description = "Sets Headless Clients variables for the mission"; };
        class hcTracker { description = "Watches for headless client connect and disconnect durning mission"; };
        class passToHCs { description = "Load balances ai to headless clients"; };
        class aiSpawner { description = "Spreads out spawns between server and headless clients"; };

        // Extras
        class checkSpawner { description = "Condition Check if unit is allow to run spawn script"; };
        class setAiOwner { description = "Keeps spawned units set to spawn owner"; };
    };
};

class SFSM_PR_main {
    class main {
        file = "\soldierFSM\Functions\PR\functions\main";
        class getOwner { description = "Sever finds owner id"};
    };
};
