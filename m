Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBA675D52E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 21:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGUTo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 15:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjGUTo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 15:44:56 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6FE1BDC;
        Fri, 21 Jul 2023 12:44:55 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 04A117DB;
        Fri, 21 Jul 2023 19:44:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 04A117DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689968695; bh=971CWBr3Fgr6ABRXOzV+qBv4e2o0H63bbbT+0VqCisw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GqgQCfJftKdO86ZZhg4Kn/Ghu4LCRB9xw82LIlGfFF7e46dzAq93yEOC0JzLl5OeA
         xN5B6JuzcHzxLD/2Y23T5jV5U84qXktoebOokCbpwDdU6UHQ0DZnnab8d+pWEyO9IH
         /iK8N230ypinNqX+3xBK8yaWVMOLVOTdsC4GpTZN2uFn1oB5JvSNhKkFhKeDil8af2
         Pvvj4zIrygzscgFLSwx6rSkv0k8lzPyHJyAP5gwnseCwymdQHrZO64auRQqk3IF3+H
         u3V4Sm/jmlcSMC5Oegd46Ug/LrmeBFPbBQemFCNPmf4E8si2R3JzD+f8Rt4UJqmU0o
         TR19zSicU+Ltg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res.211@gmail.com>
Cc:     Hu Haowen <src.res.211@gmail.com>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/6] docs/zh_TW: update zh_TW's documentation
 from an ascensive aspect
In-Reply-To: <20230720132729.1821-1-src.res.211@gmail.com>
References: <20230720132729.1821-1-src.res.211@gmail.com>
Date:   Fri, 21 Jul 2023 13:44:54 -0600
Message-ID: <87bkg5dp6x.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
> Hu Haowen (6):
>   docs/zh_TW: update admin-guide
>   docs/zh_TW: update arch
>   docs/zh_TW: update cpu-freq
>   docs/zh_TW: update filesystems
>   docs/zh_TW: update process
>   docs/zh_TW: turn zh_CN's folder references and headers into zh_TW's
>     ones

So b4 doesn't like this one:

> WARNING: Message contains suspicious unicode control characters!
>          Subject: [PATCH RESEND 5/6] docs/zh_TW: update process
>             Line: +=EF=BB=BF.. SPDX-License-Identifier: GPL-2.0
>             -------^
>             Char: ZERO WIDTH NO-BREAK SPACE (0xfeff)
>          If you are sure about this, rerun with the right flag to allow.
> AM FAILED
>=20

Could you resend, please, without the funky control characters?

Thanks,

jon
