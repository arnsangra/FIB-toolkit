#! /usr/bin/perl
# perl script to generate custom headers of college's assignment tasks.

#TO DO:
#	1) check file existance before overwrite
#	2) enhance of output 
# 	3) C/C++ improval with /* */
#
use feature qw(say);
use strict;
use Getopt::Std;

# declare the perl command line flags/options we want to allow
my %options=();
getopts("hl", \%options);

my %lang_comm_char = (
	'bash' => '#',
	'c' => '//',
	'c++' => '//',
	'java' => '//',
	'latex' => '%',
	'perl' => '#',
	'python' => '#',
	'prolog' => '%'
	);

my %lang_file_ext = (
	'bash' => '.sh',
	'c' => '.c',
	'c++' => '.cpp',
	'java' => '.java',
	'latex' => '.tex',
	'perl' => '.pl',
	'python' => '.py',
	'prolog' => '.pl'
	);

my $rule = 80;

sub say_help() {
	say "This is the help";
}

sub say_usage() {
	say "Usage: mkhd \[-h\] \| \"assignment_title\"";
}

sub say_supported_lang() {
	say "Currently supported languages are:";
	for my $key (keys %lang_comm_char) {
		print "\t- " . $key . ' ' . "\t(" . $lang_comm_char{$key} . ")\n"; 
	}
}

sub printCommLine() {
    for (my $i = 0; $i < $rule; $i++) {
	print $fh $comm;
    }
}

if (@ARGV eq 0) {
	say "Error, incorrect parameters";
	do_usage();
}
else {
	if ($options{h}) {
		say_help();
		say_usage();
	}
	elsif ($options{l}) {
		say_supported_lang();
	}
	else {
		print "Who are you? ";
		my $author = <STDIN>;
		print "What subject? ";
		my $subject = <STDIN>;
		
		my $lang = "";
		my $comm = "";
		my $fext = "";
		my $match = 0;
		while ($match eq 0) {
			print "Which is programming language? ";
			$lang = <STDIN>;
			if ($lang =~ "^l") {
				say_supported_lang();
			}
			else {
				chomp ($lang);
				if (exists($lang_comm_char{$lang})) {
					$comm = $lang_comm_char{$lang};
					$fext = $lang_file_ext{$lang};
					$match = 1;
				}
				else {
					chomp($lang);
					say "$lang is not currently supported, consider adding it!";
					say "To check available languages, type \"l\"";
				}
			}
		}

		my $file = shift @ARGV;
		my $filename = $file . $fext;
		open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";

		my $center = (($rule - lenght($subject)) / 2);
		
		printCommLine();

		# subject
		print $fh "\n" . $comm;

		for (my $i = 0; $i < $center; $i++) {
		    print $fh ' ';
		}
		print $fh $subject;
		for (my $i = 0; $i < $center; $i++) {
		    print $fh ' ';
		}
		
		printCommLine();

		# author
		for (my $i = 0; $i < $rule; $i++) {
			print $fh $comm;
		}
		print $fh "\n" . $comm;
		for (my $i = 0; $i < $rule; $i++) {
			if ($i == $rule/2) {
				print $fh $author;
			}
			else {print $fh ' ';}
		}
		print $fh $comm . "\n";
	}
}
