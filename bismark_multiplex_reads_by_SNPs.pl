use strict;
use warnings;
use Switch;
use File::Basename;

my $bam = $ARGV[0]; #name of the bam input file
my $ref_chrom = $ARGV[1]; #Reference chrom name, for example 10q

my $dirname  = dirname($bam);
my $basename = basename($bam,".bam");

############################
### Need to change 
### Since we add 50 bp to the reference before the amplicon (helps alignment)
### we need to add 50bp to SNP position
############################
  switch ($ref_chrom) {
  case  "10q"
  {
	my $alt_base_pos = 89; # 39;
	my $alt_base = "A";
	my $ref_base = "G";
	my $alt_chrom_name = "2q";
	mutiplex_record($bam, $alt_base_pos, $alt_base,  $ref_base, $alt_chrom_name, "$dirname/ref_10q_$basename.sam", "$dirname/alt_2q_$basename.sam");


  }


  case "10q_61_repeats"
  {
	mutiplex_61_repeats($bam);
  }
  else
  {
	print "Case not fount\n";
  }

  }#End of switch


############################
### End of  changes 
############################


sub mutiplex_record {
 my $file = shift;
 my $alt_base_pos = shift;
 my $alt_base = shift;
 my $ref_base = shift;
 my $alt_chrom = shift;
 my $ref_file = shift;
 my $alt_file = shift;



 open (my $ref_fh, ">" ,$ref_file) || die "cannot open $ref_file";
 open (my $alt_fh, ">" ,$alt_file) || die "cannot open $alt_file";

 

 
 open (my $bam_fh, "/home/biorap/Tools/bin/samtools view -h $bam |") || die "cannot open $bam";
# open (my $bam_fh, "/Local/gcf/bin/samtools view -h $bam |") || die "cannot open $bam";

 while (my $record = <$bam_fh>)
 {

	 #print the header to all files
         if ($record =~ "^@")
	 {
		print $ref_fh $record;
		print $alt_fh $record;
		next;
	 }
  

	 my @tmp = split(/\t/,$record);
	 my $current_chrom = $tmp[2];
	 my $current_pos = $tmp[3] - 1;
	 my $current_seq = $tmp[9];
	 my $current_cigar = $tmp[5];


	# Remove records that are not sequenced from the begining of the record
	# We added 50 bases to the begining of the reference
	if ($current_pos > 55 )
	{
		next;
	}

	#If it is aligned after the SNP pos
	if (($current_pos + 1)  > $alt_base_pos)
	{
		#print " who am I  $current_pos:$alt_base_pos\n$record";
		next;
	}

	#Check thatthe record cover max snp position
	@tmp = split(/M/,$current_cigar);
	my $record_coverage = $tmp[0] + $current_pos;
	if ($record_coverage < $alt_base_pos)
	{	print " too short $record";
		next;
	}
	 
	 
	 #Print the read only if it has the known SNPs
	 my $current_base = substr($current_seq, $alt_base_pos - $current_pos - 1, 1);

	 if ($current_base eq $alt_base)
	 {
		if ($current_chrom eq $alt_chrom)
		{
			print $alt_fh $record;
		}
	 }
	 #There might be C-T changes in the ref than skip the check
	 elsif ($current_chrom eq $ref_chrom)
	 {
		print $ref_fh $record;
	 }


	 
 }	 
 
 close $bam_fh;
 close $ref_fh;
 close $alt_fh;

}



