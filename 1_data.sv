//////////////// Data Types ////////////////////


/*module data;           ///// Default Values //////
reg a;               /// 4 state, unsigned , 1 bit ,default: x
wire w;              /// 4 state, unsigned , 1 bit ,default:z
integer i = 12;      /// 4 state, unsigned , 32 bit ,default:X
time t;              /// 4 state, unsigned , 64 bit ,default:X
realtime rt = 12;    /// 4 state, unsigned , 64 bit ,default:X 
                     /// like double in C
                     /// can't be vectored (can't specify range)

real r = 1.2;        /// 2 state, signed , 32 bit , default:0
shortreal sr;        /// 2 state, signed , 16 bit , default:0
int in= 3;           /// 2 state, signed , 32 bit , default:0
                     /// can't be vectored (can't specify range)
shortint sin = 2;    /// 2 state, signed , 16 bit , default:0
                     /// can't be vectored (can't specify range)
longint lin;         /// 2 state, signed , 64 bit , default:0 
                     /// can't be vectored (can't specify range)
parameter [9:0]siz = 10; 

logic [4:0]log;      /// 4 state, unsigned , 1bit , default:X 
bit [4:0]b = 'z;     /// 2 state, unsigned , 1bit , default:0
byte d='z;           /// 2 state, signed , 8bit , default:0

initial begin
//logic log=1'bz;



$display("a = %b\n, w = %b\n,i = %b\n,r = %g\n,sr = %b\n,t = %b\n,rt = %b\n,i = %b\n,sin = %b\n,lin = %b\n,size = %b\n,logic = %b\n,bit = %d\n,byte = %d\n,",a,w,i,r,sr,t,rt,in,sin,lin,siz,log,b,d);
end
endmodule*/

/////////////////////// Strings  /////////////////////////////////

/*module strgs;
strg nam ;
strg A;

   itial beg\
    nam = "first name given to the strg";
    A = "first name given to The strG";
  #1 $display($time," %s",nam);
  #1 $display($time," %d",nam.len);
  #1 $display($time," %s",nam.getc(27));
   //  $display($time," %s",nam.putc(27,0));

  #1 $display($time," %s",nam.toupper);
  #1 $display($time," %s",nam.tolower);
  #1 $display($time," %d",nam.compare(A));
  #1 $display($time," %d",nam.icompare(A));
  #1 $display($time," %s",nam.substr(0,6));
  #1 A = "Base";
  #1 $display($time," %d",A.atohex);
  #20 $fish;
   end

endmodule
*/

/*
///////////// pattern matchg ////////////////
function match(strg s1,s2);
t l1,l2;
l1 = s1.len();
l2 = s2.len();
match = 0 ;
if( l2 > l1 )
return 0;
for(t i = 0;i < l1 - l2 + 1; i ++)
if( s1.substr(i,i+l2 -1) == s2)
return 1;
endfunction

program ma;

strg str1,str2;
t i;


itial
beg
str1 = "this is first strg";
str2 = "itsnot";
if(match(str1,str2))
$display("---------- str2 : %s : found  : str2 :%s:------------",str2,str1);

else
$display("---------- str2 : %s : Not found  :str2 :%s:---------",str2,str1);
end


endprogram;*/

//////////  strg operators ///////
/*
program ma;
itial
beg
strg Str1,Str2,Str3;
Str1 = "fghc";
Str2 = "d";
Str3 = "e";

if(Str1 < Str2)
$display(" Str1 < Str2 ");
if(Str1 <= Str2)
$display(" Str1 <= Str2 ");
if(Str3 > Str2)
$display(" Str3 > Str2");
if(Str3 >= Str2)
$display(" Str3 >= Str2");
end
endprogram*/

//////////////////// typedef & enumerations //////////////////


/*module enum_datatypes;
enum {bat,ball,stumps,glows}kit;
reg [31:0]a = '1; /// all bits are 1

initial begin
$display("a = %d",a);

$display("1. member is = %d",kit.first);
$display("2. member is = %d",kit.last);
$display("3. member is = %d",kit.next());
$display("4. member is= %d",kit.next(3));
$display("5. member is= %d",kit.prev(0));
$display("6. name is= %s",kit.name());
end
endmodule */


