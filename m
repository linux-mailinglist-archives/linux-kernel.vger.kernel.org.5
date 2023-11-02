Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F99E7DF747
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376797AbjKBQDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKBQDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:03:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF82ADE;
        Thu,  2 Nov 2023 09:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=02qHHvSAVKAlvWyAGXqUxB25mBwzXZUYPTTdwOR+o8g=; b=lE4dUvpa5KIKHMANOyoS+E6XAc
        ENB+Yj2EGr03poUkKQO55uE68fwQUZilw1ghst9wP+K3UEOTJFxWaT4RB9CgLS+x/cSadrF9yFOYQ
        dTrNUOuCAPp1B4TbXWzvtkQ+LGOiVSfEU+srJNg4lRm30PfNeVfUBeBDJTjXZHmTOSl0EM0lbuuqb
        2uBjp0nJ/S0VAJuxkzLgNqU0LQywd1rdykcdgCIGmSmspCrlTCWxoDFIZCj/FddnTXnPC/4O8vY3g
        8Vt4tEIYnoaU9plP8lA+ik59qyol1OIaFuKamodTxTnPZP/oG1xZy168cxmjIZ42sCPWIk3eaudu4
        yMUo2htQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qya9p-009pNi-23;
        Thu, 02 Nov 2023 16:02:57 +0000
Message-ID: <3eee0b30-2e35-45f9-88e0-bafe23a79557@infradead.org>
Date:   Thu, 2 Nov 2023 09:02:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC RESEND 2/4] Docmentation: Use IBM Plex Sans for page
 body
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Vernet <void@manifault.com>,
        Miguel Ojeda <ojeda@kernel.org>, James Seo <james@equiv.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Carlos Bilbao <carlos.bilbao@amd.com>
References: <20231102123225.32768-1-bagasdotme@gmail.com>
 <20231102123225.32768-3-bagasdotme@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231102123225.32768-3-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/23 05:32, Bagas Sanjaya wrote:
> Adapted from "About the font" page on Google Fonts [1]:
> 
> ```
> Plex is an international typeface family developed by IBM, aimed to
> illustrate unique relationship between mankind and machine. The font
> is neutral, yet friendly Grosteque-style typeface that balances
> design with the engineered details. The font has excellent legibility
> in print, web, and mobile interfaces.
> ```
> 
> Use IBM Plex Sans font for both documentation content (excluding
> title and section headings) and sidebar.
> 

docs.kernel.org currently shows me content in a serif font, which I find
preferable for content body.

Does this force everyone to use a sans serif font for content body?
If so, I would not like that.

(reminds me of reading The Psychology of Computer Programming, which was
completely in sans serif, which made it difficult to read IMO)

> [1]: https://fonts.google.com/specimen/IBM+Plex+Sans/about
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/conf.py                         |   4 ++
>  .../sphinx-static/IBMPlexSans-Bold.woff2      | Bin 0 -> 55412 bytes
>  .../IBMPlexSans-BoldItalic.woff2              | Bin 0 -> 59112 bytes
>  .../sphinx-static/IBMPlexSans-Italic.woff2    | Bin 0 -> 59468 bytes
>  .../sphinx-static/IBMPlexSans-Regular.woff2   | Bin 0 -> 55380 bytes
>  Documentation/sphinx-static/fonts.css         |  68 ++++++++++++++++++
>  6 files changed, 72 insertions(+)
>  create mode 100644 Documentation/sphinx-static/IBMPlexSans-Bold.woff2
>  create mode 100644 Documentation/sphinx-static/IBMPlexSans-BoldItalic.woff2
>  create mode 100644 Documentation/sphinx-static/IBMPlexSans-Italic.woff2
>  create mode 100644 Documentation/sphinx-static/IBMPlexSans-Regular.woff2
>  create mode 100644 Documentation/sphinx-static/fonts.css
> 

[snip]

Thanks.
-- 
~Randy
