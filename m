Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05FC8001EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjLADMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLADMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:12:33 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1CA1711;
        Thu, 30 Nov 2023 19:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1701400357;
        bh=F+eemxID8zfTy/ruTCOTo0d3EXe5X2w1QPkRpR78dqQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AYWCthT3Cc4OavkvdIPlxGVT5FPG5D0Kcpf9gVQ4prm9G7rkEb2GPFX9FzsImp7ed
         cqQrqeLBqaSYkB1cE2WZicIwpuZk+lXzMO/orjH6HZ6sVSqimW9T/yyVkgkXKI8VRk
         SONQqxKO1u3+xEnnJKMZ/faR7CiXyf5gLYr1sQEgA9fbKj4s3sdDZjIfTBo3vwpz/P
         rHWkHyGH9BU1p6184e238DoUma4l6EVcDT1fc9QAF65xbXE4lI0zFlBgtgV//6eQyv
         KGpDj3InY9LhNYovM/Jo9ik2rdyIe/WTlaC1F2j9jtkvTUa+GjyI7jxjHti+S8WAM5
         ZLISLjLJq4lZw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ShJ5c58N9z4wdD;
        Fri,  1 Dec 2023 14:12:36 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build failure after merge of the mm tree
In-Reply-To: <20231130145251.f9dca8d062117e8ae1b129c1@linux-foundation.org>
References: <20231127132809.45c2b398@canb.auug.org.au>
 <20231127144852.069b2e7e@canb.auug.org.au>
 <20231201090439.7ae92c13@canb.auug.org.au> <87sf4m27dz.fsf@mail.lhotse>
 <20231130145251.f9dca8d062117e8ae1b129c1@linux-foundation.org>
Date:   Fri, 01 Dec 2023 14:12:27 +1100
Message-ID: <87msuu1uqs.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:
> On Fri, 01 Dec 2023 09:39:20 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> > I am still carrying this patch (it should probably go into the mm
>> > tree).  Is someone going to pick it up (assuming it is correct)?
>> 
>> I applied it to my next a few days ago, but I must have forgotten to
>> push. It's in there now.
>
> I'll keep a copy in mm.git, to keep the dependencies nice.  I added
> your acked-by.

Sure thing. Thanks.

cheers
