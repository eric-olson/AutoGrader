<?xml version="1.0"?>

<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:date="http://exslt.org/dates-and-times"
                extension-element-prefixes="date">

<xsl:template match="/">
<table style="border:1px solid black;width:100%;height:50px;">
<tr>
  <xsl:for-each select="testsuites/testsuite/testcase">
    <xsl:choose>
      <xsl:when test="failure">
        <td bgcolor="red"/>
      </xsl:when>
      <xsl:otherwise>
        <td bgcolor="green"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
</tr>
</table>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="testsuites">
  <table border="0" cellspacing="15"><tr>
  <td><b>Tests run: <xsl:value-of select="@tests"/></b></td>
  <td><b style="color:green">Successes: <xsl:value-of select="@tests - @failures"/></b></td>
  <td><b style="color:red">Failures: <xsl:value-of select="@failures"/></b></td>
  </tr></table>

  <xsl:if test="@failures &gt; 0">
    <hr/>
    <b>Failed tests:</b>
    <ul>
    <xsl:apply-templates/>
    </ul>
  </xsl:if>

  <xsl:if test="@failures = 0">
    <hr/>
    <h2>Congratulations</h2>
    <b style="color:green">All tests passed!</b>
    <p/>
  </xsl:if>

  <hr/>
  <small>
  <i>Run on <xsl:value-of select='substring-before(date:date-time(),"T")'/>
     at <xsl:value-of select='substring-before(date:time(),"-")'/>
     in <xsl:value-of select="@time"/> seconds.
  </i>
  </small>
</xsl:template>

<xsl:template match="testsuite/testcase[failure]">
  <li>Function failed with message: <xsl:value-of select="failure/@message"/>
  </li>
</xsl:template>

<xsl:template match='testsuite/testcase[failure][starts-with(@classname,"inputs")]'>
  <li>Function failed on input: <xsl:value-of select='substring-before(@value_param,":")'/>:<br/>
  with message: <xsl:value-of select='failure/@message'/>
  </li>
</xsl:template>

<xsl:template match='testsuite/testcase[failure][starts-with(@classname,"inputs")][contains(failure/@message,"Expected")]'>
  <li>Function failed on input: <xsl:value-of select='substring-before(@value_param,":")'/>:<br/>
  your output was: <xsl:value-of select='substring-before(substring-after(failure/@message,"Actual: "), "Expected:")'/><br/>
  expected output: <xsl:value-of select='substring-after(failure/@message,"Which is:")'/>
  </li>
</xsl:template>


</xsl:stylesheet> 
