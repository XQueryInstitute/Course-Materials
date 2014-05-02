<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
  exclude-result-prefixes="xd exsl estr edate a fo local rng tei teix"
  extension-element-prefixes="exsl estr edate" version="2.0"
  xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
  xmlns:edate="http://exslt.org/dates-and-times"
  xmlns:estr="http://exslt.org/strings" xmlns:exsl="http://exslt.org/common"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:local="http://www.pantor.com/ns/local"
  xmlns:rng="http://relaxng.org/ns/structure/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:teix="http://www.tei-c.org/ns/Examples"
  xmlns:xd="http://www.pnp-software.com/XSLTdoc"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xd:doc type="stylesheet">
    <xd:short> TEI stylesheet for Folger Digital Texts. </xd:short>
    <xd:detail> This library is free software; you can redistribute it and/or
      modify it under the terms of the GNU Lesser General Public License as
      published by the Free Software Foundation; either version 2.1 of the
      License, or (at your option) any later version. This library is
      distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
      without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
      PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
      details. You should have received a copy of the GNU Lesser General Public
      License along with this library; if not, write to the Free Software
      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA </xd:detail>
  </xd:doc>
  <xsl:output method="html" encoding="UTF-8"/>
<xsl:strip-space elements="*"/>
<xsl:preserve-space elements="tei:c"/>
  <xsl:template match="/">
	<html>
	<head>
	  <title><xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<style type="text/css" media="screen,print">@import "fdt.css";</style>
  <script type="text/javascript">
    var smartCopyYN = true;
    function smartCopy() {
      if (smartCopyYN == false) return true;
      if (navigator.appVersion.indexOf("MSIE")!=-1) {
        document.getElementById('copyPaste').style.visibility = "hidden";
      }
      var html = "";
      var top = window.pageYOffset || document.documentElement.scrollTop;
      if (typeof window.getSelection != "undefined") {
        var sel = window.getSelection();
        if (sel.rangeCount) {
          var container = document.createElement("div");
          for (var i = 0, len = sel.rangeCount; i &lt; len; ++i) {
            container.appendChild(sel.getRangeAt(i).cloneContents());
          }
          html = container.innerHTML;
        }
      } else if (typeof document.selection != "undefined") {
        if (document.selection.type == "Text") {
          html = document.selection.createRange().htmlText;
        }
      }
      document.getElementById('copyPaste').innerHTML = html;
      cpObj = document.getElementById('copyPaste');
      var objs = cpObj.getElementsByTagName('a');
      for (var i = objs.length-1; i >= 0; i--) { objs[i].parentNode.removeChild(objs[i]); }
      var objs = cpObj.getElementsByTagName('hr');
      for (var i = objs.length-1; i >= 0; i--) { objs[i].parentNode.removeChild(objs[i]); }

      var objs = cpObj.getElementsByTagName('*');
      for (var i = objs.length-1; i >= 0; i--) { 
        if (objs[i].className) {
          var className = objs[i].className;
          var matchNodes = "ftln,lineNbr,pageHeading,actFooter";
          if (matchNodes.indexOf(className) != -1) {
            objs[i].parentNode.removeChild(objs[i]);
          } else if (className.indexOf('alignment') != -1) {
            objs[i].parentNode.removeChild(objs[i]);
          }
        }
      }
      if (window.getSelection) {
        window.getSelection().removeAllRanges();
        var range = document.createRange();
        range.selectNode(document.getElementById('copyPaste'));
        window.getSelection().addRange(range);
      } else if (document.selection) {
        document.selection.empty();
        var range = document.body.createTextRange();
        range.moveToElementText(document.getElementById('copyPaste'));
        range.select();
      }

      window.scrollTo(0,top);
    }

    function showHideLineNbrs() {
      var obj = document.getElementById('LineNbrBtn');
      if (obj.innerHTML == "Hide Line Nbrs") {
        hideLineNbrs();
        obj.innerHTML = "Show Line Nbrs";
        obj.title = "Show FTLN and Line Numbers";
      } else {
        obj.innerHTML = "Hide Line Nbrs";
        obj.title = "Hide Line Numbers (e.g., for cut and paste)";
        showLineNbrs();
      }
    }
    function hideLineNbrs() {
      var objs = document.getElementById('pageBlock').getElementsByTagName('a');
      for (var i = objs.length-1; i >= 0; i--) {
        objs[i].innerHTML = "";
      }
    }
    function showLineNbrs() {
      var objs = document.getElementById('pageBlock').getElementsByTagName('a');
      for (var i = objs.length-1; i >= 0; i--) {
        if (objs[i].className == 'ftln') {
          var str = objs[i].name.toUpperCase();
          objs[i].innerHTML += str.replace('-',' ');
        }
        if (objs[i].className == 'lineNbr') {
          var str = objs[i].name;
          var lineNbr= str.substr(str.lastIndexOf('.')+1);
          if (lineNbr>0) {
          if (lineNbr%5==0) {
            objs[i].innerHTML += str.substr(str.lastIndexOf('.')+1);
          }
          }
        }
      }
    }
    
    alignSplitLinesCmd = "";
    function alignSplitLines(line,prevLine,startOrEnd) {
        var targets = prevLine.split(' ');
        if (targets.length > 1) {
          var lastTarget = targets[targets.length-1];
        } else {
          var lastTarget = String(targets);
        }       
        lastTarget = lastTarget.replace('#','');
        if (lastTarget) {
          obj = document.getElementById(line);
          pObj = document.getElementById(lastTarget);
          var padding = (pObj.offsetLeft + pObj.offsetWidth) - obj.offsetLeft + obj.offsetWidth + "px";
          if (startOrEnd == 'E') {
            var padding = (pObj.offsetLeft + pObj.offsetWidth) - obj.offsetLeft + obj.offsetWidth + "px";
            } else {
            var padding = (pObj.offsetLeft) - obj.offsetLeft + obj.offsetWidth + "px";
          }
          if (parseInt(padding) &lt; 0) { padding = "0px"; }
          obj.style.paddingLeft = padding;
        }
    }

    alignSegsCmd = "";
    function alignSegs(id,id1,seg) {
      var pad0 = 15;
      var obj = document.getElementById(id);
      var obj1 = document.getElementById(id1);
      if (obj !== obj1) {
        var padding = (obj1.offsetLeft - obj.offsetLeft) + (obj1.offsetWidth - obj.offsetWidth) + parseInt(obj.style.paddingLeft);
        if (padding > 0) { obj.style.paddingLeft = padding + 'px'; }
      } else {
        if (seg) {
          var objx = document.getElementById(seg);
          newpadding = (430-objx.offsetWidth)/2;
          padding = newpadding + pad0 - (obj.offsetLeft+obj.offsetWidth);
          if (padding &lt; 10) { padding = 10; }
          obj.style.paddingLeft = padding + 'px';
        }
      }
    }
    //window.onload=function() { eval(alignSplitLinesCmd);};
    //window.onload=function() { eval(alignSegsCmd);};
    window.onload=function() { eval(alignSplitLinesCmd); eval(alignSegsCmd);};
  </script>
	</head>
        <body onCopy="smartCopy();">
          <div id="copyPaste" style="top:0px;left:0px;width:1px;height:1px;overflow:hidden;"></div>
          <div id="pageBlock" class="pageBlock">
            <div class="textBlock">
	            <xsl:apply-templates/>
            </div>
          </div>
        </body>
        </html>
  </xsl:template>

  <xsl:template name="contents">
    <table class="contents">
    <tbody>
      <tr>
      <td class="act">Front Matter</td>
      <td>
      <ul class="nav">
        <li class="scene"><a id="locFromTheDirector" href="#FromTheDirector" class="scene">From the Director of the Folger Shakespeare Library</a></li>
        <li class="scene"><a id="locTextualIntroduction" href="#TextualIntroduction" class="scene">Textual Introduction</a></li>
        <li class="scene"><a id="locsynops" href="#synopsis" class="scene">Synopsis</a></li>
        <li class="scene"><a id="loccastlist" href="#characters" class="scene">Characters in the Play</a></li>
      </ul>
      </td>
      </tr>
      <xsl:for-each select="//tei:body//tei:div1">
      <tr>
      <td class="act">
      <xsl:choose>
      <xsl:when test="not(./tei:div2)">&#160;</xsl:when>
      <xsl:when test="./tei:head">
        <xsl:value-of select="./tei:head"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="processDivType"/>
      </xsl:otherwise>
      </xsl:choose>
      </td>
      <td>
      <ul class="nav">
      <xsl:if test="not(./tei:div2)">
        <li class="scene">
          <a id="locline-{@n}.0" href="#line-{@n}.0" class="scene">
          <xsl:call-template name="processDivType"/>
          </a>
        </li>
      </xsl:if>
      <xsl:for-each select="./tei:div2">
        <xsl:variable name="actNo" select="ancestor::tei:div1/@n" />
        <xsl:variable name="sceneNo" select="@n" />
        <li class="scene">
          <a id="locline-{$actNo}.{$sceneNo}.0" href="#line-{$actNo}.{$sceneNo}.0" class="scene">
            <xsl:call-template name="processDivType"/>
        </a>
        </li>
      </xsl:for-each>
      </ul>
      </td>
      </tr>
    </xsl:for-each>
    </tbody>
    </table>
  </xsl:template>
  <xsl:template name="processDivType">
    <xsl:choose>
    <xsl:when test="@type = 'induction'">Induction</xsl:when>
    <xsl:when test="@type = 'prologue'">Prologue</xsl:when>
    <xsl:when test="@type = 'chorus'">Chorus</xsl:when>
    <xsl:when test="@type = 'epilogue'">Epilogue</xsl:when>
    <xsl:when test="./tei:head"><xsl:value-of select="./tei:head"/></xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="@type"/>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="front">
    <xsl:apply-templates select="//tei:front/tei:div"/>
  </xsl:template>
    
  <xsl:template match="tei:del">
  </xsl:template>
  <xsl:template match="tei:app">
  </xsl:template>

  <xsl:variable name="rdg" select="'lemma'" />
  <xsl:variable name="emendDesc" select="//tei:interp[@xml:id='emend']" />
  <xsl:variable name="textaDesc" select="//tei:interp[@xml:id='texta']" />
  <xsl:variable name="textbDesc" select="//tei:interp[@xml:id='textb']" />

  <xsl:template match="tei:teiHeader">
    <xsl:apply-templates select="//tei:titleStmt"/>
    <xsl:apply-templates select="//tei:particDesc"/>
  </xsl:template>
  <xsl:template match="tei:front">
  </xsl:template>
  <xsl:template match="tei:back">
  </xsl:template>

  <xsl:template match="tei:titleStmt">
    <div class="div1">
	  <xsl:variable name="id" select="//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno"/>
	  <xsl:variable name="title" select="//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
    <img class="titleImg" src="{$id}titleblack.png" alt="{$title}"/>
    <div class="credits">
      <p>Folger Shakespeare Library</p>
      <p><a href="http://www.folgerdigitaltexts.org">http://www.folgerdigitaltexts.org</a></p>
    </div>
     <hr/>
    </div>
    <div id="contents" class="page div1">
     <div class="frontHeader">Contents</div>
     <xsl:call-template name="contents"/>
     <hr/>
    </div>
     <xsl:call-template name="front"/>
  </xsl:template>

  <xsl:template match="tei:particDesc">
    <div id="characters" class="page div1">
     <a name="castlist"/>
     <div class="frontHeader">Characters in the Play</div>
     <xsl:apply-templates/>
     <hr/>
   </div>
  </xsl:template>

  <xsl:template match="tei:front/tei:div[@type='FromTheDirector']">
    <div id="FromTheDirector" class="page div1">
     <a name="FromTheDirector"/>
     <div class="frontHeader">From the Director of the Folger Shakespeare Library</div>
     <xsl:apply-templates/>
     <hr/>
   </div>
  </xsl:template>
  <xsl:template match="tei:front/tei:div[@type='TextualIntroduction']">
    <div id="TextualIntroduction" class="page div1">
     <a name="TextualIntroduction"/>
     <div class="frontHeader">Textual Introduction<br/>By Barbara Mowat and Paul Werstine</div>
     <xsl:apply-templates/>
     <hr/>
   </div>
  </xsl:template>
  <xsl:template match="tei:front/tei:div[@type='synopsis']">
    <div id="synopsis" class="page div1">
     <a name="synops"/>
     <div class="frontHeader">Synopsis</div>
     <xsl:apply-templates/>
     <hr/>
   </div>
  </xsl:template>
  <xsl:template match="tei:front//tei:lb">
    <br/>
  </xsl:template>
  <xsl:template match="tei:front//tei:p">
    <p><xsl:apply-templates/></p>
  </xsl:template>
  <xsl:template match="tei:front//tei:title">
    <span class="italic"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:front//tei:closer">
    <p class="signed"><xsl:apply-templates/></p>
  </xsl:template>
  <xsl:template match="tei:front//tei:signed">
    <span class="italic"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:front//tei:graphic">
    <xsl:variable name="alt" select="./tei:desc" />
    <img src="{@url}" class="imgTextX" alt="{$alt}"/>
  </xsl:template>
  <xsl:template match="tei:front//tei:seg[@rend='nobr']">
    <span style="white-space:nowrap"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:particDesc/tei:listPerson">
    <div class="lp" style="clear:both; margin:10px 0px"><xsl:apply-templates/></div>
  </xsl:template>
  <xsl:template match="tei:particDesc/tei:listPerson[tei:head]/tei:listPerson">
    <div class="lp" style="clear:both; margin:10px 0px"><xsl:apply-templates/></div>
  </xsl:template>
  <xsl:template match="tei:particDesc/tei:listPerson[tei:listPerson]/tei:head">
     <xsl:variable name="class" select="translate(@rend,',',' ')" />
     <div class="centered italic {$class}"><xsl:apply-templates/></div>
  </xsl:template>
  <xsl:template match="tei:listPerson/tei:listPerson[tei:head]">
    <div class="castDiv">
    <div class="castDiv"><xsl:apply-templates select="tei:person|tei:personGrp"/></div>
    <xsl:choose>
    <xsl:when test="count(tei:person/tei:persName)+count(tei:personGrp/tei:p) = 0">
      <p><xsl:apply-templates select="./tei:head"/></p>
    </xsl:when>
    <xsl:otherwise>
    <xsl:variable name="height" select="(count(tei:person/tei:persName)+count(tei:personGrp/tei:p))*20"/>
    <div class="bracketDiv" style="height:{$height}px;">
      <img src="fdt-bracket.png" style="height:100%;width:07px;" alt="bracket"/>
    </div>
    <div class="castHeadDiv" style="height:{$height}px;padding-left:5px;">
      <span class="castHead"><xsl:apply-templates select="./tei:head"/></span>
    </div>
    </xsl:otherwise>
    </xsl:choose>
    </div>
    <div style="clear:both;"></div>
  </xsl:template>
  <xsl:template match="tei:listPerson//tei:note">
  </xsl:template>
  <xsl:template match="tei:particDesc//tei:ab">
  </xsl:template>
  <xsl:template match="tei:particDesc//tei:person[tei:persName]">
    <div style="line-height:20px;"><xsl:apply-templates/><br/></div>
  </xsl:template>
  <xsl:template match="tei:particDesc//tei:personGrp[tei:persName|tei:p]">
    <div style="line-height:20px;"><xsl:apply-templates/><br/></div>
  </xsl:template>
  <xsl:template match="tei:particDesc//tei:name|tei:particDesc//tei:roleName">
    <span class="castName"><xsl:value-of select="."/></span>
  </xsl:template>
  <xsl:template match="tei:particDesc//tei:state">
    <span><xsl:text>, </xsl:text><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:particDesc//tei:state[starts-with(.,'(')]">
    <span><xsl:text> </xsl:text><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:sex|tei:death">
  </xsl:template>
  <xsl:template match="tei:particDesc//tei:title">
    <span class="italic"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:lb">
    <xsl:choose>
    <xsl:when test="not(@edRef)">
      <br/>
    </xsl:when>
    <xsl:when test="contains(@edRef,$rdg)">
      <br/>
    </xsl:when>
    <xsl:otherwise>
    </xsl:otherwise>
  </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:particDesc//tei:p//tei:lb">
    <br/><span class="alignment indent">&#160;</span>
  </xsl:template>

  <xsl:key name="actPage" match="tei:text/tei:body/tei:pb" use="substring(@spanTo,2)"/> 
  <xsl:key name="altRdg" match="tei:app[@from]" use="substring(@from,2)"/> 

  <xsl:key name="emend1" match="tei:div/tei:ab/tei:ptr[@type='emendation'][@ana='#emend']" use="substring(@target,2,8)"/> 
  <xsl:key name="emend2" match="tei:div/tei:ab/tei:ptr[@type='emendation'][@ana='#emend']" use="substring(@target,string-length(@target)-7)"/> 
  <xsl:key name="emend1r" match="tei:rdg/tei:ptr[@type='emendation'][@ana='#emend']" use="substring(@target,2,8)"/> 
  <xsl:key name="emend2r" match="tei:rdg/tei:ptr[@type='emendation'][@ana='#emend']" use="substring(@target,string-length(@target)-7)"/> 

  <xsl:key name="texta1" match="tei:div/tei:ab/tei:ptr[@type='emendation'][@ana='#texta']" use="substring(@target,2,8)"/> 
  <xsl:key name="texta2" match="tei:div/tei:ab/tei:ptr[@type='emendation'][@ana='#texta']" use="substring(@target,string-length(@target)-7)"/> 
  <xsl:key name="texta1r" match="tei:rdg/tei:ptr[@type='emendation'][@ana='#texta']" use="substring(@target,2,8)"/> 
  <xsl:key name="texta2r" match="tei:rdg/tei:ptr[@type='emendation'][@ana='#texta']" use="substring(@target,string-length(@target)-7)"/> 

  <xsl:key name="textb1" match="tei:div/tei:ab/tei:ptr[@type='emendation'][@ana='#textb']" use="substring(@target,2,8)"/> 
  <xsl:key name="textb2" match="tei:div/tei:ab/tei:ptr[@type='emendation'][@ana='#textb']" use="substring(@target,string-length(@target)-7)"/> 
  <xsl:key name="textb1r" match="tei:rdg/tei:ptr[@type='emendation'][@ana='#textb']" use="substring(@target,2,8)"/> 
  <xsl:key name="textb2r" match="tei:rdg/tei:ptr[@type='emendation'][@ana='#textb']" use="substring(@target,string-length(@target)-7)"/> 

  <xsl:template match="tei:pb">
    <a name="p{@n}"/>
    <hr class="noprint pageBorder"/>
    <div class="pageHeading">
      <div class="pageNbr">
        <xsl:value-of select="@n"/>
      </div>
      <div class="pageTitle">
        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
      </div>
      <div class="pageDesc">
        <xsl:value-of select="following-sibling::tei:fw"/>
      </div>
      <br/>
    </div>    
  </xsl:template>

  <xsl:template match="tei:text/tei:body/tei:pb">
    <a name="p{@n}"/>
  </xsl:template>
  <xsl:template match="tei:fw[@type='header']"></xsl:template>
  <xsl:template match="tei:milestone[@unit='page'][key('actPage',@xml:id)]">
        <div class="actFooter">
          <xsl:value-of select="@n"/>
        </div>
  </xsl:template>

  <xsl:template match="tei:div1">
     <xsl:choose>
     <xsl:when test="not(./tei:div2)">
       <a name="line-{@n}.0"/>
     </xsl:when>
     <xsl:otherwise>
       <a name="line-{@n}.0.0"/>
     </xsl:otherwise>
     </xsl:choose>
     <div class="div1">
       <xsl:if test="not(./tei:head)">
         <div class="page blankHeader"></div>
       </xsl:if>
       <xsl:apply-templates/>
     </div>
     <hr/>
  </xsl:template>
  <xsl:template match="tei:div1/tei:head">
     <div class="page actHeader"><xsl:apply-templates/></div>
  </xsl:template>
  <xsl:template match="tei:div2">
     <a name="line-{../@n}.{@n}.0"/>
     <div class="div2"><xsl:apply-templates/><br/><br/><br/></div>
  </xsl:template>
  <xsl:template match="tei:div2/tei:head">
     <div class="sceneHeader"><xsl:apply-templates/></div>
  </xsl:template>
  <xsl:template match="tei:floatingText//tei:head">
     <xsl:variable name="class" select="translate(@rend,',',' ')" />
     <div class="centered italic {$class}"><xsl:apply-templates/></div>
  </xsl:template>
  <xsl:template match="tei:floatingText//tei:head[@rend='inline']">
     <span class="italic"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:label">
     <xsl:variable name="class" select="translate(@rend,',',' ')" />
     <div class="centered italic {$class}"><xsl:apply-templates/></div>
  </xsl:template>
  <xsl:template match="tei:label[@rend]">
     <xsl:variable name="class" select="translate(@rend,',',' ')" />
     <span class="italic {$class}"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:speaker">
     <xsl:variable name="class" select="translate(@rend,',',' ')" />
     <span class="speaker {$class}"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:w|tei:c|tei:pc|tei:w/tei:seg|tei:anchor">
    <xsl:variable name="class" select="translate(@rend,',',' ')" />
    <span id="{@xml:id}" title="{@n}" class="{$class}">
      <xsl:call-template name="openWordMarks"/>
      <xsl:call-template name="showRdg"/>
      <xsl:call-template name="closeWordMarks"/>
    </span>
  </xsl:template>

  <xsl:template name="openWordMarks">
    <xsl:variable name="emend" select="key('emend1',@xml:id)|key('emend1r',@xml:id)/ancestor::tei:rdg[1][contains(@wit,$rdg)]"/> 
    <xsl:variable name="texta" select="key('texta1',@xml:id)|key('texta1r',@xml:id)/ancestor::tei:rdg[1][contains(@wit,$rdg)]"/> 
    <xsl:variable name="textb" select="key('textb1',@xml:id)|key('textb1r',@xml:id)/ancestor::tei:rdg[1][contains(@wit,$rdg)]"/> 
    <xsl:choose>
      <xsl:when test="(ancestor::tei:q[1]//tei:w|ancestor::tei:q[1]//tei:pc)/@xml:id = ./@xml:id and count($textb)">
        <xsl:variable name="q1" select="(ancestor::tei:q[1]//tei:w)[last()]/@xml:id" />
        <xsl:choose>
        <xsl:when test="$textb[contains(@target,$q1)]"> 
          <img src="fdt-textb-l.png" class="imgTextX" alt="{$textbDesc}" title="{$textbDesc}"/>
          <xsl:call-template name="openQuote"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="openQuote"/>
          <img src="fdt-textb-l.png" class="imgTextX" alt="{$textbDesc}" title="{$textbDesc}"/>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="(ancestor::tei:q[1]//tei:w|ancestor::tei:q[1]//tei:pc)/@xml:id = ./@xml:id and count($texta)">
        <xsl:variable name="q1" select="(ancestor::tei:q[1]//tei:w)[last()]/@xml:id" />
        <xsl:choose>
        <xsl:when test="$texta[contains(@target,$q1)]"> 
          <img src="fdt-texta-l.png" class="imgTextX" alt="{$textaDesc}" title="{$textaDesc}"/>
          <xsl:call-template name="openQuote"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="openQuote"/>
          <img src="fdt-texta-l.png" class="imgTextX" alt="{$textaDesc}" title="{$textaDesc}"/>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="(ancestor::tei:q[1]//tei:w|ancestor::tei:q[1]//tei:pc)/@xml:id = ./@xml:id and count($emend)">
        <xsl:variable name="q1" select="(ancestor::tei:q[1]//tei:w)[last()]/@xml:id" />
        <xsl:choose>
        <xsl:when test="$emend[contains(@target,$q1)]"> 
          <img src="fdt-emend-l.png" class="imgEmend" alt="{$emendDesc}" title="{$emendDesc}"/>
          <xsl:call-template name="openQuote"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="openQuote"/>
          <img src="fdt-emend-l.png" class="imgEmend" alt="{$emendDesc}" title="{$emendDesc}"/>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="count($textb)"> 
          <img src="fdt-textb-l.png" class="imgTextX" alt="{$textbDesc}" title="{$textbDesc}"/>
        </xsl:if>
        <xsl:if test="count($texta)"> 
          <img src="fdt-texta-l.png" class="imgTextX" alt="{$textaDesc}" title="{$textaDesc}"/>
        </xsl:if>
        <xsl:if test="count($emend)"> 
          <img src="fdt-emend-l.png" class="imgEmend" alt="{$emendDesc}" title="{$emendDesc}"/>
        </xsl:if>
        <xsl:call-template name="openQuote"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="closeWordMarks">
    <xsl:variable name="emend" select="key('emend2',@xml:id)|key('emend2r',@xml:id)/ancestor::tei:rdg[1][contains(@wit,$rdg)]"/> 
    <xsl:variable name="texta" select="key('texta2',@xml:id)|key('texta2r',@xml:id)/ancestor::tei:rdg[1][contains(@wit,$rdg)]"/> 
    <xsl:variable name="textb" select="key('textb2',@xml:id)|key('textb2r',@xml:id)/ancestor::tei:rdg[1][contains(@wit,$rdg)]"/> 
    <xsl:choose>
      <xsl:when test="(ancestor::tei:q[1]//tei:w|ancestor::tei:q[1]//tei:pc)[last()]/@xml:id = ./@xml:id and count($emend)">
        <xsl:variable name="q1" select="(ancestor::tei:q[1]//tei:w)[1]/@xml:id" />
        <xsl:choose>
        <xsl:when test="$emend[contains(@target,$q1)]"> 
          <xsl:call-template name="closeQuote"/>
          <img src="fdt-emend-r.png" class="imgEmend" alt="{$emendDesc}" title="{$emendDesc}"/>
        </xsl:when>
        <xsl:otherwise>
          <img src="fdt-emend-r.png" class="imgEmend" alt="{$emendDesc}" title="{$emendDesc}"/>
          <xsl:call-template name="closeQuote"/>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="(ancestor::tei:q[1]//tei:w|ancestor::tei:q[1]//tei:pc)[last()]/@xml:id = ./@xml:id and count($texta)">
        <xsl:variable name="q1" select="(ancestor::tei:q[1]//tei:w)[1]/@xml:id" />
        <xsl:choose>
        <xsl:when test="$texta[contains(@target,$q1)]"> 
          <xsl:call-template name="closeQuote"/>
          <img src="fdt-texta-r.png" class="imgTextX" alt="{$textaDesc}" title="{$textaDesc}"/>
        </xsl:when>
        <xsl:otherwise>
          <img src="fdt-texta-r.png" class="imgTextX" alt="{$textaDesc}" title="{$textaDesc}"/>
          <xsl:call-template name="closeQuote"/>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="(ancestor::tei:q[1]//tei:w|ancestor::tei:q[1]//tei:pc)[last()]/@xml:id = ./@xml:id and count($textb)">
        <xsl:variable name="q1" select="(ancestor::tei:q[1]//tei:w)[1]/@xml:id" />
        <xsl:choose>
        <xsl:when test="$textb[contains(@target,$q1)]"> 
          <xsl:call-template name="closeQuote"/>
          <img src="fdt-textb-r.png" class="imgTextX" alt="{$textbDesc}" title="{$textbDesc}"/>
        </xsl:when>
        <xsl:otherwise>
          <img src="fdt-textb-r.png" class="imgTextX" alt="{$textbDesc}" title="{$textbDesc}"/>
          <xsl:call-template name="closeQuote"/>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="closeQuote"/>
        <xsl:if test="count($emend)"> 
          <img src="fdt-emend-r.png" class="imgEmend" alt="{$emendDesc}" title="{$emendDesc}"/>
        </xsl:if>
        <xsl:if test="count($texta)"> 
          <img src="fdt-texta-r.png" class="imgTextX" alt="{$textaDesc}" title="{$textaDesc}"/>
        </xsl:if>
        <xsl:if test="count($textb)"> 
          <img src="fdt-textb-r.png" class="imgTextX" alt="{$textbDesc}" title="{$textbDesc}"/>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:c">
    <xsl:variable name="class" select="translate(@rend,',',' ')" />
    <xsl:choose>
    <xsl:when test="key('altRdg',@xml:id)">
      <xsl:variable name="xmlId" select="@xml:id"/>
      <xsl:choose>
      <xsl:when test="//tei:app[contains(@from,$xmlId)]/tei:rdg[contains(@wit,$rdg)]">
        <xsl:apply-templates select="//tei:app[contains(@from,$xmlId)]/tei:rdg[contains(@wit,$rdg)]"/>
      </xsl:when>
      <xsl:otherwise>
      <span title="{./@n}" class="{$class}"><xsl:value-of select="translate(.,' ','&#160;')"/></span>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <span title="{./@n}" class="{$class}"><xsl:value-of select="translate(.,' ','&#160;')"/></span>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="openQuote">
      <xsl:if test="(ancestor::tei:q[1]//tei:w|ancestor::tei:q[1]//tei:pc)[1]/@xml:id = ./@xml:id and (not(ancestor::tei:q[2]) or (ancestor::tei:q[2]//tei:w|ancestor::tei:q[2]//tei:pc)[1]/@xml:id = ./@xml:id)">
        <xsl:text>&#8220;</xsl:text>
      </xsl:if>
      <xsl:if test="(ancestor::tei:q[1]//tei:w|ancestor::tei:q[1]//tei:pc)[1]/@xml:id = ./@xml:id and ancestor::tei:q[2]">
        <xsl:text>&#8216;</xsl:text>
      </xsl:if>
  </xsl:template>

  <xsl:template name="closeQuote">
      <xsl:if test="(ancestor::tei:q[1]//tei:w|ancestor::tei:q[1]//tei:pc)[last()]/@xml:id = ./@xml:id and ancestor::tei:q[2]">
        <xsl:text>&#8217;</xsl:text>
      </xsl:if>
      <xsl:if test="(ancestor::tei:q[1]//tei:w|ancestor::tei:q[1]//tei:pc)[last()]/@xml:id = ./@xml:id and (not(ancestor::tei:q[2]) or (ancestor::tei:q[2]//tei:w|ancestor::tei:q[2]//tei:pc)[last()]/@xml:id = ./@xml:id)">
        <xsl:text>&#8221;</xsl:text>
      </xsl:if>
  </xsl:template>

  <xsl:template name="showFTLN">
    <xsl:variable name="ftln" select="substring-after(@xml:id,'ftln-')"/>
    <a class="hidden" name="{@xml:id}">FTLN</a>
    <a class="hidden" name="line-{@n}">LINE</a>
    <span class="ftln" name="ftln_{$ftln}">FTLN <xsl:value-of select="substring-after(@xml:id,'ftln-')"/></span>
    <xsl:choose>
    <xsl:when test="number(substring-after(substring-after(@n,'.'),'.'))">
    <xsl:variable name="lineNbr" select="number(substring-after(substring-after(@n,'.'),'.'))"/>
    <xsl:if test="($lineNbr mod 5) = 0">
      <span class="lineNbr" name="line_{@n}">
      <xsl:value-of select="$lineNbr"/>
      </span>
    </xsl:if>
    </xsl:when>
    <xsl:when test="number(substring-after(@n,'.'))">
    <xsl:variable name="lineNbr" select="number(substring-after(@n,'.'))"/>
    <xsl:if test="($lineNbr mod 5) = 0">
      <span class="lineNbr" name="line_{@n}">
      <xsl:value-of select="$lineNbr"/>
      </span>
    </xsl:if>
    </xsl:when>
    <xsl:when test="contains(@n,'gap')">
    </xsl:when>
    <xsl:otherwise>
      <a name="line-{@n}">No line</a>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="showRdg">
    <xsl:choose>
    <xsl:when test="key('altRdg',@xml:id)">
      <xsl:variable name="xmlId" select="@xml:id"/>
      <xsl:choose>
      <xsl:when test="//tei:app[contains(@from,$xmlId)]/tei:rdg[contains(@wit,$rdg)]">
        <xsl:apply-templates select="//tei:app[contains(@from,$xmlId)]/tei:rdg[contains(@wit,$rdg)]"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:stage">
    <xsl:variable name="lineNbr" select="(substring-after(@n,'SD '))"/>
    <a class="hidden" name="line-SD{$lineNbr}">SD</a>
    <xsl:variable name="class" select="translate(@rend,',',' ')" />
    <xsl:choose>
      <xsl:when test="starts-with(./*/text(),',')">
      <span class="stage inline {$class}"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:otherwise>
      <span class="stage right {$class}"><xsl:apply-templates/></span>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="tei:stage[@type='entrance']">
     <xsl:variable name="lineNbr" select="(substring-after(@n,'SD '))"/>
     <a class="hidden" name="line-SD{$lineNbr}">SD</a>
     <xsl:variable name="class" select="translate(@rend,',',' ')" />
     <span class="stage centered {$class}"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:stage[contains('delivery,location,modifier',@type)]">
     <xsl:variable name="lineNbr" select="(substring-after(@n,'SD '))"/>
     <a class="hidden" name="line-SD{$lineNbr}">SD</a>
     <xsl:variable name="class" select="translate(@rend,',',' ')" />
     <span class="stage {$class}"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:stage[@type='dumbshow']">
     <xsl:variable name="lineNbr" select="(substring-after(@n,'SD '))"/>
     <a class="hidden" name="line-SD{$lineNbr}">SD</a>
     <xsl:variable name="class" select="translate(@rend,',',' ')" />
     <span class="stage {$class}"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:stage[contains(@rend,'inline')]">
     <xsl:variable name="lineNbr" select="(substring-after(@n,'SD '))"/>
     <a class="hidden" name="line-SD{$lineNbr}">SD</a>
     <xsl:variable name="class" select="translate(@rend,',',' ')" />
     <span class="stage {$class}"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:stage[contains(@rend,'indent')]">
     <xsl:variable name="lineNbr" select="(substring-after(@n,'SD '))"/>
     <a class="hidden" name="line-SD{$lineNbr}">SD</a>
     <xsl:variable name="class" select="translate(@rend,',',' ')" />
     <span class="stage {$class}"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:stage[contains(@rend,'centered')]">
     <xsl:variable name="lineNbr" select="(substring-after(@n,'SD '))"/>
     <a class="hidden" name="line-SD{$lineNbr}">SD</a>
     <xsl:variable name="class" select="translate(@rend,',',' ')" />
     <span class="stage centered {$class}"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:stage[@type='mixed']">
    <xsl:variable name="lineNbr" select="(substring-after(@n,'SD '))"/>
    <a class="hidden" name="line-SD{$lineNbr}">SD</a>
    <xsl:variable name="class" select="translate(@rend,',',' ')" />
    <xsl:choose>
    <xsl:when test="descendant::tei:stage[@type='entrance']">
      <span class="stage centered {$class}"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="@rend='inline'">
      <span class="stage"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="@rend='centered'">
      <span class="stage centered"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="starts-with(./*/text(),',')">
      <span class="stage {$class}"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="descendant::tei:stage[@type='business']">
      <span class="stage right {$class}"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="descendant::tei:stage[@type='exit']">
      <span class="stage right {$class}"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:otherwise>
      <span class="stage {$class}"><xsl:apply-templates/></span>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:stage//tei:stage">
    <xsl:variable name="class" select="translate(@rend,',',' ')" />
    <span class="stage {$class}"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:stage[@rend='inline']//tei:lb">
    <br/><span class="alignment indentProse">&#160;</span>
  </xsl:template>
  <xsl:template match="tei:stage[@type='delivery']//tei:lb">
    <br/><span class="alignment indentProse">&#160;</span>
  </xsl:template>
  <xsl:template match="tei:sp/tei:stage//tei:lb">
    <br/><span class="alignment indentProse">&#160;</span>
  </xsl:template>


  <xsl:template match="tei:seg[@type][contains('song,verse,letter',@type)]">
    <xsl:variable name="class" select="translate(@rend,',',' ')" />
    <span id="{@xml:id}" class="italic {$class}"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:seg[@type='poem']">
    <xsl:variable name="class" select="translate(@rend,',',' ')" />
    <span id="{@xml:id}" class="{$class}"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:seg[@type='letter'][@subtype='closing']">
    <xsl:variable name="class" select="translate(@rend,',',' ')" />
    <span class="closing {$class}"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:seg[@type='letter'][@subtype='signature']">
    <xsl:variable name="class" select="translate(@rend,',',' ')" />
    <span class="right {$class}"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:seg[@type='letter'][@subtype='closing']/tei:seg[@type='letter'][@subtype='signature']">
    <xsl:variable name="class" select="translate(@rend,',',' ')" />
    <span class="closingSig {$class}"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:seg[@type='dramatic']">
    <span class="italic"><xsl:apply-templates/></span>
  </xsl:template>


  <xsl:template match="tei:ab[not(@type)][@rend]">
     <xsl:variable name="class" select="translate(@rend,',',' ')" />
     <span class="{$class}"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:hi">
     <xsl:variable name="class" select="translate(@rend,',',' ')" />
     <span class="{$class}"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:foreign">
     <xsl:variable name="class" select="translate(@rend,',',' ')" />
     <span class="italic {$class}"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:body//tei:persName">
     <span class="speakerName"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:name">
     <span class="italic"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:title[@rend='italic']">
     <span class="italic"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:title[@rend='quotes']">
     <xsl:text>&#8220;</xsl:text><xsl:apply-templates/><xsl:text>&#8221;</xsl:text>
  </xsl:template>

  <xsl:template match="tei:gap">
     <xsl:text>&#8230;</xsl:text>
  </xsl:template>

  <xsl:template match="tei:w//tei:q">
     <xsl:text>&#8220;</xsl:text><xsl:apply-templates/><xsl:text>&#8221;</xsl:text>
  </xsl:template>

  <xsl:template match="tei:milestone[@unit='line'][@type='stanza']">
    <xsl:choose>
    <xsl:when test="@edRef and not(contains(@edRef,$rdg))">
    </xsl:when>
    <xsl:when test="@ana='#quatrain' and (@n='2' or @n='4')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#AAb' and (@n='1' or @n='2')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aaB' and (@n='3')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aBb' and (@n='2')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#AAbCCb' and (@n='1' or @n='2' or @n='4' or @n='5')">
      <span class="alignment" style="padding-left:25px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#AAbCCb' and (@n='3' or @n='6')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aA' and (@n='2')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aBcB' and (@n='2' or @n='4')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#AAbC' and (@n='1' or @n='2' or @n='4')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aBaBA' and (@n='2' or @n='4')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aBaBA' and (@n='5')">
      <span class="alignment" style="padding-left:25px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aBaBB' and (@n='2' or @n='4' or @n='5')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#AAbbA' and (@n='1' or @n='2' or @n='5')">
      <span class="alignment" style="padding-left:25px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aaBBa' and (@n='3' or @n='4')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aaBBc' and (@n='3' or @n='4')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#abCCb' and (@n='3' or @n='4')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aBcBD' and (@n='2' or @n='4')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aBcBD' and @n='5'">
      <span class="alignment" style="padding-left:30px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aBcBdB' and (@n='2' or @n='4' or @n='6')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aaBBaa' and (@n='3' or @n='4')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aBaBcc' and (@n='2' or @n='4')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aaBaaB' and (@n='3' or @n='6')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aaBccB' and (@n='3' or @n='6')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aBaBcC' and (@n='2' or @n='4' or @n='6')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aBBaCC' and (@n='2' or @n='3' or @n='5' or @n='6')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aBBCCa' and (@n='2' or @n='3' or @n='4' or @n='5')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aBaBccB' and (@n='2' or @n='4')">
      <span class="alignment" style="padding-left:30px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aBaBccB' and (@n='3' or @n='7')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#AAaBBaa' and (@n='1' or @n='2' or @n='4' or @n='5')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#AABBcDDc' and (@n='1' or @n='2' or @n='3' or @n='4')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#AABBcDDc' and (@n='6' or @n='7')">
      <span class="alignment" style="padding-left:25px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#AABCCBddDD' and (@n='1' or @n='2' or @n='4' or @n='5')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#AABCCBddDD' and (@n='3' or @n='6' or @n='9' or @n='10')">
      <span class="alignment" style="padding-left:25px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aabbCCDEED' and (@n='5' or @n='6' or @n='8' or @n='9')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aabbCCDEED' and (@n='7' or @n='10')">
      <span class="alignment" style="padding-left:20px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#AABBbCCDDb' and (not(@n='5' or @n='10'))">
      <span class="alignment" style="padding-left:20px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#AAbCCbDDEE' and (@n='1' or @n='2' or @n='4' or @n='5' or @n='7' or @n='8' or @n='9' or @n='10')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aaaBcccB' and (@n='4' or @n='8')">
      <span class="alignment" style="padding-left:20px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aBaBcBdBB' and (@n='2' or @n='4' or @n='6' or @n='8')">
      <span class="alignment" style="padding-left:10px;">&#160;</span>
    </xsl:when>
    <xsl:when test="@ana='#aBaBcBdBB' and @n='9'">
      <span class="alignment" style="padding-left:25px;">&#160;</span>
    </xsl:when>
    <xsl:otherwise>
    </xsl:otherwise>
  </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:milestone[@type='stanza'][key('altRdg',@xml:id)]">
    <xsl:choose>
    <xsl:when test="$rdg = 'lemma'">
      <xsl:apply-templates/>
    </xsl:when>
    <xsl:when test="key('altRdg',@xml:id)">
      <xsl:variable name="xmlId" select="@xml:id"/>
      <xsl:apply-templates select="//tei:app[contains(@from,$xmlId)]/tei:rdg[contains(@wit,$rdg)]"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:ab|tei:p">
      <span class="indentInline">&#160;</span>
      <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="tei:particDesc//tei:p">
      <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="tei:ab|tei:p">
      <span class="indentInline">&#160;</span>
      <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:milestone[@unit='ftln']">
    <xsl:choose>
    <xsl:when test="not(@edRef) or contains(@edRef,$rdg)">
      <xsl:call-template name="processFTLN"/>
    </xsl:when>
    <xsl:otherwise>
    </xsl:otherwise>
  </xsl:choose>
  </xsl:template>

  <xsl:template name="processFTLN">
    <xsl:call-template name="showFTLN"/>

    <xsl:if test="ancestor::tei:seg[@type][contains('song,poem',@type)] and not(contains(ancestor::tei:seg[1]/@rend,'inline')) and not(contains(ancestor::tei:seg[1]/@rend,'indentAs'))">
      <span id="seg{@xml:id}" class="alignment" style="padding-left:10px;">&#160;</span>
      <xsl:if test="ancestor::tei:seg[@type][contains('song,poem',@type)][not(@prev)]">
        <script>alignSegsCmd += "alignSegs('seg<xsl:value-of select="@xml:id"/>','seg<xsl:value-of select="(ancestor::tei:seg[1]//tei:milestone[@unit='ftln'][not(@edRef) or contains(@edRef,$rdg)])[1]/@xml:id"/>','<xsl:value-of select="ancestor::tei:seg[1]/@xml:id"/>');";</script>
      </xsl:if>
      <xsl:if test="ancestor::tei:seg[@type][contains('song,poem',@type)][@prev]">
        <script>alignSegsCmd += "alignSegs('seg<xsl:value-of select="@xml:id"/>','seg<xsl:value-of select="(preceding::tei:seg[not(@prev)][1]//tei:milestone[@unit='ftln'][not(@edRef) or contains(@edRef,$rdg)])[1]/@xml:id"/>','');";</script>
      </xsl:if>
    </xsl:if>

     <xsl:choose>
       <xsl:when test="ancestor::tei:stage[@type='dumbshow']">
       </xsl:when>
       <xsl:when test="contains(@rend,'inline')">
       </xsl:when>
       <xsl:when test="contains(@rend,'align')">
         <span id="c{@xml:id}" class="alignment indentSplit">&#160;</span>
         <xsl:variable name="prevId" select="substring(@prev,2)" />
         <xsl:variable name="prevTarget" select="substring-before(substring-after(@rend,'align{'),'}')"/>
         <xsl:variable name="lastId" select="substring-before(substring-after(@rend,'align{'),'}')"/>
         <script>alignSplitLinesCmd += "alignSplitLines('<xsl:value-of select="concat('c',@xml:id)"/>','<xsl:value-of select="$lastId"/>','B');";</script>
       </xsl:when>
       <xsl:when test="not(@prev) and not((preceding::tei:lb[1]/following::tei:w[1]) = following::tei:w[1])">
       </xsl:when>
       <xsl:when test="@ana='#prose'">
         <span class="alignment indentProse">&#160;</span>
       </xsl:when>
       <xsl:when test="@ana='#short'">
         <xsl:if test="not(ancestor::tei:seg[@type][contains('song,poem',@type)])">
         <span class="alignment indentVerse">&#160;</span>
         </xsl:if>
       </xsl:when>
       <xsl:when test="@prev">
           <xsl:choose>
             <xsl:when test="count(. | (ancestor::tei:ab[1]//tei:milestone[@unit='ftln'][not(@edRef) or contains(@edRef,$rdg)])[1]) = 1">
               <!-- first line in speech, align -->
               <xsl:call-template name="alignSplitLines"/>
             </xsl:when>
             <xsl:when test="ancestor::tei:seg and not(preceding-sibling::tei:lb[not(@edRef) or contains(@edRef,$rdg)])">
               <!-- first line in song/poem, align -->
               <xsl:call-template name="alignSplitLines"/>
             </xsl:when>
             <xsl:when test="preceding-sibling::tei:*[1]/tei:lb">
               <!-- following SD fragment, inline -->
             </xsl:when>
             <xsl:when test="preceding::tei:w[1]/@xml:id = preceding::tei:stage[not(@type='delivery')][1]//tei:w[last()]/@xml:id">
               <!-- following SD, align -->
               <xsl:call-template name="alignSplitLines"/>
             </xsl:when>
             <xsl:when test="name(preceding-sibling::tei:*[1])='stage' and name(preceding-sibling::tei:*[2])='lb'">
               <!-- following SD, align -->
               <xsl:call-template name="alignSplitLines"/>
             </xsl:when>
             <xsl:otherwise>
               <span class="alignment indentRunOn">&#160;</span>
             </xsl:otherwise>
           </xsl:choose>
       </xsl:when>
       <xsl:when test="ancestor::tei:seg[@type][contains('song,poem',@type)] and not(contains(ancestor::tei:seg[1]/@rend,'indentAs'))">
       </xsl:when>
       <xsl:when test="@ana='#verse'">
         <span class="alignment indentVerse">&#160;</span>
       </xsl:when>
       <xsl:otherwise>
       </xsl:otherwise>
     </xsl:choose>
     <xsl:if test="contains(@rend,'indent')">
       <span class="alignment indent">&#160;</span>
     </xsl:if>
  </xsl:template>

  <xsl:template name="alignSplitLines">
    <span id="c{@xml:id}" class="alignment indentSplit">&#160;</span>
    <xsl:variable name="prevId" select="substring(@prev,2)" />
    <xsl:variable name="prevTarget" select="//tei:milestone[@unit='ftln'][not(@edRef) or contains(@edRef,$rdg)][@xml:id=$prevId]/@corresp"/>
    <xsl:variable name="lastId" select="substring($prevTarget,string-length($prevTarget)-7)"/>
    <script>alignSplitLinesCmd += "alignSplitLines('<xsl:value-of select="concat('c',@xml:id)"/>','<xsl:value-of select="$lastId"/>','E');";</script>
  </xsl:template>

</xsl:stylesheet>
