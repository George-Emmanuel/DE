print("******************** Data Types ********************")

a_integer = 123
a_float = 3.14
a_string = "Hello World"
a_list = [1, 2, 3]
a_tuple = (1, 2, 3)
a_dictionary = {'key1': 'value1', 'key2': 'value2'}
a_complex = (1 + 2j)

print(str(a_integer) + " -> " + str(type(a_integer)))
print(str(a_float) + " -> " + str(type(a_float)))
print(str(a_string) + " -> " + str(type(a_string)))
print(str(a_list) + " -> " + str(type(a_list)))
print(str(a_tuple) + " -> " + str(type(a_tuple)))
print(str(a_dictionary) + " -> " + str(type(a_dictionary)))
print(str(a_complex) + " -> " + str(type(a_complex)))

print("Scalar Values: int, float, string")
print("Aggregated Values: list, tuple, dict")

print("\n")
print("******************** Reference ********************")

var_a = 123
id_a = id(var_a)
print("var_a = " + str(var_a))
print("id_a = " + str(id_a))

print("\n")
print("******************** Operators ********************")

print("******************** 1. Arithmetic Operators ********************")
x = 12
y = 15
addition = x + y
subtraction = x - y
multiplication = x * y
division = x / y
modulo = x % y
integer_division = x // y
exponentiation = x ** y

print("x = " + str(x))
print("y = " + str(y))
print("addition = " + str(addition))
print("subtraction = " + str(subtraction))
print("multiplication = " + str(multiplication))
print("division = " + str(division))
print("modulo = " + str(modulo))
print("integer_division = " + str(integer_division))
print("exponentiation = " + str(exponentiation))

print("******************** 2. Comparison Operators ********************")

print("x == y -> " + str(x == y))
print("x != y -> " + str(x != y))
print("x > y -> " + str(x > y))
print("x < y -> " + str(x < y))
print("x >= y -> " + str(x >= y))
print("x <= y -> " + str(x <= y))

print("******************** 3. Logical Operators ********************")

print("x == y and x < y -> " + str(x == y and x < y))
print("x != y and x > y -> " + str(x != y and x > y))
print("x < y or x > y -> " + str(x < y or x > y))
print("x > y or x < y -> " + str(x > y or x < y))
print("not x -> " + str(not x))
print("not y -> " + str(not y))

print("******************** 4. Identity & Membership Operators ********************")

X = [1, 2, 3]
Y = [4, 5, 6]
print("1 in X -> " + str(1 in X))
print("1 in Y -> " + str(1 in Y))
print("1 not in X -> " + str(1 not in X))
print("1 not in Y -> " + str(1 not in Y))
print("[1,2,3] is X -> " + str([1,2,3] is X))
print("[1,2,3] is Y -> " + str([1,2,3] is Y))
print("[1,2,3] is not X -> " + str([1,2,3] is not X))
print("[1,2,3] is not Y -> " + str([1,2,3] is not Y))

print("\n")

print("******************** String Functions ********************")

s = "Hello World"
arr = ["Hello", "World"]
print("Upper -> " + s.upper())
print("Lower -> " + s.lower())
print("Capitalize -> " + s.capitalize())
print("Strip -> " + s.strip())
print("Split -> " + str(s.split(" ")))
print("Join -> " + " ".join(arr))

print("\n")

print("******************** File Handling Functions ********************")
file_read = open(r"C:\Users\georg\OneDrive\Desktop\Data Engineering\DE\Hands-on Exercise\read.txt", "r")
content = file_read.read()
print("content ->  ")
print(content)
print("\n")

# Everytime you want to perform read operation
# Make sure the pointer is at the beginning of the file
# using file_read.seek(0)
file_read.seek(0)
line = file_read.readline()
print("readline() ->  ")
print(line)
print("\n")

# Everytime you want to perform read operation
# Make sure the pointer is at the beginning of the file
# using file_read.seek(0)
file_read.seek(0)
lines = file_read.readlines()
print("readlines() ->  ")
print(lines)
print("\n")

# Opens a new file every time to write
file_write = open(r"C:\Users\georg\OneDrive\Desktop\Data Engineering\DE\Hands-on Exercise\write.txt", "w")
file_write.write(content)
file_write.close()

# Writes to an existing file without modifying any contents
file_append = open(r"C:\Users\georg\OneDrive\Desktop\Data Engineering\DE\Hands-on Exercise\append.txt", "a")
file_append.write("Hello World\n")
file_append.close()