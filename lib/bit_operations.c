int getMaxInt()
{
	// get maximum int value
	return (1 << 31) -1;
}

int getMinInt()
{
	// get minimum int value
	return 1 << 31;
}

int mulTwo(int n)
{
	// multiply by 2
	return n << 1;
}

int divTwo(int n)
{
	// divide by 2
	return n >> 1;
}

int mulTwoPower(int n, int m)
{
	// power multiply
	return n << m;
}

void swap(int *a, int *b)
{
	// exchange values of two variables
	(*a) ^= (*b) ^= (*a) ^= (*b);
}

int max(int x, int y)
{
	// get bigger of two values
	return x ^ ((x ^ y) & -(x < y));
}

int min(int x, int y)
{
	// get smaller of two values
	return y ^ ((x ^ y) & -(x < y));
}
