//////////////////////// Polymorphism // virtual keyword ////////////////////

// polymorphism means many forms // many forms of the same method
// parent class is overrriden by child class
// if your super class need to be overriden by sub class use polymorphism 

// base class with method display

/*class base_class;
  virtual function void display();
    $display("Inside base class");
  endfunction
endclass

//three extended classes of base_class, with display method overridden in it.

class ext_class_1 extends base_class;
  function void display();
    $display("Inside extended class 1");
  endfunction
endclass
 
class ext_class_2 extends base_class;
  function void display();
    $display("Inside extended class 2");
  endfunction
endclass
 
class ext_class_3 extends base_class;
  function void display();
    $display("Inside extended class 3");
  endfunction
endclass


module polymorphism;

initial 
begin

//Create an object of each extended class,
ext_class_1 ec_1 = new();
ext_class_2 ec_2 = new();
ext_class_3 ec_3 = new();

// base class handle
base_class b_c[3];      // Declare an array of a base class

//assigning extended class to base class
b_c[0] = ec_1;
b_c[1] = ec_2;
b_c[2] = ec_3;

// call the display method using base class handle
//accessing extended class methods using base class handle
b_c[0].display();
b_c[1].display();
b_c[2].display();


// Though all the methods are called using base_class handle, different methods are getting called. this shows the many forms of the same method, this is called polymorphism.
end
endmodule :polymorphism */

///////////      overriding using virtual Keyword   ////////////////
/*class A ;
virtual task disp ();  // task declared with virtual keyword
$display(" This is class A ");
endtask
endclass

class EA extends A ;
task disp ();
$display(" This is Extended class A ");
endtask      
endclass

program main ;
A my_a;
EA my_ea;

initial
begin
my_a = new();
my_a.disp();

my_ea = new();
my_a = my_ea;  // overriding child to parent
my_a.disp();
end
endprogram
*/




///////////////////////// casting ///////////////////////////////////




// its is illegle to assign super class to subclass

 /* parent_class = child_class;     //allowed
    child_class  = parent_class;    //not-allowed        */

// but, it is legal to assign a superclass handle to a subclass variable   if the superclass handle refers to an object of the given subclass.

/*    This we can over come by make use of $cast method, i.e,

        $cast(child_class,parent_class);                        
              (destn     ,  source)                          */

//////  assigning childclass handle to parentclass handle

/*
class parent_class;
  bit [31:0] addr;
  function display();
    $display("Addr = %0d",addr);
  endfunction
endclass
 
class child_class extends parent_class;
  bit [31:0] data;
  function display();
    super.display();
    $display("Data = %0d",data);
  endfunction
endclass
 
module inheritence;
  initial begin
    parent_class p=new();
    child_class  c=new();
    c.addr = 10;
    c.data = 20;
    p = c;        //assigning child class handle to parent class handle
    c.display();
  end
endmodule*/


//////  assigning parentclass handle to childclass handle using $cast

/*
class parent_class;
  bit [31:0] addr;
 
  function display();
    $display("Addr = %0d",addr);
  endfunction
endclass
 
class child_class extends parent_class;
  bit [31:0] data;
 
  function display();
    super.display();     /// calling dsiplay method from parent class
    $display("Data = %0d",data);
  endfunction
endclass
 
module inheritence;
  initial begin
    parent_class p;
    child_class  c = new();
    child_class  c1;
    c.addr = 10;
    c.data = 20;
 
 p = c;         //p is pointing to child class handle c. 
 $cast(c1,p);   //with the use of $cast, type chek will occur during runtime
 
 c1.display();
  end
endmodule
*/

////////////// static casting   /////////////////

// static casting = conversion of one data type to another

/*module casting;
   
  real r_a;
  int  i_a;
   
  initial begin
     
    r_a = (2.1 * 3.2);
     
    //real to integer conversion
    i_a = int'(2.1 * 3.2); //or i_a = int'(r_a);
     
    $display("real value is %f",r_a);
    $display("int  value is %d",i_a);
  end
endmodule*/


/////////////////// casting example ////////////////////

/*
class B;
     virtual task print();
       $display(" CLASS B ");
     endtask
endclass

class E_1 extends B;
     virtual task print();
         $display(" CLASS E_1 ");
     endtask
endclass

class E_2 extends B;
     virtual task print();
         $display(" CLASS E_2 ");
     endtask
endclass

program main;
    initial
    begin
        B b;
        E_1 e1;
        E_2 e2;
       
        e1 = new();
        $cast(b,e1);   ///  $cast(destn,source);
        b.print();
       
    end
endprogram*/

///////////////// $cast as Function //////////////////
class B;
     virtual task print();
          $display(" CLASS B ");
     endtask
endclass

class E_1 extends B;
     virtual task print();
          $display(" CLASS E_1 ");
     endtask
endclass

class E_2 extends B;
     virtual task print();
          $display(" CLASS E_2 ");
     endtask
endclass

program main;
     initial
     begin
          B b;
          E_1 e1;
          E_2 e2;
         
               e1 = new();
//calling $cast like a task
//Return value is not considered
               $cast(b,e1);
               which_class(b);
              
               e2 = new();
//calling $cast like a task
//Return value is not considered
               $cast(b,e2);
               which_class(b);
         
     end
endprogram
task which_class(B b);
     E_1 e1;
     E_2 e2;
//calling $cast like a function
//Return value is considered for action
     if($cast(e1,b))
          $display(" CLASS E_1 ");
     if($cast(e2,b))
          $display(" CLASS E_2 ");
endtask