sub mutiplex_61_repeats {
 my $file = shift;
 my $dirname  = dirname($bam);
 my $basename = basename($bam,".bam");
 
############################
### Need to change 
### Since we add 50 bp to the reference before the amplicon (helps alignment)
### we need to add 50bp to SNP position
############################

  my %repeat_61_SNP_hash = (

	'10q' => {
			'alt_base_pos' => 0,
			'alt_base' => 'X',
			'ref_base' => 'X',
			'alt_chrom' => '10q-61-repeats',
	},

	'4q2q' => {# SNP position + 50 bp - added to the amplicon
			'alt_base_pos' => 178, #128
			'alt_base' => 'G',
			'ref_base' => 'T',
			'alt_chrom' => '4q/2q-61-repeats',
	},

	'13q_1' => { 	'alt_base_pos' => 212, #162
			'alt_base' => 'T',
			'ref_base' => 'G',
			'alt_chrom' => '13q-61-repeats',
	},

	'13q_2' => { 	'alt_base_pos' => 229, #179
			'alt_base' => 'A',
			'ref_base' => 'T',
			'alt_chrom' => '13q-61-repeats',
	},


	'21q_1' => { 	'alt_base_pos' => 171, #121
			'alt_base' => 'G',
			'ref_base' => 'T',
			'alt_chrom' => '21q-61-repeats',
	},

	'21q_2' => { 	'alt_base_pos' => 187, #137
			'alt_base' => 'A',
			'ref_base' => 'G',
			'alt_chrom' => '21q-61-repeats',
	}

);

############################
### Added 50 bp befor the SNP
############################
 my $alt_max_base_pos = 229; #179;
 my $alt_min_base_pos = 171; #121;

############################
### End of changes
############################



 my $ref_file      = "$dirname/ref_61repeats_$basename.sam";
 my $alt_4q2q_file = "$dirname/alt_4q2q_61repeats_$basename.sam";
 my $alt_13q_file  = "$dirname/alt_13q_61repeats_$basename.sam";
 my $alt_21q_file  = "$dirname/alt_21q_61repeats_$basename.sam";


 open (my $ref_fh, ">" ,$ref_file)         || die "cannot open $ref_file";
 open (my $alt_4q2q_fh,">" ,$alt_4q2q_file)|| die "cannot open $alt_4q2q_file";
 open (my $alt_13q_fh, ">" ,$alt_13q_file) || die "cannot open $alt_13q_file";
 open (my $alt_21q_fh, ">" ,$alt_21q_file) || die "cannot open $alt_21q_file";





 open (my $bam_fh, "/home/biorap/Tools/bin/samtools view -h $bam |") || die "cannot open $bam";
# open (my $bam_fh, "/Local/gcf/bin/samtools view -h $bam |") || die "cannot open $bam";

 while (my $record = <$bam_fh>)
 {

	 #print the header to all files
         if ($record =~ "^@")
	 {
		print $ref_fh $record;
		print $alt_4q2q_fh $record;
		print $alt_13q_fh $record;
		print $alt_21q_fh $record;
		next;
	 }
  

	 my @tmp = split(/\t/,$record);
	 my $current_chrom = $tmp[2];
	 my $current_pos = $tmp[3] - 1;
	 my $current_seq = $tmp[9];
	 my $current_cigar = $tmp[5];

	# Remove records that are not sequenced from the begining of the record
	# We added 50 bases to the begining of the reference
	if ($current_pos > 55 )
	{
		next;
	}

	#Check that the record cover max snp position
	@tmp = split(/M/,$current_cigar);
	my $record_coverage = $tmp[0] + $current_pos;
	if ($record_coverage < $alt_max_base_pos)
	{	#print " too short\t$record_coverage $record";	
		next;
	}


	#If the start position is smaller than min SNP position
	if ($alt_min_base_pos < ($current_pos + 1))
	{
		next;
	}

	my $print_flag = 0;
	my $SNP_chrom_name = '';
	#Check the exitence of known SNPs
   	for my $k1 ( sort keys %repeat_61_SNP_hash ) {
     	    if ($current_chrom eq $repeat_61_SNP_hash{$k1}{'alt_chrom'})
	    {	          

	        # If this is the ERFERENCE than set print_flag=1 and just check the other SNPs    
		if ($repeat_61_SNP_hash{$k1}{'alt_base_pos'} == 0 )
		{
			$SNP_chrom_name = $current_chrom;
			$print_flag = 1;
			last;
		}

            	
		my $current_base = substr($current_seq, $repeat_61_SNP_hash{$k1}{'alt_base_pos'} - $current_pos - 1, 1);

		if ($current_base eq $repeat_61_SNP_hash{$k1}{'alt_base'}) 
		{
			$print_flag = 1;
			$SNP_chrom_name = $current_chrom;
		}
		else
		{
			#print "cannot find my SNP $current_chrom:$current_base:$repeat_61_SNP_hash{$k1}{'alt_base_pos'}  $record";
			#If in the current chrom we cannot see the know SNPs - skip the record!
			$print_flag = 0;
			last;	
		}       	            		       		
   	    }
	}



	#If we detect the known SNPs - we check that there are not other kown SNPs from the alt chrom!!!
	if ($print_flag)
	{
   	    for my $k1 ( sort keys %repeat_61_SNP_hash ) 
	    {

	        # If this is the ERFERENCE SNP than don't check     
		if ($repeat_61_SNP_hash{$k1}{'alt_base_pos'} == 0 )
		{
			next;
		}


     		if ($current_chrom ne $repeat_61_SNP_hash{$k1}{'alt_chrom'})
		{
			my $current_base = substr($current_seq, $repeat_61_SNP_hash{$k1}{'alt_base_pos'} - $current_pos - 1, 1);
			if ($current_base eq $repeat_61_SNP_hash{$k1}{'alt_base'}) 
			{
		#print "There is a SNP that should not be: $current_chrom-$current_base:$repeat_61_SNP_hash{$k1}{'alt_base_pos'}\n$record";
				
				$print_flag = 0;
				last;
			}      	            		       		
   	 	}
	    }
	}# End if


############################
### Need to change 
############################

	if ($print_flag)
	{
		switch ($SNP_chrom_name) {
		case '10q-61-repeats'   {print  $ref_fh $record}
		case '4q/2q-61-repeats' {print  $alt_4q2q_fh $record}
		case '13q-61-repeats'   {print  $alt_13q_fh $record}
		case '21q-61-repeats'   {print  $alt_21q_fh $record}
		}
	}#End if

############################
### End of changes
############################


 }	 





close $ref_fh;
close $alt_4q2q_fh;
close $alt_13q_fh;
close $alt_21q_fh;


}



