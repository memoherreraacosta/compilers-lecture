#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>


/***************************
Example:
The grammar to use is :

E -> T | T  + E
T -> int | int * T| ( E )
***************************/

char l;

bool E();
bool E1();
bool T();
bool T1(); // is int
bool T2();
bool T3();

void error(){
	printf("Error\n");
	exit(-1);
}


// Match function
bool match(char t) {
    if (l == t) {
        l = getchar();
		return true;
    }
    else
		error();
        return false;
}


bool E(){
	if(E1()){
		if(l == '+'){
			if(match('+') && E() ){
				//succesfull
				return true;
			}
			else{
				return false;
				error();
			}
		}
		return true;
	}
	else{
		error();
        return false;
	}
}


bool T(){
	if(l == '('){
		if(T3()){
			return true;
		}
		else{
			error();
			return false;
		}
	}
	else{
		if(T1()){
			if(l == '*'){
				if(T2()){
					return true;
				}
				else{
					return false;
				}
			}
			return true;
		}
		else{
			return false;
		}
	}
	return false;
}


bool E1(){
	if(T()){
		return true;
	}
	else{
		return false;
	}
}


bool T1(){
	if(isdigit(l)){
        l = getchar();
		return true;
	}
	else{
		return false;
	}
}


bool T2(){
	if(match('*') && T()){
		return true;
	}
	else{
		return false;
	}
}


bool T3(){
	if(match('(') && E() && match(')')){
		return true;
	}
	else{
		return false;
	}
}


int main() {
    do {
        l = getchar();
	    E();

    } while (l != '\n' && l != EOF);

    if (l == '\n')
        printf("Parsing Successful\n");
}
