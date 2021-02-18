
@quarter = $quarter ? ($quarter) : ();
print "$_\n" for "foo", @quarter, "baar";
$quarter = "qqqqq";
my @quarter = $quarter ? ($quarter) : ();
print "$_\n" for "wus", @quarter, "end";


