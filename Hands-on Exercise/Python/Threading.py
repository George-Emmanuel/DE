"""
PYTHON THREADING
"""

import threading
import time
from queue import Queue

print("\n==============================")
print("1️⃣ WHAT IS A THREAD?")
print("==============================")
"""
A thread is a lightweight unit of execution inside a process.

• A process has its own memory.
• Threads SHARE the same memory inside a process.
• Threads run "concurrently" (not truly parallel for CPU-bound work due to GIL).

Main thread = the thread that starts your program.
"""

print(f"Main thread name: {threading.current_thread().name}")

time.sleep(1)

print("\n==============================")
print("2️⃣ CREATING A THREAD")
print("==============================")


def simple_task():
    print(f"[{threading.current_thread().name}] Task started")
    time.sleep(1)
    print(f"[{threading.current_thread().name}] Task finished")


t1 = threading.Thread(target=simple_task)
t1.start()
t1.join()  # wait for thread to finish

print("Main thread continues...\n")

print("\n==============================")
print("3️⃣ THREAD WITH ARGUMENTS")
print("==============================")


def greet(name, delay):
    time.sleep(delay)
    print(f"[{threading.current_thread().name}] Hello {name}")


t2 = threading.Thread(target=greet, args=("Alice", 1))
t3 = threading.Thread(target=greet, args=("Bob", 2))

t2.start()
t3.start()

t2.join()
t3.join()

print("\n==============================")
print("4️⃣ DAEMON vs NON-DAEMON THREADS")
print("==============================")
"""
• Non-daemon threads keep the program alive.
• Daemon threads die when main thread exits.
"""


def background_task():
    while True:
        print("[Daemon] Running in background...")
        time.sleep(0.5)


daemon_thread = threading.Thread(target=background_task, daemon=True)
daemon_thread.start()

time.sleep(2)
print("Main thread exiting → daemon thread will stop\n")

print("\n==============================")
print("5️⃣ RACE CONDITION (PROBLEM)")
print("==============================")
"""
Race condition occurs when:
• Multiple threads modify shared data.
• Final result depends on timing.
"""

counter = 0


def increment():
    global counter
    for _ in range(100000):
        counter += 1


threads = [threading.Thread(target=increment) for _ in range(2)]

for t in threads:
    t.start()

for t in threads:
    t.join()

print(f"Counter value (WRONG): {counter}")

print("\n==============================")
print("6️⃣ LOCK (SOLUTION)")
print("==============================")

counter = 0
lock = threading.Lock()


def safe_increment():
    global counter
    for _ in range(100000):
        with lock:  # acquire + release automatically.
            counter += 1


threads = [threading.Thread(target=safe_increment) for _ in range(2)]

for t in threads:
    t.start()

for t in threads:
    t.join()

print(f"Counter value (CORRECT): {counter}")

print("\n==============================")
print("7️⃣ RLOCK (RE-ENTRANT LOCK)")
print("==============================")

rlock = threading.RLock()


def recursive_lock(n):
    with rlock:
        print(f"Lock acquired at level {n}")
        if n > 0:
            recursive_lock(n - 1)


recursive_lock(3)

print("\n==============================")
print("8️⃣ EVENT (THREAD COMMUNICATION)")
print("==============================")

event = threading.Event()


def waiter():
    print("Waiting for event...")
    event.wait()
    print("Event received!")


def setter():
    time.sleep(2)
    print("Setting event")
    event.set()


threading.Thread(target=waiter).start()
threading.Thread(target=setter).start()

time.sleep(3)

print("\n==============================")
print("9️⃣ CONDITION (WAIT / NOTIFY)")
print("==============================")

condition = threading.Condition()
items = []


def consumer():
    with condition:
        while not items:
            print("Consumer waiting...")
            condition.wait()
        print(f"Consumed: {items.pop()}")


def producer():
    time.sleep(1)
    with condition:
        items.append("Item")
        print("Produced item")
        condition.notify()


threading.Thread(target=consumer).start()
threading.Thread(target=producer).start()

time.sleep(2)

print("\n==============================")
print("🔟 SEMAPHORE (LIMIT THREADS)")
print("==============================")

semaphore = threading.Semaphore(2)


def limited_task(i):
    with semaphore:
        print(f"Task {i} running")
        time.sleep(2)
        print(f"Task {i} done")


for i in range(5):
    threading.Thread(target=limited_task, args=(i,)).start()

time.sleep(6)

print("\n==============================")
print("1️⃣1️⃣ QUEUE (THREAD-SAFE)")
print("==============================")

queue = Queue()


def producer_q():
    for i in range(5):
        queue.put(i)
        print(f"Produced {i}")
        time.sleep(0.5)


def consumer_q():
    while True:
        item = queue.get()
        print(f"Consumed {item}")
        queue.task_done()


threading.Thread(target=consumer_q, daemon=True).start()
threading.Thread(target=producer_q).start()

queue.join()

print("\n==============================")
print("1️⃣2️⃣ THREAD NAMING")
print("==============================")


def named_task():
    print(f"Running in {threading.current_thread().name}")


threading.Thread(target=named_task, name="Worker-1").start()

time.sleep(1)

print("\n==============================")
print("1️⃣3️⃣ EXCEPTIONS IN THREADS")
print("==============================")


def faulty():
    raise ValueError("Something went wrong!")


def safe_wrapper():
    try:
        faulty()
    except Exception as e:
        print(f"Caught exception: {e}")


threading.Thread(target=safe_wrapper).start()

time.sleep(1)

print("\n==============================")
print("1️⃣4️⃣ THE GIL (IMPORTANT)")
print("==============================")
"""
GIL = Global Interpreter Lock

• Only ONE thread executes Python bytecode at a time
• Threading is GREAT for:
    - I/O-bound tasks (network, files, sleep)
• Threading is BAD for:
    - CPU-bound tasks (math, loops)
"""

print("\n==============================")
print("1️⃣5️⃣ WHEN TO USE THREADING")
print("==============================")
"""
USE THREADING WHEN:
✔ Network calls
✔ File I/O
✔ Waiting on APIs
✔ Background tasks

DON'T USE THREADING WHEN:
✖ Heavy CPU computation → use multiprocessing
"""

print("\n==============================")
print("✅ END OF THREADING")
print("==============================")

print("\n==============================")
print("✅ EXAMPLE OF THREADING")
print("==============================")

user_database = [
    ["Alice", "Female", 22],
    ["Bob", "Male", 25],
    ["Catherine", "Female", 23],
    ["Daniel", "Male", 26]
]

q = Queue()
name_length_array = []

def func_1():   # Producer
    for user in user_database:
        name = user[0]
        q.put(name)         # send data to consumer
        print("Produced:", name)
        time.sleep(1)

    q.put(None)             # stop signal

def func_2():   # Consumer
    while True:
        name = q.get()      # blocks until data is available
        if name is None:
            break

        name_length_array.append(len(name))
        print("Consumed:", name, "→", name_length_array)

t1 = threading.Thread(target=func_1)
t2 = threading.Thread(target=func_2)

t1.start()
t2.start()

t1.join()
t2.join()
