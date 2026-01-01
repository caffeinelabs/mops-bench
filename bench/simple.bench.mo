import List "mo:core/List";
import Nat "mo:core/Nat";
import PureList "mo:core/pure/List";
import Runtime "mo:core/Runtime";
import Bench "../src";

module {
	public func init() : Bench.Bench {
		let bench = Bench.Bench();

		bench.name("List vs PureList");
		bench.description("Add items one-by-one");

		bench.rows(["List", "PureList"]);
		bench.cols(["10", "10000", "1000000"]);

		bench.runner(func(row, col) {
			let ?n = Nat.fromText(col) else Runtime.trap("Invalid column value: " # col);

			// Vector
			if (row == "List") {
				let list = List.empty<Nat>();
				for (i in Nat.range(1, n+1)) {
					list.add(i);
				};
			}
			// Buffer
			else if (row == "PureList") {
				var list = PureList.empty<Nat>();
				for (i in Nat.range(1, n+1)) {
					list := list.pushFront(i);
				};
			};
		});

		bench;
	};
};