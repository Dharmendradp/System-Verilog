/*                     Copying Methods                                    */

/*  An object will be created only after doing new to a class handle,
     packet   pkt_1;
     pkt_1  = new();     // creating object memory for pkt_1             */

// Deep copy or Shallow copy : refer to the way objects are copied


////////////////         Shallow copy   (new keyword)  /////////////////////


// Objects will not be copied, only their handles will be copied.

/*      packet   pkt_2;
        pkt_2  = new pkt_1;

    In the above statement, pkt_2 is created and class properties were copied     from pkt_1 to pkt_2, this is called as shallow copy.                 */


// The pointer will be copied. but the memory it points to will not be copied -- the field in both the original object and the copy will then point to the same dynamically allocated memory, which is not usually whatyou want.

/// here, both share the same memory, so change in the value of one will be same in another   (like, copy by reference)

/*
class B;
int i;
endclass :B

module main;
initial begin
B b1;
B b2;
b1= new();
b1.i = 1234;
b2= new b1;         // shallow copy
b2.i = 4567;
$display(b1.i);
$display(b2.i);
end
endmodule
*/

/*
class A;
    int i;
endclass

class B;
     A a;
endclass

module main;
    initial
    begin
         B b1;
         B b2;

         b1 = new();
         b1.a = new();

         b1.a.i = 123;
        
         b2 = new b1;  

         $display( b1.a.i );

         b1.a.i = 321;

         $display( b1.a.i );
         $display( b2.a.i );
    
         b2.a.i = 467;

         $display( b2.a.i );
         $display( b1.a.i );

      end
endmodule */

// In the above example, the varible i is changed to which is inside the object of .This changes in seen in also because both the objects are pointing to same memory location


////////////////         Deep copy   (copy keyword)  /////////////////////

// Deep copy copies all the class members and its nested class members. unlike in shallow copy, only nested class handles will be copied.

// whenever the copy method is called, it will create the new object and copies all the class properties to a new object handle and return the new object handle.

/*class A;
    int i;
endclass

class B;
    A a;
    task copy(A a);
        this.a = new a;
    endtask
endclass

module main;
    initial
    begin
        B b1;
        B b2;
        b1 = new();
        b1.a = new();
        b1.a.i = 123;
        b2 = new();
        b2.copy(b1.a);
        $display( b1.a.i );
        $display( b2.a.i );
        b1.a.i = 321;
        $display( b1.a.i );
        $display( b2.a.i );
        b2.a.i = 666;
        $display( b1.a.i );
        $display( b2.a.i );
        
        
    end
endmodule*/



////////////////////     scope resolution operator ::  /////////////////////

// :: is used to specify an identifier defined within the scope of a class.

/*
class Base;
    typedef enum {bin,oct,dec,hex} radix;
    task print( radix r, integer n ); 
         $display(" Enum is %s ",r.name());
         $display(" Val is %d",n);
    endtask
endclass

program main;
    initial
    begin
        Base b = new;
        int bin = 123;
        b.print( Base::bin, bin ); // Base::bin and bin are different
    end
endprogram
*/


// Class Resolution operator allows access to static members (class properties and methods) from outside the class.

/*
class Base;
     typedef enum {bin,oct,dec,hex} radix;

     static task print( radix r, integer n ); 
          $display(" Enum is %s ",r.name());
          $display(" Val is %d",n);

     endtask

endclass

program main;
    initial
    begin
       int bin = 123;
       Base::print (Base::bin, bin ); // Base::bin and bin are different
    end
endprogram */


// Scope resolution operator ::  can be used to access to public or protected elements of a superclass from within the derived classes.


class Base;
    typedef enum {bin,oct,dec,hex} radix;
endclass

class Ext extends Base;
    typedef enum {dec,hex,bin,oct} radix;
    radix r;
    task print(); 
     $display(" Ext  classs :: enum values => %0d %0d %0d %0d ",bin,oct,dec,hex);
     $display("Base classs :: enum values  => %0d %0d %0d %0d ",Base::bin,Base::oct,Base::dec,Base::hex);
    endtask
endclass

program main;
    initial
    begin
        Ext e;
        e = new();
        e.print();
    end
endprogram
