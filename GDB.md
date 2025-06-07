connect

·         target remote -- remote connection

·         file -- Loading symbol table

·         load -- Loader

·         attach -- Hook into an already running process to debug


Breakpoints

Observation Point

·         break -- Set a breakpoint at the specified line or function, abbreviated as b

·         info breakpoints -- Print a list of all breakpoints, watchpoints, and catchpoints that have not been deleted, abbreviated as i b

·         disable -- Disable breakpoints, abbreviated as dis

·         enable -- Enable breakpoints

·         clear -- Clear breakpoints at the specified line or function

·         delete -- Delete breakpoint, abbreviated as d

·         tbreak -- Set a temporary breakpoint, the parameters are the same as break, but it will be automatically deleted after the program stops for the first time

·         watch -- Set a watchpoint for an expression (or variable) and pause program execution when the value of the expression (or variable) changes


Debug Tracing

·         step -- Single-step tracing, if there is a function call, it will enter the function, abbreviated as s

·         step i -- Single-step tracking assembly code, abbreviated as si

·         next -- Single-step tracing, if there is a function call, it will not enter the function, abbreviated as n

·         next i -- Single-step trace assembly code, abbreviated as ni

·         run -- Start the debugged program, abbreviated as r

·         return -- Causes the selected stack frame to return to its caller

·         finish -- Execute until the selected stack frame returns, abbreviated as fin

·         until -- Execute until a line after the current line in the current stack frame is reached (used to skip loops and recursive function calls), abbreviated as u

·         continue -- Resume program execution, abbreviated as c


Check

·         backtrace -- View the program call stack information, abbreviated as bt

·         print -- Print the value of the expression EXP, abbreviated as p

·         x -- View memory, for example, x /8fx 0x80000000 displays 8 bytes of data at address 0x80000000 in hexadecimal.

·         display -- Print the value of expression EXP each time the program stops (automatically displayed)

·         info display -- Prints a list of expressions that were previously set to be displayed automatically

·         info register – Check the CPU register status

·         ptype -- Definition of print type TYPE


setup

·         set args -- Setting debugger parameters

·         set var -- Setting variable values

·         frame -- Select stack frame
