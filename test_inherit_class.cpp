/**
* @author tsf
* @date 18-4-30
* @desc
*/

#include <iostream>

using namespace std;

class student {
private:
    string name;
    string id;
public:
    void printInfo();
    void setInfo(string name, string id);
};

class graduateStudent:public student {
private:
    string department;
public:
    void printInfo();
    void setInfo(string name, string id, string department);
};

int main() {

    graduateStudent student1;
    student1.setInfo("iflytang", "123456789", "Electronic Engineering");
    student1.printInfo();

    return 0;
}

void student::printInfo() {
    cout << "name: " << name << endl;
    cout << "id: " << id << endl;
}

void student::setInfo(string name, string id) {
    this->name = name;
    this->id = id;
}

void graduateStudent::printInfo() {
    student::printInfo();
    cout << "department: " << department << endl;
}

void graduateStudent::setInfo(string name, string id, string department) {
    student::setInfo(name, id);
    this->department = department;
}