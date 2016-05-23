<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/course">
	<html>
		<head>
			<title>CSCI Lab Problems</title>
			<style type="text/css">
body {
  counter-reset: globalcounter;
}

TABLE {
   border: 1px solid black;
   border-collapse: collapse;
   counter-reset: aptcounter;
   counter-increment: tablecounter;
}
TD{
   border: 1px solid black;
   padding: 3px;
}
TH{
   border: 1px solid black;
   padding: 5px;
   background-color: #B0B0B0;
}
TD.probdesc{
   border-top: 1px solid black;
   border-bottom: 1px solid black;
   background-color: #B0B0B0;
}
TD.probdesc:before{
#  content: "(" counter(tablecounter) ") ";
  background-color: #B0B0B0;
}

TD.submit{
  border-top: 1px solid black;
  background-color: #B0B0B0;
}

TD.numbered {
  border: 0px solid black;
  background-color: #DCDCDC;
}

TD.hint {
  border: 0px solid white;
  background-color: #DCDCDC;
}

body {
  background-color: #E8E8E8;
}

		</style>

  </head>

  <body>
    <H1>CSCI Lab Problems</H1>

<UL>
<LI> Choose the problem you want to submit/test --- you should look at
the problem statement, think about how to solve it, then write code to
solve it. After you've tested via the online testing mechanism you'll
need to submit the code for grading via Blackboard. </LI>

<LI> Click <em>Browse...</em> to choose the file on your local system
        you'll test online.</LI>

<LI> Click <em>test/run</em> to test the program.</LI>
<P/>
</UL>

<xsl:apply-templates/>

	</body>
</html>
</xsl:template>

<xsl:template match="problemset">
	<form method="post" type="multipart/form-data" action="http://eecs-grader.mines.edu/cgi-bin/submit.cgi">
		<table>
			<tr><th width="700px">Problem Set <xsl:value-of select="@num"/></th></tr>
			<xsl:if test="@comment">
				<tr><td class="probdesc"><xsl:value-of select="@comment"/></td></tr>
			</xsl:if>
			<tr>
				<td valign="top"><p/>
					<xsl:apply-templates/>
				</td>
			</tr>
			<tr>
				<td>
					<input type="file" name="source_file" accept=".cpp,.cxx,.cc,.c"/><br/>
					<center><input type="submit" value="test/run"/></center>
				</td>
			</tr>
		</table>
	</form>
	<p/>
</xsl:template>

<xsl:template match="problem">
						<input type="radio" name="problem">
							<xsl:attribute name="value"><xsl:value-of select="translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/></xsl:attribute>
						</input>
						<a>
							<xsl:attribute name="href">
								<xsl:value-of select="concat(concat('http://eecs-grader.mines.edu/grader/probdesc/',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')),'.html')"/>
							</xsl:attribute>
							<xsl:value-of select="."/>
						</a>
						<br/>
</xsl:template>

</xsl:stylesheet>
