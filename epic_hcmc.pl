############################################################
# hcmc - hardcore minecraft remote command
# adventure past this journey 
# to an unknown treasure of delight
############################################################
#!/usr/local/bin/perl
use strict; use warnings;
use Minecraft::RCON;
############################################################
#### FILL IN ###############################################
my $port;
my $pass;

my @player; my %player; my %rep;
my ($old, $update, $rcon, $new, $x, $y);
my ($fh, $lfh);

rep();

open($lfh, '>>', 'PING');
$lfh->autoflush(1);

open($fh, '<', 'list');
@player = readline $fh;
close $fh; chomp @player;
close $fh;

$player{$_} = 0 for (@player);

$rcon = Minecraft::RCON->new({
		address => '127.0.0.1',
		port => $port,
		password => $pass,
});

############################################################
if ($rcon->connect)
{ 
	$rcon->command('setworldspawn 0 72 0');
}
else 	
	{ print "FAIL $!\n"; }
print "$_\n" for (values %rep);

while (1)
{
	my @list; my $list;

	$list = $rcon->command('list');
	$list =~ s/.*online://;
	$list =~ s/,//g;
	@list = split(" ", $list);

	print $lfh "$_\n" for (@list);

	my $blk = rand_blk();
	$rcon->command("give \@a $blk 1"); 
	$rcon->command('effect @a 11 30 7');
	$rcon->command('effect @a 1 30 4');
	newb($rcon);

	sleep 600;	
}
$rcon->disconnect;
############################################################
sub rep
{
	open(my $ifh, '<', 'PING');
	my @content = readline $ifh;
	close $ifh; chomp @content;

	$rep{$_} += 1 for (@content);
}
sub newb
{
	my ($rcon) = @_;
	my ($x, $y) = num();
	my @update;

	$update = $rcon->command('list');
	$update =~ s/.*online://;
	$update =~ s/,//g;
	@update = split(" ", $update);

	for (@update) 
	{
		unless (exists $player{$_})
		{ 
			$rcon->command("give $_ boat 1"); 
			$rcon->command("give $_ compass 1"); 
			$rcon->command("effect $_ 11 10 20");
			$rcon->command("teleport $_ $y 170 $x"); 
	
			open($fh, '>>', 'list');
			print $fh "$_\n";
			close $fh;

			sleep 1; $rcon->command("msg $_ one time teleportation"); 
			sleep 1; $rcon->command("msg $_ merry killins muthrfkr"); 
			sleep 1; $rcon->command("msg $_ good luck on journey to 0-70-0"); 
			sleep 2; $rcon->command("msg $_ prove yourself"); 
			$player{$_}=0;
			
		}
	}
}
sub num
{
	$x = int(rand(100000-50000) + 50000);
	$y = int(rand(100000-50000) + 50000);
	return $x, $y;
}
sub rand_blk
{
	my @blks = qw(stone emerald red iron coal cobblestone red gold iron gold iron iron iron);
	my $i = int(rand(7));
	my $block = "$blks[$i]_block";
	return $block;
}
