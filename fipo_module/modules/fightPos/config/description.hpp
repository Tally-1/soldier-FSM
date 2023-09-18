// Module description (must inherit from base class, otherwise pre-defined entities won't be available):
class ModuleDescription : ModuleDescription
{
    description[] = {
    "Synced soldiers will be placed here facing the direction of the module",
    "If the position is available then nearby soldiers will move into the position.",
    "Use the VR indicators to select the correct stances for shooting and taking cover.",
    "You can allow the position to be outflanked / overrun.",
    "If the position is outflanked / overrun the position will be abandoned."

    };
    
    position  = 2;  // Position is taken into effect
    direction = 2; // Direction is taken into effect
    optional  = 2;  // Synced entity is optional
    duplicate = 2; // Multiple entities of this type can be synced
    synced[]  = {"AnyPerson", "GroupModifiers"};
};