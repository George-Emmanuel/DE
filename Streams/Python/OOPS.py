class GenshinCharacter:
    def __init__(self, name, element, hp, atk, defense):
        self.name = name
        self._element = element
        self.hp = hp
        self.atk = atk
        self.defense = defense

    @property
    def element(self):
        return self._element

    def normal_attack(self):
        print(f"{self.name} attacks an enemy with {self.atk} DMG")

    def elemental_skill(self):
        print(f"{self.name} skills an enemy with {self.atk * 2} DMG")

    def ultimate(self):
        print(f"{self.name} ultimates an enemy with {self.atk * 10} DMG")

    def take_damage(self, damage):
        self.hp -= damage
        if self.hp <= 0:
            print(f"{self.name} is gone")
        else:
            print(f"{self.name} is hit by an enemy and is now at {self.hp} HP")

    def burst(self):
        raise NotImplementedError

    @classmethod
    def trial_character(cls, name):
        return cls(name, element="Pyro", hp=1, atk=1, defense=1)

    @classmethod
    def banner_character(cls, name, hp, atk, defense):
        return cls(name, element="Pyro", hp=hp, atk=atk, defense=defense)

class PyroCharacter(GenshinCharacter):
    def burst(self):
        print(f"{self.name} unleashes a Pyro burst!")

class CryoCharacter(GenshinCharacter):
    def burst(self):
        print(f"{self.name} unleashes a Cryo burst!")

class Weapon:
    def __init__(self, name, atk):
        self.name = name
        self.atk = atk

class Reaction:
    @staticmethod
    def get_reaction(element1, element2):
        if {element1, element2} == {"Pyro", "Cryo"}:
            return "Melt"
        elif (element1 in ["Pyro", "Hydro"] or element2 in ["Pyro", "Hydro"]) and (element1 != element2):
            return "Vaporize"
        elif (element1 in ["Pyro", "Electro"] or element2 in ["Pyro", "Electro"]) and (element1 != element2):
            return "Overload"
        elif (element1 in ["Pyro", "Dendro"] or element2 in ["Pyro", "Dendro"]) and (element1 != element2):
            return "Burn"
        elif element2 == "Anemo" and element1 not in ["Geo", "Dendro"]:
            return "Swirl"
        elif element2 == "Geo" and element1 not in ["Geo", "Anemo"]:
            return "Crystallize"
        return None

    @staticmethod
    def get_multiplier(element1, element2):
        if element1 == "Pyro" and element2 == "Cryo":
            return 2
        elif element1 == "Cryo" and element2 == "Pyro":
            return 1.5
        elif element1 == element2:
            return 0
        return 1

# Creating Character Objects using GenshinCharacter class
diluc = GenshinCharacter("Diluc", "Pyro", 1000, 100, 100)
ayaka = GenshinCharacter("Ayaka", "Cryo", 800, 200, 50)
mavuika = GenshinCharacter("Mavuika", "Pyro", 1800, 200, 50)
columbina = GenshinCharacter("Columbina", "Hydro", 400, 1200, 500)
bennett = PyroCharacter("Bennett", "Pyro", 10, 5000, 50)
ganyu = CryoCharacter("Ganyu", "Cryo", 10000, 20, 50)

# Creating Character Objects using GenshinCharacter class
widsith = Weapon("Widsith", 120)

# Accessing the Objects Attributes
print("<-- Accessing the Objects Attributes -->")
diluc.atk = 1200
print("Diluc's ATK: " + str(diluc.atk))

# ayaka.element = "Electro"
# You get an error for above line since it's protected attribute
print("Ayaka's Element: " + str(ayaka.element))

print("\n********************************************\n")

# Utilising methods inside the class
print("<-- Utilising methods inside the class -->")
diluc.normal_attack()
ayaka.elemental_skill()
ayaka.ultimate()
diluc.elemental_skill()

print("\n********************************************\n")

# 1. INHERITANCE - Single, Multiple, Multi-level & Hierarchical
# Even though Pyro character does not have elemental skill method,
# we were able to use it as PyroCharacter "INHERITS" all the methods
# from GenshinCharacter
print("<-- Utilising methods by inheriting the methods from parent class -->")
bennett.elemental_skill()

print("\n")

# 2. POLYMORPHISM - Method Overloading & Method Overriding
# Here burst is same method name, but it behaves differently (unleashes cryo burst instead of pyro burst)
print("<-- Utilising same method name but in diff class thereby different behaviour -->")
team = [PyroCharacter("Durin", "Pyro", 10, 6000, 50),
        CryoCharacter("Charlotte", "Cryo", 200, 20, 50)]
for char in team:
    char.burst()

# 3. ENCAPSULATION -
# Access Modifiers --> Public, Protected & Private
# Method Modifiers --> @classmethod, @staticmethod & @property

# 4. ABSTRACTION -
# An abstract class can only be inherited.
# Only an object of the derived class can access the features of the abstract class.

print("\n********************************************\n")

# Calling a Static Methods
# Used where there is pure logic and no change in data or logic
# In this case Dmg formula won't change
element_1 = "Pyro"
element_2 = "Cryo"
end_reaction = Reaction().get_reaction(element_1, element_2)
end_multiplier = Reaction().get_multiplier(element_1, element_2)
print(f"{element_1} reacts with {element_2} to get " + str(end_reaction) + " --> " + str(end_multiplier) + " Reaction Multiplier")

# Calling a Class method
# Used where we want the method to be applied for all objects in the class and not only "SELF"
trial_xiangling = GenshinCharacter.trial_character("Xiangling")
xiangling = GenshinCharacter.banner_character("Xiangling", 100, 125, 50)
print("Attack Number of Trial Xiangling --> " + str(trial_xiangling.atk))
print("Attack Number of Banner Xiangling --> " + str(xiangling.atk))