#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use LWP::UserAgent;
use JSON;
binmode STDOUT, "utf8";
my @tests = test_text ();
for my $test (@tests) {
    run_a_test ($test);
}
exit;

sub run_a_test
{
    my ($text) = @_;
    my $ua = LWP::UserAgent->new ();
    $ua->agent ("kanji-cgi-test-script");
    my $url = 'http://kanji.sljfaq.org/kanji-0.016.cgi';
    my $req = HTTP::Request->new (POST => $url);
    $req->content ($text);
    my $res = $ua->request ($req);
    if ($res->is_success) {
        my $reply = decode_json $res->content;
        print $reply->{status}, "\n";
        print join ", ", @{$reply->{results}};
        print "\n";
    }
    else {
        print "FAILED: ",$res->status_line, "\n";
    }
}

sub test_text
{
my $data1 =<<EOF;
HL 2x112x122x152y182y1c2z1f2z1h301k301o311r311v311y3122322432253326
0m2d0n2d0p2d0t2d0w2d102d162d1d2d1k2d1t2d202d282d2g2b2n2b2v2b332b392b3h2b3o2b3u2b402b472b4c2b4i2b4m2b4p2b4t2b4v2b4x2b4z2b522b552b572b592b5b2b5d2b5f2b5h2b5k2b5m2b5n2b5o2b5p2b
282k282l282n282q282t272w272z27332736273a273c273g273j273m273p273s273u273w273y27412743274427452746274727482749
3v2e3v2f3v2g3v2i3v2k3v2n3v2q3v2t3v2v3v2y3v313v343v363v383v3a3v3b3v3c3v3e3v3g3v3h3v3i3v3j3v3l3v3n3v3p3v3s3v3u3v3v3v3w3v3y3v3z3v403v423v433v443v453v483v493v4a3v4c3v4d3v4e3v4f3v4g3u4g3t4g3s4f3r4f3q4e3p4e3o4e3o4d3n4d3m4d3m4c3l4c3k4c3k4b3j4b3i4b3h4a3g4a3g49
1r2q1q2q1p2q1o2r1n2s1k2u1j2v1h2x1d2z1a311533133510370y390v3b0s3d0r3e0o3f0n3g0m3h0k3i0j3j
492n4a2p4d2r4e2t4g2w4h2x4j304l324o354p384r3a4s3c4u3e4x3g4z3j513k523l533n533o533p533q
EOF

my $data2 =<<EOF;
HZ 66 90 69 90 70 90 73 90 76 90 81 90 86 90 92 90 97 90 105 90 111 90 119 90 124 90 127 90 130 90 133 90 134 90 134 90
94 90 92 90 92 92 91 93 90 94 89 100 87 104 85 108 82 115 78 119 74 124 71 127 70 128 67 130 65 131 63 132 60 133 58 135 55 136 54 137 52 137 52 137
83 119 82 119 81 120 80 123 80 126 80 128 80 132 80 137 80 143 80 147 80 151 80 153 80 152 80 151 80 151
81 122 82 122 84 121 87 120 88 120 89 119 91 118 92 118 93 118 97 116 98 115 99 115 101 114 102 114 103 114 104 114 106 113 107 113 108 113 110 113 111 113 112 113 113 115 115 117 116 118 117 121 119 124 121 129 121 131 121 134 121 137 121 139 121 140 120 142 120 143 120 144 119 146 118 147 118 148 118 150 117 152 117 154 117 154
81 154 82 154 87 154 88 154 95 154 98 154 103 154 107 154 111 154 115 154 116 154 119 154 121 154 122 154 123 154 123 154

EOF
return ($data1, $data2);
}
