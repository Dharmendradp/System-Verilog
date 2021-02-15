////////////////////  tasks /////////////////////////////
    //task to add two integer numbers

/*module sv_task;
  int x;
  task sum(input int a,b,output int c);   // arguments specified in parenthesis 
                                          // if (a,b,output int c) ==> it will take by default a & B as 
                                           //input & logic data type
  c = a+b;  
  endtask

  // task sum;         /// arguments declared without parenthesis & mentioning directions
  //  input int a,b;
  //  output int c;
  //  c = a+b;  
  // endtask
 
  initial begin
    sum(10,5,x);
    $display("\tValue of x = %0d",x);
  end

endmodule*/

/////////////// return in tasks //////////
// return keyword used to exit from the task before endtask

/*program main;

task task_return();
  $display("Inside Task : Before return statement");
return;                 //return value is specified using return statement
  $display("Inside Task : After return statement");
endtask

initial
task_return();

endprogram*/

////////////////////// functions //////////////////////

  //function to add two integer numbers.
/*module sv_function;
  int x;
  
    function int func_sum(input int a,b); // arguments specified in parenthesis 
                                          // if (a,b,output int c) ==> it will take by default a & B as input & logic data type
       func_sum = a+b; // return value is assigned to function name 
     endfunction

//  function int func_sum; // arguments declared without parenthesis & mentioning directions
//    input int a,b;
//    func_sum = a+b;  
//  endfunction
 
  initial 
   begin
     x=func_sum(10,5);
     $display("\tValue of x = %0d",x);
   end
endmodule*/


// return keyword used to exit from the functions before functions

/*program return1;
int t;

function [15:0] myfunc2 (input [7:0] x,y);
  return x * y - 1;                //return value is specified using return statement
endfunction

// void functions
function void myprint (int a);

endfunction

initial 
 begin
  t = myfunc2(3,2);
  $display("myfunc2 = %0d",t);
 end

endprogram*/


/////////////// void functions //////////// function with no return value
/*module sv_function;
  int x;
  
  function void current_time;
                         //void function to display current simulation time    $display("\tCurrent simulation time is %0d",$time);    

  endfunction
  
  initial 
   begin
     #10;
     current_time();
     #20;
     current_time();
   end
endmodule*/


/////////////// discarding function Return value ////////////////////////
// function return value must be assigned to a variable or used in an expression.
// in sv void data type is used to discard a functions return value without any warning message.

/*module sv_function;
  int x;
   //function to add two integer numbers. 
  function int sum;
    input int a,b;
    return a+b;    //return value is specified using return statement 
 endfunction
  
  initial begin
    $display("Calling function with void");
    void'(sum(10,5));   // discarding functions return value
  end
 endmodule*/



////////////////////// function as an expression //////////////////////

/*module sv_function;
  int x;
  //function to add two integer numbers. 
  function int sum;
    input int a,b;
  return a+b;    //return value is specified using return statement 
  endfunction
  initial begin
    x = 10 + sum(10,5);
    $display("\tValue of x = %0d",x);
  end
endmodule*/

//------------------------------------------------
//function integer clogb2;  // constant function of integer type (inside arguments/values/members are of integer type)

/*module abc(a,b,sum);
   input  a,b;
   output int sum;

   function byte myfunc;
     input [7:0]x,y;
     myfunc = x+y;    //return value is specified using return statement 
  endfunction
  endfunction
   initial
     begin
       sum = myfunc(5,8);
       $display("sum = %d",sum);
     end
  endmodule*/
//------------------------------------------------------------------

////////// arguments passing ////////////////

///// passing by values /////
/*module xyz;
int x,y,z;

//function  int sum( int a,b);
function int sum(int a,b);
 a = a+b;
 // $display("before, value of sum = %d",a);
 return a+b;
endfunction

initial 
 begin
 x= 10;
 y = 5;
 z = sum(x,y);
  $display("\n-------------------------");
  $display("value of x = %d",x);
  $display("value of y = %d",y);
  $display("value of sum = %d",z);
  $display("-------------------------\n");
 end
endmodule
*/

///// pass by reference //////////////

/*module xyz;
int x,y,z;

//function  int sum( int a,b);
function automatic int sum(ref int a,b);
     //function automatic int sum(const ref int a,b); // argument declared constatant, so in subroutine you can't modify const value, will give error
 a = a+b;
 // $display("before, value of sum = %d",a);
 return a+b;
endfunction

initial 
 begin
 x= 10;
 y = 5;
 z = sum(x,y);
  $display("\n-------------------------");
  $display("value of sum = %d",x);
  $display("value of sum = %d",y);
  $display("value of sum = %d",z);
  $display("-------------------------\n");
 end
endmodule
*/

//////////////////// argument with default value ////////////////////

module argument_passing;
  int q;
 
  //function to add three integer numbers.
  function int sum(int x=5,y=10,z=20);
    return x+y+z;  
  endfunction
 
  initial begin
    sum( , ,10);
    $display("-----------------------------------------------------------------");
    $display("\tValue of z = %0d",sum.z);
    $display("-----------------------------------------------------------------");
  end
endmodule


///// pass by name ////

/*
module argument_passing;
  int x,y,z;
 
  function void display(int x,string y);
    $display("\tValue of x = %0d, y = %0s",x,y);  
  endfunction
 
  initial begin
    display(.y("Hello World"),.x(2016));
  end
endmodule*/

