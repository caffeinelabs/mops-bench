import Nat "mo:core/Nat";
import Buffer "mo:base/Buffer";
import Vector "mo:vector/Class";
import Bench "../src";

module {
	public func init() : Bench.Bench {
		let bench = Bench.Bench();

		bench.name("Vector vs Buffer");
		bench.description("Add items one-by-one");

		bench.rows(["Vector", "Buffer"]);
		bench.cols(["10", "10000", "1000000"]);

		bench.runner(func(row, col) {
			let ?n = Nat.fromText(col);

			// Vector
			if (row == "Vector") {
				let vec = Vector.Vector<Nat>();
				for (i in Nat.range(1, n+1)) {
					vec.add(i);
				};
			}
			// Buffer
			else if (row == "Buffer") {
				let buf = Buffer.Buffer<Nat>(0);
				for (i in Nat.range(1, n+1)) {
					buf.add(i);
				};
			};
		});

		bench;
	};
};