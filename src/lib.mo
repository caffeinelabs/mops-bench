module {
	let VERSION = 1;

	public type BenchSchema = {
		name : Text;
		description : Text;
		rows : [Text];
		cols : [Text];
	};

	public type BenchResult = {
		instructions : Int;
		rts_mutator_instructions : Int;
		rts_collector_instructions : Int;
		rts_heap_size : Int;
		rts_memory_size : Int;
		rts_total_allocation : Int;
	};

	class BenchHeap() {
		type List = {
			value : Any;
			var next : ?List;
		};

		let list : List = {
			value = null;
			var next = null;
		};

		var last = list;

		public func add(value : Any) {
			let next : List = {value = value; var next = null};
			last.next := ?next;
			last := next;
		};
	};

	public class Bench() {
		var name_ = "";
		var description_ = "";
		var rows_ : [Text] = [];
		var cols_ : [Text] = [];
		var runner_ = func(_row : Text, _col : Text) {};

		// public let heap : BenchHeap = BenchHeap();

		public func name(value : Text) {
			name_ := value;
		};

		public func description(value : Text) {
			description_ := value;
		};

		public func rows(value : [Text]) {
			rows_ := value;
		};

		public func cols(value : [Text]) {
			cols_ := value;
		};

		public func runner(fn : (row : Text, col : Text) -> ()) {
			runner_ := fn;
		};

		// INTERNAL
		public func getVersion() : Nat {
			VERSION;
		};

		public func getSchema() : BenchSchema {
			{
				name = name_;
				description = description_;
				rows = rows_;
				cols = cols_;
			}
		};

		public func runCell(rowIndex : Nat, colIndex : Nat) {
			let row = rows_.get(rowIndex);
			let col = cols_.get(colIndex);
			runner_(row, col);
		};
	};
};