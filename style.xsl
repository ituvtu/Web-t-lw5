<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
    <html>
        <head>
            <style>
                body { font-family: Arial, sans-serif; background-color: #97d66d; }
                h1 {color: #008000;}
                header{text-align: center;  color#245230: #;font-size:32}
                h2 { color: #004d00; }
                .post, .comment { border: 1px solid #cccccc; margin: 10px 0; padding: 5px; background-color: #f9fff9; }
                .post { border-color: #aaffaa; }
                .comment { border-color: #ffffcc; margin-left: 20px; background-color:lemonchiffon}
                .reply { border: 1px solid #cccccc; margin: 5px; padding: 5px; background-color: #e9ffe9; } /* Стиль для відповідей */
                .author { color: #336600; }
                
                .timestamp { color: #666666; font-size: small; }
            </style>
        </head>
        <body>
            <header>Форум про Тварин</header>
            <xsl:apply-templates select="animalForum/categories/category"/>
        </body>
    </html>
</xsl:template>

<xsl:template match="category">
    <h2><xsl:value-of select="title"/></h2>
    <xsl:apply-templates select="threads/thread"/>
</xsl:template>

<xsl:template match="thread">
    <h3><xsl:value-of select="title"/></h3>
    <xsl:apply-templates select="posts/post"/>
</xsl:template>

<xsl:template match="post">
    <div class="post">
        <h2><p><xsl:value-of select="content"/></p></h2>
        <xsl:value-of select="author"/>
        <p><b>Тема:</b> <xsl:value-of select="topic"/></p>
        <p><b>Ключові слова: </b>
            <xsl:for-each select="keywords/keyword">
                <xsl:value-of select="."/>
                <xsl:if test="position() != last()">, </xsl:if>
            </xsl:for-each>
        </p>
        <p><i><xsl:value-of select="timestamp"/></i></p>
        <xsl:apply-templates select="comments/comment"/>
    </div>
</xsl:template>


<xsl:template match="comment">
    <div class="comment">
        <p><b>Коментар:</b> <xsl:value-of select="content"/></p>
        <p><span class="author">Автор: <xsl:value-of select="author"/></span>, <span class="timestamp"><xsl:value-of select="timestamp"/></span></p>
        <xsl:apply-templates select="comments/comment" mode="reply"/>
    </div>
</xsl:template>

<xsl:template match="comment" mode="reply">
    <div class="reply">
        <p><b>Відповідь:</b> <xsl:value-of select="content"/></p>
        <p><span class="author">Автор: <xsl:value-of select="author"/></span>, <span class="timestamp"><xsl:value-of select="timestamp"/></span></p>
        <xsl:apply-templates select="comments/comment" mode="reply"/>
    </div>
</xsl:template>
</xsl:stylesheet>