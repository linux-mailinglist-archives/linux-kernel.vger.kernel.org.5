Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E78779590
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbjHKRDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbjHKRDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:03:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34857421D;
        Fri, 11 Aug 2023 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=WHhV63f1r6eBSTn3NN5qCOu05YzqXap1fhKKqK/JDlg=; b=j9lZIit4MdGMX3PTOkeGs2CJOy
        DIa78UPva+Gl81fv1o8svdPXlgs/LsHJAnPaLKTyX1wliSvp8gZdpC37t8/5sSxFRDq1DTNlyA3wQ
        /tG+TnTC9kp4IRg/MNHHMM0wnX45RfCmriS+FHfFaqxWrsoyACbZSNO52J4elEnY+YUFJ+GW5p32E
        6JIPISjzZ3DIA5E9Vxq+MKL2ww19oIg0dfiAS2DIyGNB9FqlnSvX0mTq5C2h1f7G5PIHIVg8opYpX
        5So7U0L0SVN6ZCuLuLYA3xrSZgDY7Epr1WP9ToN6XHtjjMYyREuCxJB2M+d5L0rZR1/oY+Q/rprKx
        AlPdnCaw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUVX1-00BBaH-27;
        Fri, 11 Aug 2023 17:02:35 +0000
Message-ID: <273efa43-f87a-1787-3017-e2dbea2e1176@infradead.org>
Date:   Fri, 11 Aug 2023 10:02:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] docs: sparse: convert TW sparse.txt into sparse.rst
Content-Language: en-US
To:     Min-Hua Chen <minhuadotchen@gmail.com>,
        Hu Haowen <src.res@email.cn>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230811153554.84571-1-minhuadotchen@gmail.com>
 <20230811153554.84571-3-minhuadotchen@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230811153554.84571-3-minhuadotchen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/23 08:35, Min-Hua Chen wrote:
> Follow Randy's advice [1] to move
> Documentation/translations/zh_TW/dev-tools/sparse.txt
> to
> Documentation/translations/zh_TW/dev-tools/sparse.rst
> 
> [1] https://lore.kernel.org/lkml/bfab7c5b-e4d3-d8d9-afab-f43c0cdf26cf@infradead.org/
> 
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  .../dev-tools/{sparse.txt => sparse.rst}      | 31 ++++++-------------
>  1 file changed, 10 insertions(+), 21 deletions(-)
>  rename Documentation/translations/zh_TW/dev-tools/{sparse.txt => sparse.rst} (71%)
> 
> diff --git a/Documentation/translations/zh_TW/dev-tools/sparse.txt b/Documentation/translations/zh_TW/dev-tools/sparse.rst
> similarity index 71%
> rename from Documentation/translations/zh_TW/dev-tools/sparse.txt
> rename to Documentation/translations/zh_TW/dev-tools/sparse.rst
> index 6d2d088b1060..2f632f6ce8e8 100644
> --- a/Documentation/translations/zh_TW/dev-tools/sparse.txt
> +++ b/Documentation/translations/zh_TW/dev-tools/sparse.rst
> @@ -1,33 +1,22 @@
> -﻿Chinese translated version of Documentation/dev-tools/sparse.rst
> -
> -If you have any comment or update to the content, please contact the
> -original document maintainer directly.  However, if you have a problem
> -communicating in English you can also ask the Chinese maintainer for
> -help.  Contact the Chinese maintainer if this translation is outdated
> -or if there is a problem with the translation.
> +﻿Copyright 2004 Linus Torvalds
> +Copyright 2004 Pavel Machek <pavel@ucw.cz>
> +Copyright 2006 Bob Copeland <me@bobcopeland.com>
>  
> -Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
> ----------------------------------------------------------------------
> -Documentation/dev-tools/sparse.rst 的繁體中文翻譯
> +.. include:: ../disclaimer-zh_TW.rst
>  
> -如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
> -交流有困難的話，也可以向繁體中文版維護者求助。如果本翻譯更新不及時或
> -者翻譯存在問題，請聯繫繁體中文版維護者。
> +:Original: Documentation/dev-tools/sparse.rst
>  
> -繁體中文版維護者： 胡皓文 Hu Haowen <src.res@email.cn>
> -繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res@email.cn>
> +:翻譯:
>  
> -以下爲正文
> ----------------------------------------------------------------------
> +Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
>  
> -Copyright 2004 Linus Torvalds
> -Copyright 2004 Pavel Machek <pavel@ucw.cz>
> -Copyright 2006 Bob Copeland <me@bobcopeland.com>
> +Sparse
> +======
>  
>  使用 sparse 工具做類型檢查
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -"__bitwise" 是一種類型屬性，所以你應該這樣使用它：
> +"__bitwise" 是一種類型屬性，所以你應該這樣使用它::
>  
>          typedef int __bitwise pm_request_t;
>  

-- 
~Randy
