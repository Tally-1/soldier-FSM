// Module description (must inherit from base class, otherwise pre-defined entities won't be available):
class ModuleDescription : ModuleDescription
{
    description[] = {
    "Virtualization module.",
    "This module virtualizes all FIPOs within its area.",
    "The module will ''un-virtualize'' the FIPOs once activated according to its settings.",
    "With missons containg many FIPOs this will help performance.",
    "-----------------------------------------------------------------",
    "!WARNING!",
    "Do not use Activation Zones in combination with Virtualization modules,",
    "The FIPOs will become useless upon reactivation"

    };
    
    position  = 2;  // Position is taken into effect
    direction = 2;  // Direction is taken into effect
    optional  = 2;  // Synced entity is optional
    duplicate = 0;  // Multiple entities of this type can be synced

    synced[]  = {"AnyPerson", "GroupModifiers"};
};