/*
program enums;
typedef enum {set,reset,zero=5,toggle,setup1=12,access,idle}state;
//typedef enum int{set,reset,zero=5,toggle,setup1=12,access,idle}state;
state s;
state b;
initial begin
s = s.first;

for(int i=0;i<=6;i++)
begin
  $display("==%0d === %s=",s,s.name);
   s = s.next();
end


b = b.last;

for(int i=0;i<=6;i++)
begin
  $display("==%0d === %s=",b,b.name);
   b = b.prev;
end

#5 $finish;
end

endprogram

*/

//////////////////////// Structure //////////////////////////////
// method of packing data of different types
// by default unpacked(multiple locations) 

program Structures;

//struct {int a;integer in;bit [7:0]b;reg x;logic w;}stc;
typedef enum int{wi1,wi2,wi3}wires;
typedef struct {int a;
                      wires wi;
                      integer in;
                      bit [7:0]b;
                      reg x;
                      logic w;} stc;

//initial begin
//stc.a = 'd49;
//stc.in = 'd4;
//stc.b = 'd45;
//stc.x = 'dx;
//stc.w = 'dz;
//$display("int a = %b\ninteger in = %d\nbit b = %b\nreg x = %d\nlogic w=%d",stc.a,stc.in,stc.b,stc.x,stc.w);

//#1 stc = '{'d1324,-'d1245,'b1010,'dz,'dx};  // declared explicitly
//$display("int a = %d\ninteger in = %d\nbit b = %b\nreg x = %d\nlogic w=%d",stc.a,stc.in,stc.b,stc.x,stc.w);

//end

stc s;
wires W;
initial
begin
s = '{'d49,123,'d4,'hAA,'dx,'dz};
$display("%p",s);
$display("%p",W.name);

#2 $finish;

end
endprogram :Structures








/////////////////////////////// arrays  ////////////////////////////////

///////////////// packed arrays ///////////

/*
module pack_unpked;

logic [7:0]a; // A vector or 1D packed array

initial 
begin 
 a = 8'hB3;

 for(int i=0; i<$size(a);i++)
   begin
   $display("a[%0d]=%d",i,a[i]);
   end

end


bit [3:0][7:0]b; // multidimention array(2D packed array)
                 //32bit array(4 byte) 
                 // left to right, Start from the right
                // {x,x,x,x}, here x = 8 bit wide 
initial 
begin
 b = 32'hba_c8_d5_6c;

 for(int i=0; i<$size(b);i++)
   begin
   $display("b[%0d]=%b (0x%h)",i,b[i],b[i]);;
   end

end


bit [2:0][3:0][7:0]c; // 3D packed array
                      // 12 bytes   = 3 * 32bit(4byte)
                     // {{x,x,x,x},{x,x,x,x},{x,x,x,x}} , x = 8 bit wide
initial 
begin
//assigning value to the 1D array
c[0] = 32'habcd_53d2;
c[1] = 32'h56c5_78ad;
c[2] = 32'h8a2b_4563;

for(int i=0; i<$size(c);i++)begin
$display("c[%0d]=%b (0x%h)",i,c[i],c[i]);;
end

foreach(c[i])  //interate through each bit of vector(1D array) and print value
    begin
    $display("c[%0d]= 0x%0h",i,c[i]);
      foreach(c[i][j])
        begin
        $display("c[%0d][%0d]=0x%0h",i,j,c[i][j]);
        end
    end

c[1][2][7:0] = a[7:0];    ///  reading and writing a slice of an array

$display("c[1][2][7:0] = %0h",c[1][2]);

c = '{ '{'{a,b},'{a,b},'{a,b},'{a,b}}, '{'{b,c},'{b,c},'{b,c},'{b,c}}, '{'{c,d},'{c,d},'{c,d},'{c,d},'{c,d}} };
  for(int i=0; i<$size(c);i++)
    begin
    //$display("c[%0d]=%b (0x%h)",i,c[i],c[i]);
    $display("c=0x%h",c);
    end 

end 
endmodule*/

//////////////////  unpacked arrays ////////////////

