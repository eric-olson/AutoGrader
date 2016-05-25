/*
   newtracker.cpp

   Overrides for new, delete plus utility functions to keep track of and report
   on dynamic allocation in student programs.

   Author: C. Painter-Wakefield
   Last Modified: 2/14/2016
   
*/

#include <exception>
#include <cstdlib>

// dynamically allocated memory tracking struct
struct _newitem {
    void*   ptr;	// pointer to allocated mem
    size_t  size;	// size of allocated mem
    bool    arr;        // true if allocated using new[]
}; 

// global tracking array - note we can only track up to
// _NEWTSIZE allocations in total!
static const size_t _NEWTSIZE = 8192;
static _newitem _newtracker[_NEWTSIZE];
static size_t _newtracker_next_idx = 0;

// last error indicator - used for last deallocation error
// since we can't catch exceptions thrown in delete
static const int _NEWT_NULL = 1;
static const int _NEWT_MISMATCH = 2;
static const int _NEWT_INVALID = 3;
static int _newtracker_last_error = 0;

// reporting functions
void _newtracker_reset_error() {
    _newtracker_last_error = 0;
}

bool _newtracker_has_error() {
    return _newtracker_last_error != 0;
}

const char* _newtracker_strerror() {
    switch (_newtracker_last_error) {
    case 1:
        return "attempt to deallocate NULL pointer";
    case 2:
        return "attempt to deallocate array using delete[], or non-array using delete";
    case 3:
        return "attempt to deallocate unallocated memory";
    }
    return "no error";
}

size_t _newtracker_getsize(void* p) {
    for (size_t i = 0; i < _newtracker_next_idx; i++) {
        if (_newtracker[i].ptr == p) {
            return _newtracker[i].size;
        }
    }
    return 0;
}

size_t _newtracker_count() {
    int count = 0;
    for (size_t i = 0; i < _newtracker_next_idx; i++) {
        if (_newtracker[i].ptr != NULL) count++;
    }
    return count;
}

// new new, delete functions
inline void* _newtracker_new (size_t size, bool is_array) {
    if (_newtracker_next_idx >= _NEWTSIZE) 
        throw std::bad_alloc();

    void* p = malloc(size);
    if (p == NULL) 
        throw std::bad_alloc();    

    _newtracker[_newtracker_next_idx].ptr = p;
    _newtracker[_newtracker_next_idx].size = size;
    _newtracker[_newtracker_next_idx].arr = is_array;
 
    _newtracker_next_idx++;

    return p;
}

void* operator new (size_t size) {
    return _newtracker_new(size, false);
}

void* operator new[] (size_t size) {
    return _newtracker_new(size, true);
}

inline void _newtracker_delete (void* p, bool is_array) {
    if (p == NULL) {
        _newtracker_last_error = _NEWT_NULL;
        return;
    }
    
    for (size_t i = 0; i < _newtracker_next_idx; i++) {
        if (_newtracker[i].ptr == p) {
            if (is_array != _newtracker[i].arr) {
                _newtracker_last_error = _NEWT_MISMATCH;
                return;
            }
            _newtracker[i].ptr = NULL;
            return;
        }
    }
    _newtracker_last_error = _NEWT_INVALID;
}

void operator delete (void* p) {
    _newtracker_delete(p, false);
}

void operator delete[] (void* p) {
    _newtracker_delete(p, true);
}

