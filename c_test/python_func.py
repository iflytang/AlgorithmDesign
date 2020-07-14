# hello.py
class Hello:
    def __init__(self, x):
        self.a = x
        self.printx(self.a)

    def printx(self, x=None):
        print(x)
        return x+1

def xprint():
    print("hello world x")
    return 1

if __name__ == "__main__":
    xprint()
    h = Hello(5)
    h.printx()