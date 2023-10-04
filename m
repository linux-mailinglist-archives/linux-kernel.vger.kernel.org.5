Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BE77B80F8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242667AbjJDNcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjJDNca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:32:30 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BBDBD;
        Wed,  4 Oct 2023 06:32:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 75C286E2;
        Wed,  4 Oct 2023 13:32:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 75C286E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696426347; bh=NZtp19mQdUSl0U7YfU3zR5up7lX1MUHajIMW3G89VWU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GOASNQOmdaH3x4s82wDualBlHzl80M2qyi55IaYP51RpjxuDEAUQYMrylbZOPCUY6
         xelNKVyzLCTiDEP09dOBTgfVR1kozjyWNhE9MzYbBOyE1vFnSj1AIK+oSDRYxxluab
         z+/HMq+oOTPpNbtTaBywsB0cu78kIUYBbCg8mQfOerTocDBS2Xmcle5J9y5wzxNJYZ
         R8nDXfSEBzaMLOAd/bRt6ELuUvSUoO2XhKy/iWxFDxtpV8QC0GKOHNNESpHWLOw5UP
         geG+F2viDXePtLonYf+KwIA33uQd5POxxCYWtDkiYYFYUyA7lKxf445es2YuOshXYj
         aGIfgZ3eOqP6Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jianlin Li <ljianlin99@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the tip tree
In-Reply-To: <20231004133306.3285d8de@canb.auug.org.au>
References: <20231004133306.3285d8de@canb.auug.org.au>
Date:   Wed, 04 Oct 2023 07:32:26 -0600
Message-ID: <874jj64iol.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> The following commit is also in the jc_docs tree as a different commit
> (but the same patch):
>
>   c53cbc54ccff ("x86/iommu/docs: Update AMD IOMMU specification document URL")
>
> This is commit
>
>   73c5f76ecbdb ("x86/iommu/docs: Update AMD IOMMU specification document URL")
>
> in the jc_docs tree.

Hmm...I thought I even checked for that.  No worries, I can drop my
copy.

Thanks,

jon