/*
module unpck;

byte stack[8]; // depth =8 , 1 byte wide variable

// assign random value to each slot of the stack

initial begin
foreach(stack[i])
  begin
  stack[i]= $random;
  $display("stack[%0d] = %d ",i,stack[i]);
  end
$display("stack = %p",stack);
end

byte unsigned stack2[2][4:0]; // depth =2*10 , each 1 byte wide variable
                        //here,  {{x,x,x,x,x,},{x,x,x,x,x,}} // x=1byte 

// assign random value to each slot of the stack

initial begin
foreach(stack2[i])
  foreach(stack2[i][j])
    begin
    stack2[i][j]= $random;
    $display("stack2[%0d][%0d] = %h ",i,j,stack2[i][j]);
    end
// print content of the stack
$display("stack2 = %p",stack2);
end

endmodule*/

 ////////// mixed - packed-unpacked arrays //////////

/*
module pckd_unpckd;

bit [3:0][7:0]pkupk[1:0][2:0];
initial begin
foreach(pkupk[i])
  begin
      foreach(pkupk[i][j])begin
      pkupk[i][j] = $random;
      $display("pkupk[%0d][%0d] = %0h",i,j,pkupk[i][j]);
      end
  end

// print content of the stack
$display("\n pkupk = %0p \n",pkupk);


// print content of the given index
$display("pkupk[0][1][1] = %0h",pkupk[0][1][1]);
$display("pkupk[1][2][3] = %0h\n",pkupk[1][2][3]);

//////////////////// array quering functions ////////////////////

$display("dimensions of pkupk = %0d",$dimensions(pkupk));
$display("size of pkupk = %0h",$size(pkupk));
$display("left(MSB) of pkupk = %0h",$left(pkupk));
$display("right(LSB) of pkupk = %0h",$right(pkupk));
$display("High(max) of pkupk = %0h",$high(pkupk));
$display("Low (min) of pkupk = %0h",$low(pkupk));
$display("incr of pkupk = %0d",$increment(pkupk));
end
endmodule
*/


/////////////////////  Dynamic arr  [] /////////////////////////////////

/*
module dyn_arr;
integer arr1[],arr2[],arr3[];

initial 
begin

arr1=new[6];         // allocating size of array
$display(arr1.size);   // display size of an array
arr1[1]=32; arr1[3]= 'h_ad;
$display("%0p",arr1);  // display array entries(contents)
arr1= new[100](arr1);  // allocating bigger size to array, while keeping old entries
$display(arr1.size);
$display("%0p",arr1);
arr1.delete;           //  to delete an array
$display(arr1.size);
$display("%0p\n",arr1);


arr2=new[10];
$display("%0p",arr2);
$display(arr2.size);
arr2={00,10,20,30,40,50,60,70,80,90};
$display("%0p",arr2);
$display(arr2.size);
arr2 = new[arr2.size + 1](arr2); // careting one more slot in array while keeping old entries
$display(arr2.size);
arr2[arr2.size - 1] = 100;  // adding element to 11th index
$display("%0p\n",arr2);


arr3 = new[10];
arr3 = {arr2[0:3],arr2[6:8]};    //// deleting specific elements of an array using bit slicing
$display("\n%0p",arr3);
$display(arr3.size);
end

endmodule   
*/


//////////////////// Associative array  [*] //////////////////////////////// 

