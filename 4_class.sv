//////// basic class / object creation /constructor /////////////  refer LRM for good understanding

// Object is an instance of that class
// object handle  = instance name

/*
class basic_declarn;
// attributes(properties)   // defination
int a;         /// class members
bit [7:0]b; /// class members
string s;  /// class members

 task display();          // methods 
  $display("a=%0d, b=%0b,s =%0s",a,b,s);
 endtask

endclass :basic_declarn

class packet; 
int length = 0;
//constructor
       function new (int l); // class constructor new(),by default its is there(if not declared)  
                             // new function = function with no return type, LHS of the assignment in body or display statment has return type
         $display("%d",l);        
       endfunction
endclass :packet

module main;
 
initial 
 begin
  //task1;
   basic_declarn b1; /// object handle declaration // instantiation
   packet pkt;      
   b1 = new();   /// object creation(allocating memory) // function with no return type
   pkt = new(10);
   b1.a = 'd4564;  // set the value of a variable
   b1.b = 'haa;   
   b1.s = "welocome to the oops";
   b1.display();    // call the routine
   $display("value of disp = %d",b1.a);
   $display("pkt.length= %d",pkt.length);
 end

//task task1(packet pkt);
//if (pkt == null) pkt = new;
//endtask

endmodule*/


//////////////// class ex ////////////////////
/*
class Packet ;

//data or class properties
string command;
bit [40:0] address;
bit [4:0] master_id;
integer time_requested;
integer time_issued;
integer status;

// initialization
function new();
command = "IDLE";
address = 4'b0;
master_id = 5'bx;
endfunction

// methods

// public access entry points
task clean();
command = 0; address = 0; master_id = 5'bx;
endtask

task issue_request( int delay );
// send request to bus
endtask

function integer current_status();
current_status = status;
endfunction

function void Display();
$display("command = %0s, address = %0h, master_id = %0h",command,address,master_id);
endfunction
endclass*/


////////////////// class constructor ex /////////////////////
/*
class packet;
  //class properties
  bit [31:0] addr;
  bit [31:0] data;
  bit  write;
  string pkt_type;
  //constructor
  function new();
    addr  = 32'h10;
    data  = 32'hFF;
    write = 1;
    pkt_type = "GOOD_PKT";
  endfunction
 
  //method to display class prperties
  function void display();
    $display("---------------------------------------------------------");
    $display("\t addr  = %0d",addr);
    $display("\t data  = %0h",data);
    $display("\t write = %0d",write);
    $display("\t pkt_type  = %0s",pkt_type);
    $display("---------------------------------------------------------");
  endfunction
task no

endtask

endclass
 
module sv_constructor;
  packet pkt;
  initial begin
    pkt = new();
    pkt.display();
  end
endmodule*/


///////////////// this keyword ////////////

/*class packet;
   
  //class properties
  bit [31:0] addr;
  bit [31:0] data;
  bit   writ;
  string  pkt_type;
   
  //constructor without this
//function new(bit [31:0] addr,data,bit writ,string pkt_type);
//addr  = addr;
//data  = data;
//writ = writ;
//pkt_type = pkt_type;
//endfunction  
   
extern task simple_task_display();
//$display("----its just a simple task ----\n");
//endtask 

  //constructor wit this
  function new(bit [31:0] addr,data,bit writ,string pkt_type);
    this.addr  = addr;
    this.data  = data;
    this.writ = writ;
    this.pkt_type = pkt_type;
  endfunction

  //method to display class prperties
  function void display();
    $display("\n-------------------------------");
    $display("\t addr  = %0d",addr);
    $display("\t data  = %0h",data);
    $display("\t write = %0d",writ);
    $display("\t pkt_type  = %0s",pkt_type);
    $display("-------------------------------\n");
  endfunction
   
endclass
 
task packet::simple_task_display();
$display ("@@@@@  second statement\n");
endtask 

module sv_constructor;
  packet pkt;

  initial begin
  packet pkt = new(32'h10,32'hFF,1,"GOOD_PKT");
    pkt.display();
    pkt.simple_task_display();
  end
   endmodule*/


/////////////////   static keyword     ////////////////////////////////

/*
class a;
 static int i; /// static property
 int b;

endclass :a

program main;
a obj1;
a obj2;
initial
begin
obj1 = new();
obj2 = new();
obj1.i = 123;
obj1.b = 465;
$display("%d",a::i);
$display("%d",obj1.b);
end
endprogram

// you can access static property without creating object of that type
program main1;
a obj1;
initial
begin
obj1.i = 123;
$display("obj1.i = %d",obj1.i);  // without creating object
$display("a::a = %d",a::i); // using scope resol oper without creating object
end
endprogram
*/

////////////////////// static methods ///////////////////
/*
class A;
//int j;                     // non-static member // if used will get error
static task run();           // static method
//virtual static task run(); // static methods can not be virtual, if used will get error
int j;
j++;
$display("j is = %0d ",j); 
endtask :run

static task who();
$display("@@@@@@@@@ i am static method @@@@@@@@");
endtask 
endclass

program main;
A obj1;
A obj2;
initial begin
$display("static task with automatic variables "); 
obj1 = new();
obj2 = new();
obj1.run();
obj2.run();
obj1.run();
obj2.run();
obj1.run();
obj2.run();
$display("static task - Each call to task will create a separate copy of 'j' and increment it"); 
end
endprogram

program main2;
A a;
initial
a.who();
endprogram
*/
//////////////////////// Static lifetime method /////////////////
/*
class A;
 task static run();    // all variables within this task will be static 
  int j;                // static variable
  j++;
  $display("j is = %0d ",j); 
 endtask :run
endclass

program main;
A obj1;
A obj2;

initial begin
$display("Static lifetime - non static task with static variables"); 
obj1 = new();
obj2 = new();
obj1.run();
obj2.run();
obj1.run();
obj2.run();
obj1.run();
$display("Static lifetime - Each call to task will use a single value of 'j' and increment it");
end
endprogram
*/
