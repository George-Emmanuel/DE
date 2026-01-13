global_var_a = "Hello"
global_var_b = "World"
global_var_c = None
global_var_d = None
global_var_e = None

def simple_print_function_without_args():
    print("hello")

def simple_print_function_with_args(a, b):
    print(a + " - " + b)

def function_without_return(a, b):
    c = a + b

def function_with_return(a, b):
    c = a + " -- " + b
    return c

def function_return_first_10_squares():
    return [i ** 2 for i in range(1, 10 + 1)]

def generator_return_first_10_squares():
    for i in range(1, 11):
        yield i ** 2


# Calling the function simple_print_function_without_args.
simple_print_function_without_args()

# Calling the function simple_print_function_with_args.
simple_print_function_with_args(global_var_a, global_var_b)

# Calling the function without return
global_var_c_without_return = function_without_return(global_var_a, global_var_b)
print("Function without return -> ", global_var_c_without_return)

# Calling the function with return
global_var_c_with_return = function_with_return(global_var_a, global_var_b)
print("Function with Return -> " + str(global_var_c_with_return))

# Calling function_return_first_10_squares
global_var_d_function = function_return_first_10_squares()
print("Function for First 10 Squares -> " + str(global_var_d_function))

# Calling generator_return_first_10_squares
global_var_d_generator = generator_return_first_10_squares()
print("Generator for First 10 Squares -> " + str(global_var_d_generator))
print("First Value == " + str(global_var_d_generator.__next__()))
print("Second Value == " + str(global_var_d_generator.__next__()))
print("Third Value == " + str(global_var_d_generator.__next__()))

print("\n")
print("******************* Lambda Function ********************")

# Lambda Function
prices = [10, 20, 30]
print("Prices: " + str(prices))
with_GST = list(map(lambda x: x * 1.07, prices))
print("With Tax -> " + str(with_GST))

print("\n")

users = [{"name": "Alice", "age": 30, "income": 100}, {"name": "Bob", "age": 25, "income": 2200}, {"name": "Xavier", "age": 20, "income": 3200}]
print("Users -> " + str(users))
name_sorted = sorted(users, key=lambda user: user["name"])
print("Users sorted by name -> " + str(name_sorted))
age_sorted = sorted(users, key=lambda user: user["age"])
print("Users sorted by age -> " + str(age_sorted))
income_sorted = sorted(users, key=lambda user: user["income"])
print("Users sorted by income -> " + str(income_sorted))

name_filtered = list(filter(lambda x: "o" in x["name"], users))
print("Users with letter O in their name -> " + str(name_filtered))