//// Declaration: data_type  array_name[index_type];
/*
module asso_arry;

integer arr1[int];       // declared integer type array named arr1 with index_type of string 
integer arr2[string];
string i3[string];

int temp,imem[*];         // * => int (default)

int a_array1[bit [7:0]]; //index type is bit [7:0] and entry type is int
bit a_array2[string]   ; //index type is string and entry type is bitm[*];


initial begin 

$display("\n--------------------------------------------");
$display("%0p",arr1.size); // shows size of an array
arr1 = '{1:10,2:20,6:50,12:56};
$display("%0p",arr1);
$display("%0p",arr1.size); // shows size of an array
$display("%0p",arr1.num);   //  same as .size
$display("--------------------------------------------\n");


$display("\n--------------------------------------------");
$display("%0p",arr2.size);
arr2 = '{"red":100, "green":4654646521315468431348484654150,"yellow":30};
$display("%0p",arr2);
$display("%0p",arr2.size);
$display("--------------------------------------------\n");


$display("\n--------------------------------------------");
$display("%0p",i3.size);
i3 = '{"rose":"red","sunflower":"yelloew"};
$display("%0p",i3);
$display("%0p",i3.size);
$display("--------------------------------------------\n");


$display("\n--------------------------------------------");
$display( "%0d entries", imem.num );
imem[2'd3] = 1;
imem[16'hffff] = 2;
imem[4'b1000] = 3;
$display("%0p",imem);
$display( "%0d entries", imem.num );

if(imem.exists( 4'b1000) )  // exists() function checks whether an element exists at the specified index within the given array. 
$display("\n imem.exists ( 4b'1000) ");
imem.delete(4'b1000);
$display("%0p",imem);

if(imem.exists( 4'b1000) )
$display("\nimem.exists( 4b'1000) ");
else
$display(" ( 4b'1000) not existing");

if(imem.first(temp))
$display("\n First entry is at index %0d ",temp);
if(imem.next(temp))
$display(" Next entry is at index %0h ",temp);

// To print all the elements alone with its indexs
if (imem.first(temp) )
do
$display( "%0h : %0h", temp, imem[temp] );
while ( imem.next(temp) );
$display("--------------------------------------------\n");
end

 initial begin
    //allocating array and assigning value to it
    a_array1[5] = 10;
    a_array1[8] = 20;
         
    a_array2["GOOD_PKT"] = 1;
    a_array2["BAD_PKT"]  = 0;
        
$display("\n--------------------------------------------");
    foreach(a_array1[i])
      $display("a_array1[%0d] = %0d",i,a_array1[i]);
    foreach(a_array2[i])
      $display("a_array2[%0s] = %0d",i,a_array2[i]);
$display("--------------------------------------------\n");
  end
endmodule  */

/////////////////////// queue [$] ////////////////////////////////////

// Declaration: data_type  name_of_queue[$];

// $ ==> specifies array size, in Queue $ == last entry, 0 == first entry
/*
module queue;
 byte q[$]; // queue of bytes, unbounded queue
int q1[255:0];        // queue of integers, bounded queue with 256 entries
string qs[$];         // queue of strings
logic [7:0]element[$:127]; // bounded queue of 8 bits with maximum size of 128slots

// queue declaration and initialization
initial begin
q = {1,2,5,4,9,6};
qs = '{"red","green","yellow","black","blue"};
$display("\n--------------------------------------------");
$display("q = %0p",q);
$display("qs = %0p",qs);
foreach(q[i])begin
   $display("q[%0d] = %0h ",i,q[i]);
             end 
foreach(qs[i])begin
   $display("qs[%0d] = %0s ",i,qs[i]);
              end
qs = {};              // delete all elements of queue qs
$display("qs = %0p",qs);
$display("--------------------------------------------\n");
end

int a[$]= {4,8,3,2,1,6,5};
int b[$];
int x,y,z;
initial begin  /// block with basic queue manipulation & operators  (slicing)
$display("\n-----------------------------------------------------------");
$display(" a = %0p",a);

// read the first (leftmost) item 	
x = a[0];
$display("after x = a[0] ===> x = %0p",x);

// read the last (rightmost) item
x = a[$];
$display("after x = a[$] ===> x = %0p",x);

// write the first item
a[0] = x;
$display("after a[0] = x ===> a = %0p",a);

// read and write entire queue (copy)
b = a;
$display("after b = a ===> b = %0p",b);

// insert '6' at the end (append 6)
b = {b,6};
$display("after inserting 6 at end ===> b = %0p",b);

// insert 'x' at the beginning (prepend x)
b = {x,b};
$display("after inserting x at beginning ===> b = %0p",b);

// delete the first (leftmost) item
b = b[1:$];
$display("after deleting first item ===> b = %0p",b);

// delete the last (rightmost) item
b = b[0:$-1];
$display("after deleting last item ===> b = %0p",b);

// delete the first and last items
b = b[1:$-1];
$display("after deleting first & last item ===> b = %0p",b);

// clear the queue (delete all items)	
b = {};
$display("after deleting all item ===> b = %0p",b);  b = a;
$display("after b = a ===> b = %0p",b);

// insert 'x' at position y
x = 9;
y = 2;
b = {b[0:y-1],x,b[y:$]};
$display("insert x position at y ===> b = %0p",b);

// insert 'x' after position y
x = 0;
b = {b[0:y],x,b[y+1:$]};
$display("insert x after position at y ===> b = %0p",b);

$display("---------------------------------------------------------------\n");
end

initial begin /// block with all methods of queue 
$display("\n---------------------------------------------------------------");
$display("array a = %0p",a);
$display("size of array a = %0p",a.size);
a.insert(2,15);
$display("after insert(2,15)   array a = %0p",a);
a.push_front(156);
$display("after push_front(156)  array a = %0p",a);
a.pop_front();
$display("after pop_front()  array a = %0p",a);
a.push_back(153);
$display("after push_back(156)  array a = %0p",a);
a.pop_back();
$display("after pop_back()  array a = %0p",a);
a.delete(3);
$display("after delete(2)  array a = %0p",a);
$display("---------------------------------------------------------------\n");
end



typedef string dyn_str[];
dyn_str list[$];
dyn_str q1_dyn_str;
dyn_str q2_dyn_str;

initial 
begin  // dynamic arrays of queues , queues of queues
$display("---------------------------------------------------------------\n");
 q1_dyn_str = '{"MSD","VK","SACH","VVS","YUVI","HIT"};
 q2_dyn_str = '{"MAX","Warner","hayden","ricky"};
//list.push_back(q1_dyn_str);
//list.push_back(q2_dyn_str);
$display(" q1_dyn_str = %0p ",q1_dyn_str);
$display(" q2_dyn_str = %0p ",q2_dyn_str);
//$display(" list = %0p ",list);
//$display(" list = %0p ",list.size);

$display("---------------------------------------------------------------\n");
end

endmodule
*/


