# AlgorithmDesign

This semester I attend a class, which is Design and Analysis of Algorithm. And the repository will keep my program code of homework.
It just records my code. Get C++ program back.

## Run

if you want to run the code in Linux, you should follow the steps. Take 1-5.cpp as an example.

- compile 

please add ```-std=c++11``` when you compile the code. If not, may encounter problems. see [problem](https://stackoverflow.com/questions/28521561/why-this-compiler-error-no-matching-function-for-call-to-stdbasic-ofstream).
```
g++ -std=c++11 1-5.cpp -o exampleCodeName
```

- run

if your ```int main(int argc, char * argv[])```, then you can add some console parameters when you runs it. 
These parameters will be stored in array ```argv[]```, whose ```argv[0]``` is the file name of executed code.
And the value of ```argc``` is the number of parameters that you input plus one which is number of ```argv[0]```.
```
./exampleCodeName para_1 para_2 para_2
```

if your ```int main()```, just skip the console parameters.
```
./exampleCodeName
```
