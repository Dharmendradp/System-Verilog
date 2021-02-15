/////////////////////// Inheritance ////////////////////// 

// allows a class A to inherit properties of a class B.
    /* We can say "A inherits from B" */

// Objects of class A thus have access to attributes and methods of class B without the need to redefine them

// Definition (Superclass/parentclass/Base class) If class A inherits from class B, then B is called superclass of A.  

// Definition (Subclass / child/extended/derivedclass) If class A inherits from class B, then A is called subclass of B. 

/*When you want to create a new class and there is already a class that includes some of the code that you want, you can derive your new class from the existing class. In doing this, you can reuse the fields and methods of the existing class without having to write (and debug!) them yourself.*/

// A subclass inherits all the members (fields, methods, and nested classes) from its superclass. Constructors are not members, so they are not inherited by subclasses, but the constructor of the superclass canbe invoked from the subclass

/*
class parent;
 task printf();
  $display(" THIS IS PARENT CLASS ");
 endtask
endclass
    
class subclass extends parent;   // subclass is inherited from parent class
 task printf();
  $display(" THIS IS SUBCLASS ");
 endtask
endclass
    
class subclass2 extends parent;   // overriding using Super keyword
 task printf();
  
  // adding new lines in the of funcstionality before existing code 
  $display("\n---------------------");
  
  super.printf(); // points to the method of superclass(parent)
  
  // adding new lines in the of funcstionality after existing code 
  $display(" plus another class method override");
  
  $display("---------------------\n"); 
 endtask
endclass
    
program main;
  initial
  begin
   parent p;
   subclass s;
   subclass2 s2;
   p = new();
   s = new();
   s2 = new();
   p.printf();
   s.printf();
   s2.printf();
  end
endprogram */

  /* Public, protected and local members of class */

//local variable - this is local to the class where it is specified. Neither it is available in the derived class or module that instantiates this class,(can't access outside of class(class in which it is declared))

//protected variable - this is not available in the module that instantiates but is available to the derived class(only access in inside that class & derived class,not access in outside)

//////////////////////////// overriding constraints /////////////////////
/*
class super_class;
  randc integer Var;
  constraint range{Var<100; Var>0;} 
endclass :super_class

class sub_class extends super_class;
  constraint range{Var<80; Var>10;} 
endclass :sub_class


program main;


initial 
begin
//super_class s = new();
sub_class s1 = new();

for(int i=0 ; i < 100 ; i++)
 if(s1.randomize())
  $display(" [%0d]Randomization sucsessfull : Var = %0d ",i,s1.Var);
 else
  $display("Randomization failed");

end
endprogram :main
*/

///////////////// overriding data members ////////////////////

//Only virtual methods truly override methods in super classes(polymorphism concept ). All other methods and properties do not override but provide name hiding.

class base;
         int N = 3;
         function int get_N();  
        //virtual function int get_N();
              return N; 
         endfunction
endclass
class ext extends base;
         int N = 4;
        function int get_N(); 
             return N; 
         endfunction
         function int get_N1(); 
             return super.N; 
         endfunction
endclass
    
program main;
         initial
         begin
             ext e = new;
             base b = e;                // Note same object!
                                       // if virtual then it will override
             $display(b.get_N());  // "3"
             $display(e.get_N());  // "4"
             $display(e.get_N1()); // "3"  - super.N
         end
endprogram