///////////////////////////// Array Methods ////////////////////////////////

/////////////// array locator methods /////////////////
// operates on any unpacked array,including queues
// allow searching an array for elements (or their indexes) that satisfies a given expression

/*
module arr_methods;
string arr[10],qs[$];
int asr[*],qi[$];			

initial /// block for array locator methods
begin
arr[1:6] = {"ab","ac","ad","ae","af","ag"};
asr[2] = 30;
asr[6] = 564;
asr[12] = 4654;
asr[32] = 45;
asr[19] =0;
asr[15] = 3;
asr[22] = 45;
asr[52]  = 40;
asr[49] = 78;

// find all items less thasrn 50
qi = asr.find(x)with (x<50);
foreach(qi[i])
 begin
 $display("qi[%0d] = %0d",i,qi[i]);
 end

/// find indexes all items equal to 0
//qi = asr.find_index with (item == 0); 
// $display("%0p",qi);

//foreach(qi[j])
// begin
// $display("qi[%0d] = %0d",j,qi[j]);
// end


//find first item equal to "ae"
qs = arr.find_first with (item == "ae");  // find last item satisfying the given equation
 $display("%0p",qs);

//find last item equal to "ag"

qs = arr.find_last(y) with (y == "ab");  // returns the last element satisfying the given expression
$display("%0p",qs);

// find index of last item greater than 45
//qs = arr.find_last_index(z) with (z > "ad");
//$display("%0p",qs);


// find smallest value
qi = asr.min;
$display("%0p",qi);

// find string with the largest numerical value
qi = asr.max; 
$display("%0p",qi);
qs = arr.max with (item.atoi); 
$display("%0p",qs);

//find all unique string elements
qi = asr.unique; 
$display("%0p",qi);
qs = arr.unique; 
$display("%0p",qs);
qs = arr.unique(s) with (s.toupper); 
$display("%0p",qs);

end
endmodule
*/

///////////////////// array reduction methods ///////////////////
/*module array_redu();
byte b[] = { 1, 2, 3, 4 };
int sum,product,b_xor;
initial
begin
sum = b.sum ; // y becomes 10 => 1 + 2 + 3 + 4
product = b.product ; // y becomes 24 => 1 * 2 * 3 * 4
b_xor = b.xor with ( item + 4 ); // y becomes 12 => 5 ^ 6 ^ 7 ^ 8
$display(" Sum is %0d,\n product is %0d,\n xor is %0b\n ",sum,product,b_xor);
end
endmodule*/
















