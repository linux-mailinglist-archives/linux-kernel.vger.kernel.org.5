Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC607FA6CB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjK0Qrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbjK0Qrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:47:37 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF31198;
        Mon, 27 Nov 2023 08:47:42 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A11122CD;
        Mon, 27 Nov 2023 16:47:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A11122CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1701103661; bh=PElfCpTsbglocYhm74CbnFUGOn2AgVQ5W+x0cQZ4w0Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=h393ToUKr/8LyxxGob4vtHlmR2jz5oVauXHvneNcvXAQN2IMSLemP8RKRh6gzIzmz
         QhayC0Twti6twe4AIx+OEKZJjhUpiJx3oFsPDjOWngKcb59zctYJArtnN3jniq42fI
         9zbpSelIfR3vabzVJMGbytQajb1pTwAwmz372/CqfuWiaOq3nzqLOdr4s+LaKvHW2b
         iFZJk0AjwBUQsohnAnREIsehnoRuZAxvWEiwXDiurOzPR4gJkTrs+Yd+j82bLuLa38
         lJspGVv4xZoFn9YsWBw99cQgdTerUsj3A4FoKn4bQl1RVqFNYLQgh+Ud0Jyur22wyI
         7n9OIi5FRJ5Eg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     attreyee-muk <tintinm2017@gmail.com>, jpoimboe@kernel.org,
        jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
        joe.lawrence@redhat.com
Cc:     attreyee-muk <tintinm2017@gmail.com>,
        live-patching@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Took care of some grammatical mistakes
In-Reply-To: <20231127155758.33070-1-tintinm2017@gmail.com>
References: <20231127155758.33070-1-tintinm2017@gmail.com>
Date:   Mon, 27 Nov 2023 09:47:40 -0700
Message-ID: <87ttp7ywgj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

attreyee-muk <tintinm2017@gmail.com> writes:

> Respected Maintainers, 
>
> I have made some grammatical changes in the livepatch.rst file where I
> felt that the sentence would have sounded more correct and would have become easy for
> beginners to understand by reading. 
> Requesting review of my proposed changes from the mainatiners. 
>
> Thank You
> Attreyee Mukherjee
>
> Signed-off-by: attreyee-muk <tintinm2017@gmail.com>
> ---
>  Documentation/livepatch/livepatch.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Your changes seem OK as far as they go.  But please read our
documentation on patch submission:

  https://docs.kernel.org/process/submitting-patches.html

..and specifically the parts about writing proper changelogs and the use
of a full name for your signoff.

Thanks,

jon
