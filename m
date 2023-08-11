Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1B8779884
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjHKUZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHKUZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:25:01 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B9B122;
        Fri, 11 Aug 2023 13:24:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 714404A2;
        Fri, 11 Aug 2023 20:24:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 714404A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1691785498; bh=FwF0uljvkKJCBCLoEkCrG6pzxVdADa9QKxGpNMSjuio=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IjMdtKQM/ptQU/ou7hJK5USvA5OxVOZkczpIZYf6IQCLFvrYjBUAybnb7wQ1Tm+Jp
         cgFkPEbOxqNhIynwOKbzVL/SK4x+xlpNqdecMyE4Unye6G4Ym6RjJwvfpwNlosfLJe
         JLbsQ8u4+iMY+EOAb1pwGbZUt0RuGlk3pTr3y76OmTcJoxkvbT8WZCOWC7ElqmWFZS
         zZOaAoHjbBvTtegJWqbfBoSe1P/TX3bRVlBEV7/h33IGDJBxeRuwg7KRmOYIFxA2I6
         mp4I5DoVePm9QruXzjrFutS3kcTm9fF/rcGjdmfByCL2zx9XUn+wNDn+Re7nqwEIuv
         WIr0ck2Fw/BwQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res.211@gmail.com>
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] docs/zh_TW: update zh_TW's documentation from an
 ascensive aspect
In-Reply-To: <20230807120006.6361-1-src.res.211@gmail.com>
References: <20230807120006.6361-1-src.res.211@gmail.com>
Date:   Fri, 11 Aug 2023 14:24:57 -0600
Message-ID: <87ttt5xr6u.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <src.res.211@gmail.com> writes:

> Update zh_TW's documentation concentrating on the following aspects:
>
>     * The file tree structure changes of the main documentation;
>     * Some changes and ideas from zh_CN translation;
>     * Removal for several obsoleted contents within the zh_TW translation
>       or those which are not exising anymore in the main documentation.
>     * Replacements for some incorrect words and phrases in traditional
>       Chinese or those which are odd within their context being hard for
>       readers to comprehend.
>
> v3:
>     * Remove the fancy character thoroughly asked by Corbet.
>
> v2:
>     * Remove the fancy character U+feff (ZERO WIDTH NO-BREAK SPACE) reported by Corbet
>       in https://lore.kernel.org/lkml/87bkg5dp6x.fsf@meer.lwn.net/.
>
> v1:
>     https://lore.kernel.org/lkml/20230720132729.1821-1-src.res.211@gmail.com/
>

So this series does not even come close to applying to docs-next; it
includes things like the email-address change that you sent me a month
ago.  What are you generating it against?

Please.  We have been through a few too many rounds of this at this
point.  If you can send me something I can apply against my tree, I'll
look at it, but *make sure* it's a reasonable patch series before you
send it again.

jon
