class GenshinCharacter:
    def __init__(self, name, element, hp, atk, defense):
        self.name = name
        self.element = element
        self.hp = hp
        self.atk = atk
        self.defense = defense

    def normal_attack(self):
        print(f"{self.name} attacks an enemy with {self.atk} DMG")

    def elemental_skill(self):
        print(f"{self.name} attacks an enemy with {self.atk * 2} DMG")

    def ultimate(self):
        print(f"{self.name} attacks an enemy with {self.atk * 10} DMG")

    def take_damage(self, damage):
        self.hp -= damage
        print(f"{self.name} is hit by an enemy and is now at {self.hp} HP")

class PyroCharacter(GenshinCharacter):
    pass

# Creating Character Objects using GenshinCharacter class
diluc = GenshinCharacter("Diluc", "Pyro", 1000, 100, 100)
ayaka = GenshinCharacter("Ayaka", "Cryo", 800, 200, 50)

# Accessing the Objects Attributes
print("<-- Accessing the Objects Attributes -->")
print("Diluc's Element: " + str(diluc.element))
print("Ayaka's ATK: " + str(ayaka.atk))

print("\n********************************************\n")

# Utilising methods inside the class
print("<-- Utilising methods inside the class -->")
diluc.normal_attack()
ayaka.elemental_skill()
ayaka.ultimate()
diluc.elemental_skill()

print("\n********************************************\n")

