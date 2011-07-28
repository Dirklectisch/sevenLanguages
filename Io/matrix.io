Matrix := List clone

Matrix init := method(
	for(i, 1, self size, 
		self atPut(i-1, self at(i-1) clone)
	)
)

Matrix dim := method(x, y,
	for(i, 1, y,
		xl := list()
		for(i, 1, x,
			xl append(nil)
		)
		self append(xl)
	)
)

Matrix set := method(x, y, v,
	self at(y-1) atPut(x-1, v)
)

Matrix get := method(x, y,
	self at(y-1) at(x-1)
)

Matrix transpose := method (
	new_matrix := Matrix clone
	
	new_matrix dim(
		self size,
		self at(0) size
	)
	
	for(iy, 1, self size,
		for(ix, 1, self at(iy-1) size,
			new_matrix set(iy, ix, 
				self get(ix, iy) 
			)
		)
	)
	return new_matrix
)

Matrix save := method (fn,

	f := File with(fn)
	f remove
	f openForAppending
	
	for(iy, 1, self size,
		f write(
			self at(iy-1) join(","), "\n"			
		)
	)
	
	f close
)

Matrix load := method (fn,
	
	f := File with(fn)
	f openForReading
	matrix := list()
	
	f foreachLine(i, v,
		matrix append (v split(",")) 
	)
	
	return matrix
)