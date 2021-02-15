////////////////// Encapsulation //////////////////

// local : External access to the class members can be avoided by declaring members as local. Any violation could result in a compilation error.

/////  accessing local variable outside the class (Not allowed)
/*
class parent_class;
  local bit [31:0] tmp_addr;
   
  function new(bit [31:0] r_addr);
    tmp_addr = r_addr + 10;
  endfunction
 
  function void display();
    $display("tmp_addr = %0d",tmp_addr);
  endfunction
endclass
 
 
//   module
module encapsulation;
  initial begin
    parent_class p_c = new(5);
        
    p_c.tmp_addr = 20;  //Accessing local variable outside the class // will give error
    p_c.display();
  end
endmodule*/

/////  accessing local variable within the class (allowed)

/*module encapsulation;
  initial begin
    parent_class p_c = new(5);
    p_c.display();
  end
endmodule*/

//// Protected - A protected class property or method has all of the characteristics of a local member, except that it can be inherited; it is visible to subclasses (not accessible at outside)

///// EXAMPLE: protected varible in 2 level of inheritence

class base;
    local int i;
endclass

class ext extends base;
    protected int i;   // variable declared as protected class member
endclass

class ext2 extends ext;
     function new();
    i =10;            // protected class member accessible in derived class
         $display("----- %0d -------",i);
    endfunction
endclass

program main;
initial 
begin
ext ex;
ext2 ex2;
ex = new();
ex2 = new(); 
//$display("-/---- %0d ----/---",ex2.i); // can't access protected member outside  // error
end
endprogram
