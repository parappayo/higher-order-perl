
sub integer_to_binary_string_recursive
{
	my ($integer) = @_;

	return ($integer == 0 || $integer == 1) ?
		$integer :
		integer_to_binary_string_recursive(int($integer/2)) . $integer % 2;
}

sub integer_to_binary_string
{
	my ($integer) = @_;
	my $result = "";

	while ($integer > 1) {
		$result = $integer % 2 . $result;
		$integer = int($integer/2);
	}

	return $integer . $result;
}

sub factorial_recursive {
	my ($n) = @_;
	return ($n == 0) ? 1 : factorial_recursive($n-1) * $n;
}

sub factorial {
	my ($n) = @_;
	my $result = 1;

	while ($n > 0) {
		$result *= $n--;
	}

	return $result
}

sub hanoi {
	my ($n, $start, $extra, $end, $move_disk) = @_;

	if ($n == 1) {
		$move_disk->(1, $start, $end);
		return;
	}

	hanoi($n-1, $start, $end, $extra, $move_disk);
	$move_disk->($n, $start, $end);
	hanoi($n-1, $extra, $start, $end, $move_disk);
}

sub hanoi_print {
	my ($n) = @_;

	hanoi($n, 'A', 'B', 'C', sub {
		my ($n, $start, $end) = @_;
		print("move disk $n from $start to $end\n");
	});
}

sub dir_walk {
	my ($root, $func) = @_;

	$func->($root);

	if (!(-d $root)) {
		return;
	}

	my $dir;
	my $file;

	unless (opendir $dir, $root) {
		warn "Failed to open dir $root: $!\n";
		return;
	}

	while ($file = readdir $dir) {
		next if $file eq '.' || $file eq '..' || -l $file;
		dir_walk("$root/$file", $func);
	}
}

# dir_walk('.', sub { printf "%6d %s\n", -s $_[0], $_[0] });
