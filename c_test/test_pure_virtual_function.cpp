/**
* @author tsf
* @date 18-5-1
* @desc
*/

#include <iostream>

using namespace std;

class Creature {    // abstract class
public:
    virtual void show() = 0;    // pure virtual function, should be implemented by derived class
    virtual ~Creature();        // virtual destructor function, can destruct real object pointer
    Creature();                 // constructor cannot be virtual
};

Creature::~Creature() {
    cout << "Creature::destructor called." << endl;
}

Creature::Creature() {
    cout << "Creature::constructor called." << endl;
}

class Cat : public Creature {
public:
    virtual void show();
    virtual ~Cat();
    Cat();
};

void Cat::show() {
    cout << "Cat: I am a cat, meow ~" << endl;
}

Cat::~Cat() {
    cout << "Cat::destructor called." << endl;
}

Cat::Cat() {
    cout << "Cat::constructor called." << endl;
}

class Dog : public Creature {
public:
    virtual void show();
    virtual ~Dog();
    Dog();
};

void Dog::show() {
    cout << "Dog: I am a dog, wang ~" << endl;
}

Dog::~Dog() {
    cout << "Dog::destructor called." << endl;
}

Dog::Dog() {
    cout << "Dog::constructor called." << endl;
}

int main() {

    Creature *p1 = new Cat();
    Creature *p2 = new Dog();
    cout << endl;


    p1->show();
    p2->show();
    cout << endl;

    delete(p1);
    delete(p2);

    return 0;
}