//////    Packed struct       //////////

// define struct with packed keyword.
// only packed datatypes are allowed inside struct. 

/*module TOP;
 
typedef struct packed 
    {
        bit [7:0]A;
        bit      B;
        bit [7:0]C;
    } STRUCT_1;
 
STRUCT_1 S1;
 
initial 
    begin
        S1 = {8'hAA,1'b1,8'hFF};
        $display(" S1 = %0p",S1);
         
        S1.A = 8'hBB;
        $display(" S1 = %0p",S1);
         
        S1.C = 8'h00;
        $display(" S1 = %0p",S1);
    end
 
endmodule*/


////          Unpacked struct                  ////////

//  default struct is unpacked type.
//  no need to use unpacked keyword here.
//  unpacked datatypes can be used in this struct.

/*
module TOP;
 
typedef struct // UNPACKED STRUCT
    {
        bit [7:0]A;
        bit      B[8]; //UNPACKED DATATYPE
        bit [7:0]C;
    } STRUCT_1;
 
STRUCT_1 S1;
 
initial 
    begin
        S1 = '{8'hAA,{0,1,1,0,1,1,1,1},8'hFF};
        $display(" S1 = %0p",S1);
         
        S1.A = 8'hBB;
        $display(" S1 = %0p",S1);
         
        S1.C = 8'h00;
        $display(" S1 = %0p",S1);
         
        S1.B[0] = 1;
        $display(" S1 = %0p",S1);
    end
 
endmodule*/


/////////////////        Unions           //////////////////////

// similar to struct but only one of the data type can be used at a time.

/*Types of union : 
   Packed union : 
      only packed data types and integer datatypes can be use in packed union.      All member of packed union should be of same size. 
   Tagged union : 
      Tagged union is type-checked union. 
      Tagged union enforces type checking by inserting additional bits into the union so it is less useful in RTL coding.*/


/// packed union example

module TOP;
 
typedef struct packed // PACKED STRUCT
    {
        bit [7:0]A;
        bit      B;
        bit [7:0]C;
    } STRUCT_1;
 
typedef union packed
    {
        STRUCT_1       S1;
        bit      [16:0] D;
    } UNION_1;
 
UNION_1 U1;
 
initial 
    begin
        U1.S1 = {8'hAA,1'b0,8'hFF};
        $display(" U1 = %0p  U1.S1 = %0h  U1.D = %0h",U1,U1.S1,U1.D);
         
        U1.D  = 17'h1_FF_FF;
        $display(" U1 = %0p  U1.S1 = %0h  U1.D = %0h",U1,U1.S1,U1.D);
    end
 
endmodule 


// tagged union ex 

module TOP;
 
typedef union tagged // PACKED STRUCT
    {
        bit [7:0]A;
        bit      B;
        struct 
            {
                bit C;
                bit D;
            } STRUCT;
    } TAGGED_UNION;
 
TAGGED_UNION U1;
 
initial 
    begin
        U1 = tagged A  8'hFF;
        $display(" U1 = %0p  ",U1);
         
        U1 = tagged B  1;
        $display(" U1 = %0p  ",U1);
         
        U1 = tagged STRUCT {1,1};
        $display(" U1 = %0p  ",U1);
    end
 
endmodule
