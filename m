Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FE17C60C0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjJKW7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJKW7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:59:20 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFF1A9;
        Wed, 11 Oct 2023 15:59:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CA731365;
        Wed, 11 Oct 2023 22:59:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CA731365
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1697065158; bh=dcs+dXQZDeau6GFz6ttdG4mVm3hykY4A3N/IfzLoWQ0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fwIM98iiMmYCnnwo/pR9KqSgjJH5wTxGhSK3gzPc6+BXPf+AwfFOQ3G3hN6O+musF
         KaPbaaqi4/6+9mgtuTUeZSufiSa2FmRBEfmLxLEpsko5td25e2WQcx/HVvDd+IrABq
         L619w1R2U8YTULalNZrFvtYuNyXoOSzJxLkt5/McxV7jR9NnB32djOM2yXv4QKXtFv
         QHNguamYrCnVho+XgY4cP5um2NpJC5vxLsHmzpbGbPstlr30v5xWkq6T27lbB3JuK/
         eew6V76wUFUYvvx11iZpRuid9/U1beqiNXrNVysxBWPeJmIdilRp4AL3bLQf0UA2Xv
         6+cO4Cxsa6G1w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res.211@gmail.com>
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4] docs/zh_TW: update contents for zh_TW
In-Reply-To: <20231011051212.17580-1-src.res.211@gmail.com>
References: <20231011051212.17580-1-src.res.211@gmail.com>
Date:   Wed, 11 Oct 2023 16:59:17 -0600
Message-ID: <87ttqw22be.fsf@meer.lwn.net>
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

> The content of zh_TW was too outdated comparing to the original files.
> Consequently carry out improvements in order to both keep track of sources
> and fix several grammatical mistakes in traditional Chinese.
>
> This is a thorough rewrite of the previous patch:
>     https://lore.kernel.org/linux-doc/20230807120006.6361-1-src.res.211@gmail.com/
> in order to get rid of text damage and merging errors, created based on
> linux-next (date: Oct. 9, 2023).
>
> Signed-off-by: Hu Haowen <src.res.211@gmail.com>
> ---

This *still* does not apply entirely cleanly:

> Applying: docs/zh_TW: update contents for zh_TW
> .git/rebase-apply/patch:757: new blank line at EOF.
> +
> .git/rebase-apply/patch:1067: new blank line at EOF.
> +
> .git/rebase-apply/patch:1410: new blank line at EOF.
> +
> .git/rebase-apply/patch:1442: new blank line at EOF.
> +
> .git/rebase-apply/patch:1716: new blank line at EOF.
> +
> warning: squelched 31 whitespace errors
> warning: 36 lines add whitespace errors.

I am tired of going around on this patch, and will accept this, this
time.  In the future, though, please do not send anything that you have
not verified applied cleanly.

jon
