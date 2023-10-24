Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1437D469A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 06:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjJXEFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 00:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjJXEFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 00:05:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA938E;
        Mon, 23 Oct 2023 20:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1698119831;
        bh=IAhOV59IL0dDYPGzR0+4k0wjvyE6d0i0JVdfSx1wOqM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=a4QEyhDP0VqTgFZ9zxzlaqQC/4GByyJpTvk84VFb+90IYHaRdq5tVpIKlXPFwLIjl
         KRI0XKjVZ45pxojown33ZbRCrjFgxmgnD/2KSjrIL7mJqQ4MfQeBJf4+H3nfl9/TaM
         yUsnAhll712BIN/GVfO8/Ut8Bd7QjxIjj+cTVJFpGybXuvvFygy+jy7tmCim4eTYdM
         7jfEXuKHv8wc0OuskDH6/m2UeXCFTwayUCcolpE4q8s01BbVaRWp8SFdjtCY/Gq6I8
         ATam/zbdnfF2U3xhR5n6lcXhAiGXQwyF9XnOCEaUs0pWcXg0hRkBv/GCIFFLRBGEjZ
         u1J+lt4kLq01g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDytb0KQcz4wcN;
        Tue, 24 Oct 2023 14:57:11 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the powerpc tree
In-Reply-To: <20231024081617.686c086f@canb.auug.org.au>
References: <20231024081617.686c086f@canb.auug.org.au>
Date:   Tue, 24 Oct 2023 14:57:04 +1100
Message-ID: <87o7god65r.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> Commit
>
>   351a050f602d ("Revert "powerpc: add `cur_cpu_spec` symbol to vmcoreinfo"")
>
> is missing a Signed-off-by from its author and committer.
>
> Reverts are commits as well ...

Thanks, fixed.

cheers
