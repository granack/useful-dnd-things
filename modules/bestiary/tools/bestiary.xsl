<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY mdash "&#8212;">
]>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:str="http://exslt.org/strings" extension-element-prefixes="str">

    <xsl:variable name='lowers' select='"abcdefghijklmnopqrstuvwxyz"' />
    <xsl:variable name='uppers' select='"ABCDEFGHIJKLMNOPQRSTUVWXYZ"' />

    <xsl:output method="html"/>

    <xsl:template match="/">
    <xsl:for-each select="bestiary/monster">
        <xsl:sort select="alt_sort"/>

        <!-- Get Variables -->

        <!-- name options: from file, all lower case, and Proper Case -->
        <xsl:variable name="monster_name" select="name" />
        <xsl:variable name="name_proper">
            <xsl:for-each select='str:split($monster_name, " ")'>
                <xsl:value-of select='concat(translate(substring(., 1, 1), $lowers, $uppers), translate(substring(., 2), $uppers, $lowers)," ")' />
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="name_lower" select='concat(translate($monster_name, $uppers, $lowers)," ")' />

        <!-- these are the 'extras' -->
        <xsl:variable name="alt_sort" select="alt_sort" />
        <xsl:variable name="environment" select="environment" />
        <xsl:variable name="short_desc" select="short_desc" />
        <xsl:variable name="long_desc" select="long_desc" />
        <xsl:variable name="sources" select="sources" />
        <xsl:variable name="unique" select="unique" />

        <!-- size, type, alignment -->
        <xsl:variable name="size_letter" select="size" />
        <xsl:variable name="size">
          <xsl:choose>
            <xsl:when test="$size_letter = 'T'">
              <xsl:text>Tiny </xsl:text>
            </xsl:when>
            <xsl:when test="$size_letter = 'S'">
              <xsl:text>Small </xsl:text>
            </xsl:when>
            <xsl:when test="$size_letter = 'M'">
              <xsl:text>Medium </xsl:text>
            </xsl:when>
            <xsl:when test="$size_letter = 'L'">
              <xsl:text>Large </xsl:text>
            </xsl:when>
            <xsl:when test="$size_letter = 'H'">
              <xsl:text>Huge </xsl:text>
            </xsl:when>
            <xsl:when test="$size_letter = 'G'">
              <xsl:text>Gargantuan </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>***Invalid size*** </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="type" select="type" />
        <xsl:variable name="alignment" select="alignment"/>

        <!-- top stats -->
        <xsl:variable name="ac_field" select="ac" />
        <xsl:variable name="ac">
            <xsl:choose>
                <xsl:when test="contains($ac_field,'(')">
                    <xsl:value-of select="substring-before($ac_field,'(')" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$ac_field" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="ac_note">
          <xsl:choose>
            <xsl:when test="contains($ac_field,'(')">
               <xsl:value-of select="substring-after(substring($ac_field,1,string-length($ac_field)-1),'(')" />
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="hp" select="substring-before(hp,'(')" />
        <xsl:variable name="hit_dice" select="substring-after(substring(hp,1,string-length(hp)-1),'(')" />
        <xsl:variable name="speed" select="speed"/>

        <!-- abilities -->
        <xsl:variable name="str" select="str" />
        <xsl:variable name="dex" select="dex" />
        <xsl:variable name="con" select="con" />
        <xsl:variable name="int" select="int" />
        <xsl:variable name="wis" select="wis" />
        <xsl:variable name="cha" select="cha" />

        <!-- calculate ability modifiers -->
        <xsl:variable name="strmod" select="format-number(floor((number($str)-10) div 2), '+0;-0')" />
        <xsl:variable name="dexmod" select="format-number(floor((number($dex)-10) div 2), '+0;-0')" />
        <xsl:variable name="conmod" select="format-number(floor((number($con)-10) div 2), '+0;-0')" />
        <xsl:variable name="intmod" select="format-number(floor((number($int)-10) div 2), '+0;-0')" />
        <xsl:variable name="wismod" select="format-number(floor((number($wis)-10) div 2), '+0;-0')" />
        <xsl:variable name="chamod" select="format-number(floor((number($cha)-10) div 2), '+0;-0')" />

        <!-- more things -->
        <xsl:variable name="save" select="save" />
        <xsl:variable name="skill" select="skill" />
        <xsl:variable name="resist" select="resist" />
        <xsl:variable name="vulnerable" select="vulnerable" />
        <xsl:variable name="immune" select="immune" />
        <xsl:variable name="conditionImmune" select="conditionImmune" />
        <xsl:variable name="senses" select="senses" />
        <xsl:variable name="passive" select="passive" />
        <xsl:variable name="languages">
          <xsl:choose>
            <xsl:when test="languages = ''">&mdash;</xsl:when>
            <xsl:otherwise>
                <!-- not sure if this is needed for bestiary project -->
                <!--<xsl:for-each select='str:split(languages, " ")'>
                    <xsl:value-of select='str:replace(concat(translate(substring(., 1, 1), $lowers, $uppers), translate(substring(., 2), $uppers, $lowers)," "),str:tokenize("Ft.,Any,All",","),str:tokenize("ft.,any,all",","))' />
                </xsl:for-each>-->
                <xsl:value-of select="languages" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="cr" select="cr" />

    <!-- build the HTML fragment -->
    <div class="monster">
        <xsl:choose>
          <xsl:when test="$unique">
            <p class="unique"><xsl:value-of select="$name_proper" /> is a unique individual.</p>
          </xsl:when>
        </xsl:choose>
    <div class="stat-block">
        <hr class="orange-border" />
        <div class="creature-heading">
            <h1><xsl:value-of select="$monster_name" /> </h1>
            <h2><xsl:value-of select="$size" />  <xsl:value-of select="substring-before($type,',')"/>, <xsl:value-of select="$alignment" /></h2>
        </div>

        <!--tapered-rule -->
        <svg height="5" width="100%" class="tapered-rule">
            <polyline points="0,0 400,2.5 0,5"></polyline>
        </svg>

        <div class="top-stats">

        <!-- armor class -->
        <div class="property-line first">
            <h4>Armor Class</h4>
            <p><xsl:value-of select="$ac" /><xsl:if test="$ac_note != ''"> <xsl:text>(</xsl:text><xsl:value-of select="$ac_note"/><xsl:text>)</xsl:text>
        </xsl:if></p></div>

        <!-- hp -->
        <div class="property-line">
            <h4>Hit Points</h4>
            <p><xsl:value-of select="$hp" /> (<xsl:value-of select="$hit_dice" />)</p>
        </div> <!-- property line -->

        <!-- speed -->
        <div class="property-line">
            <h4>Speed</h4>
            <p><xsl:value-of select="$speed" /></p>
        </div>

        <!-- tapered-rule -->
        <svg height="5" width="100%" class="tapered-rule">
            <polyline points="0,0 400,2.5 0,5"></polyline>
        </svg>

        <!-- Abilities -->
        <div class="abilities">
            <div class="ability-strength">
                <h4>STR</h4>
                <p><xsl:value-of select="concat($str,' (',$strmod,')')"/></p>
            </div> <!-- ability strength -->
            <div class="ability-dexterity">
                <h4>DEX</h4>
                <p><xsl:value-of select="concat($dex,' (',$dexmod,')')"/></p>
            </div> <!-- ability dexterity -->
            <div class="ability-constitution">
                <h4>CON</h4>
                <p><xsl:value-of select="concat($con,' (',$conmod,')')"/></p>
            </div> <!-- ability constitution -->
            <div class="ability-intelligence">
                <h4>INT</h4>
                <p><xsl:value-of select="concat($int,' (',$intmod,')')"/></p>
            </div> <!-- ability intelligence -->
            <div class="ability-wisdom">
                <h4>WIS</h4>
                <p><xsl:value-of select="concat($wis,' (',$wismod,')')"/></p>
            </div> <!-- ability wisdom -->
            <div class="ability-charisma">
                <h4>CHA</h4>
                <p><xsl:value-of select="concat($cha,' (',$chamod,')')"/></p>
            </div> <!-- ability charisma -->
        </div> <!-- abilities -->

        <!-- tapered-rule -->
        <svg height="5" width="100%" class="tapered-rule">
            <polyline points="0,0 400,2.5 0,5"></polyline>
        </svg>

        <!-- save -->
        <xsl:choose>
            <xsl:when test="$save != ''">
                <div class="property-line">
                    <h4>Saving Throws</h4>
                    <p><xsl:value-of select="$save" /></p>
                </div>
            </xsl:when>
        </xsl:choose>

        <!-- skill -->
        <xsl:choose>
            <xsl:when test="$skill != ''">
                <div class="property-line">
                    <h4>Skills</h4>
                    <p><xsl:value-of select="$skill" /></p>
                </div>
            </xsl:when>
        </xsl:choose>

        <!-- resist -->
        <xsl:choose>
            <xsl:when test="$resist != ''">
                <div class="property-line">
                    <h4>Damage Resistances</h4>
                    <p><xsl:value-of select="$resist" /></p>
                </div>
            </xsl:when>
        </xsl:choose>

        <!-- vulnerable -->
        <xsl:choose>
          <xsl:when test="$vulnerable != ''">
                <div class="property-line">
                    <h4>Damage Vulnerabilities</h4>
                    <p><xsl:value-of select="$vulnerable" /></p>
                </div>
          </xsl:when>
        </xsl:choose>

        <!-- immune -->
        <xsl:choose>
          <xsl:when test="$immune != ''">
                <div class="property-line">
                    <h4>Damage Immunities</h4>
                    <p><xsl:value-of select="$immune" /></p>
                </div>
          </xsl:when>
        </xsl:choose>

        <!-- conditionImmune -->
        <xsl:choose>
          <xsl:when test="$conditionImmune != ''">
                <div class="property-line">
                    <h4>Condition Immunities</h4>
                    <p><xsl:value-of select="$conditionImmune" /></p>
                </div>
          </xsl:when>
        </xsl:choose>

        <!-- senses -->
        <div class="property-line">
            <h4>Senses</h4>
            <p><xsl:value-of select="$senses" /><xsl:choose><xsl:when test="$senses != ''">, </xsl:when></xsl:choose>passive Perception <xsl:value-of select="$passive"/></p>
        </div>

        <!-- languages -->
        <div class="property-line">
            <h4>Languages</h4>
            <p><xsl:value-of select="$languages" /></p>
        </div>

        <!-- cr -->
        <div class="property-line">
        <h4>Challenge Rating</h4>
        <p><xsl:value-of select="$cr" /> (

        <!-- XP -->
        <xsl:choose>
          <xsl:when test="$cr = '0'">
            <xsl:text>10</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '1/8'">
            <xsl:text>25</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '1/4'">
            <xsl:text>50</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '1/2'">
            <xsl:text>100</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '1'">
            <xsl:text>200</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '2'">
            <xsl:text>450</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '3'">
            <xsl:text>700</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '4'">
            <xsl:text>1100</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '5'">
            <xsl:text>1800</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '6'">
            <xsl:text>2300</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '7'">
            <xsl:text>2900</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '8'">
            <xsl:text>3900</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '9'">
            <xsl:text>5000</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '10'">
            <xsl:text>5900</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '11'">
            <xsl:text>7200</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '12'">
            <xsl:text>8400</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '13'">
            <xsl:text>10000</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '14'">
            <xsl:text>11500</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '15'">
            <xsl:text>13000</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '16'">
            <xsl:text>15000</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '17'">
            <xsl:text>18000</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '18'">
            <xsl:text>20000</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '19'">
            <xsl:text>22000</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '20'">
            <xsl:text>25000</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '21'">
            <xsl:text>33000</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '22'">
            <xsl:text>41000</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '23'">
            <xsl:text>50000</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '24'">
            <xsl:text>62000</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '25'">
            <xsl:text>75000</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '26'">
            <xsl:text>90000</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '27'">
            <xsl:text>105000</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '28'">
            <xsl:text>120000</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '29'">
            <xsl:text>135000</xsl:text>
          </xsl:when>
          <xsl:when test="$cr = '30'">
            <xsl:text>155000</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>0</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
            XP)</p>
        </div>

        <!-- tapered-rule -->
        <svg height="5" width="100%" class="tapered-rule">
            <polyline points="0,0 400,2.5 0,5"></polyline>
        </svg>

        </div> <!-- opt-stats -->

            <!-- trait -->
        <xsl:variable name="spell_list" select="spells" />
        <xsl:for-each select="trait">
            <div class="property-block">
                <h4><xsl:value-of select="name" /></h4>
                <xsl:for-each select="text">
                    <p>
                    <xsl:variable name="pattern" select="str:split($spell_list, ', ')" />
                    <xsl:variable name="replace" select="str:split(concat('&lt;i&gt;',str:replace($spell_list,', ','&lt;/i&gt;, &lt;i&gt;'),'&lt;/i&gt;'),', ')" />
                    <xsl:value-of select="str:replace(.,$pattern,$replace)" />
                    </p>
                </xsl:for-each>
            </div> <!-- property-block -->
        </xsl:for-each>

        <!-- Actions -->
        <xsl:if test="action">
            <div class="section-right">
                <div class="actions">
                    <h3>Actions</h3>
                    <xsl:for-each select="action">
                        <div class="property-block">
                            <h4><xsl:value-of select="name" /></h4>
                            <xsl:for-each select="text">
                                <p>
                                <xsl:variable name="text" select="." />
                                <xsl:variable name="text1" select="str:replace($text,'Hit:','&lt;i&gt;Hit:&lt;/i&gt;')" />
                                <xsl:variable name="text2" select="str:replace($text1,'Melee Weapon Attack:','&lt;i&gt;Melee Weapon Attack:&lt;/i&gt;')" />
                                <xsl:variable name="text3" select="str:replace($text2,'Ranged Weapon Attack:','&lt;i&gt;Ranged Weapon Attack:&lt;/i&gt;')" />
                                <xsl:value-of select="str:replace($text3,'Melee or &lt;i&gt;R','&lt;i&gt;Melee or R')" disable-output-escaping="yes"/>
                                </p>
                            </xsl:for-each>
                        </div> <!-- property-block -->
                    </xsl:for-each>
                </div> <!-- actions -->
            </div> <!-- section-right -->
        </xsl:if> <!-- actions section -->

        <!-- reaction -->
        <xsl:if test="reaction">
            <div class="section-right">
                <div class="actions">
                    <h3>Reactions</h3>
                    <xsl:for-each select="reaction">
                        <div class="property-block">
                            <h4><xsl:value-of select="name" /></h4>
                            <xsl:for-each select="text">
                                <p><xsl:value-of select="." /></p>
                            </xsl:for-each>
                        </div> <!-- property-block -->
                    </xsl:for-each>
                </div> <!-- (re)actions -->
            </div> <!-- section-right -->
        </xsl:if> <!-- reaction section -->

        <!-- legendary -->
        <xsl:if test="legendary">
            <div class="section-right">
                <div class="actions">
                    <h3>Legendary Actions</h3>
                    <div class="property-block">
                        <p>
                        <xsl:choose>
                            <xsl:when test="not($unique)">The <xsl:value-of select="$name_lower" /> can take 3 legendary actions, choosing from the options below. Only one legendary action option can be used at a time and only at the end of another creature's turn. The <xsl:value-of select="$name_lower" /> regains spent legendary actions at the start of its turn.</xsl:when>
                            <xsl:when test="$unique"><xsl:value-of select="$name_proper" /> can take 3 legendary actions, choosing from the options below. Only one legendary action option can be used at a time and only at the end of another creature's turn. <xsl:value-of select="$name_proper" /> regains spent legendary actions at the start of its turn.</xsl:when>
                        </xsl:choose>
                        </p>
                    </div>
                    <xsl:for-each select="legendary">
                        <div class="property-block">
                        <h4><xsl:value-of select="name" /></h4>
                        <xsl:for-each select="text">
                            <p><xsl:value-of select="." /></p>
                        </xsl:for-each>
                        </div> <!-- property-block -->
                    </xsl:for-each>
                </div> <!-- (legendary) actions -->
            </div> <!-- section-right -->
        </xsl:if> <!-- legendary actions -->


        </div> <!-- stat-block -->
        <p>Source(s):
        <xsl:choose>
            <xsl:when test="$sources"><xsl:value-of select="$sources" /></xsl:when>
            <xsl:when test="not($sources)">unknown, or maybe SRD</xsl:when>
        </xsl:choose>
        </p>
        </div> <!-- monster -->
    </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
