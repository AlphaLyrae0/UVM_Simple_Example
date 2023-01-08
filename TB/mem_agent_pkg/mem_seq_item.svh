
class mem_seq_item extends uvm_sequence_item;
  //rand    bit         en;
  //rand    bit         we;
    rand    kind_e      acc ;
    rand    bit   [3:0] addr;
    rand    logic [7:0] data;

    `uvm_object_utils_begin(mem_seq_item)
      //`uvm_field_int(en   , UVM_ALL_ON)
      //`uvm_field_int(we   , UVM_ALL_ON)
      //`uvm_field_int (        wdata, UVM_ALL_ON)
        `uvm_field_enum( kind_e, acc , UVM_ALL_ON)
        `uvm_field_int (         addr, UVM_ALL_ON | UVM_DEC)
        `uvm_field_int (         data, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "mem_seq_item");
        super.new(name);
    endfunction

endclass
