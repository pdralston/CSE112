// $Id: cons.cpp,v 1.1 2020-10-13 14:16:34-07 - - $

#include <iostream>
using namespace std;

template <typename car_t, cdr_t>
struct cons {
   const car_t& car_;
   const cdr_t& cdr_;
   cons (car_t car, cdr_t cdr): car_(car), cdr_(cdr) {}
   const car_t& car() { return car_; }
   const cdr_t& cdr() { return cdr_; }
};

int main() {
   auto list = cons (3, cons (4, cons (5, nullptr)));
}

