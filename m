Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3CC75D529
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 21:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjGUTmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 15:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGUTmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 15:42:47 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B741BDC;
        Fri, 21 Jul 2023 12:42:44 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6D5B3733;
        Fri, 21 Jul 2023 19:42:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6D5B3733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689968564; bh=RMbTZ6QAIEYXR0v3MGSWGDnizE4LNqSMYED2Lra8/TE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Nj5u7RR+5+DqOrN+Cor3wYXEbRuMfKrIIbZ/fmx5paaa5bOubyxaaNbRjdJtsZ9iw
         nFpeNzD2Ckee3RsRds8wkMOj39coeP1qY3BjvKgW8Vuw8r1qhrEW58inkpr42XfUQA
         MW3GI1rd4AQ4r+SjNAM4Xbp0zi+3a5xX8yXi9CdIUpUkIlStyl0Y+wGmvC8Sc2o0Wg
         QW6gA5pVf44B4unSCUoVXJ7B2uo8KyTy7pZd8o+KI0vit/Q1pDr2YnhlTYyCakZk1p
         0sthA6lVh5krR9JkQGYJApa6bjqDrMMyaxHDs6egBVPmOd4IMtsMV9BqVVKcJEyLEb
         xVAfBSI9D/1Ig==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res.211@gmail.com>, gregkh@linuxfoundation.org
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/zh_TW: remove the mailing list entry for zh_TW
In-Reply-To: <20230720141846.1787-1-src.res.211@gmail.com>
References: <20230720141846.1787-1-src.res.211@gmail.com>
Date:   Fri, 21 Jul 2023 13:42:43 -0600
Message-ID: <87fs5hdpak.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <src.res.211@gmail.com> writes:

> Due to some reasons the current mailing list will be revoked and new one
> will replace it in the future, hence remove the entry from MAINTAINERS
> ahead of time.
>
> Signed-off-by: Hu Haowen <src.res.211@gmail.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5c16bb92fe2..36e67c46a4a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21707,7 +21707,6 @@ F:	kernel/trace/trace_sched_wakeup.c
>  
>  TRADITIONAL CHINESE DOCUMENTATION
>  M:	Hu Haowen <src.res.211@gmail.com>
> -L:	linux-doc-tw-discuss@lists.sourceforge.net (moderated for non-subscribers)
>  S:	Maintained
>  W:	https://github.com/srcres258/linux-doc
>  T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw

Applied, thanks.

jon
