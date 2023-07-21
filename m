Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A1175D552
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjGUUCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGUUCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:02:07 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC14272C;
        Fri, 21 Jul 2023 13:02:07 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D8FCF7DB;
        Fri, 21 Jul 2023 20:02:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D8FCF7DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689969727; bh=fNbzLj8Rpoub4yqE/rqNeDgF89u+Mjo2vuixfVH7F/A=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=UcRk7NgU9/MNCJGo6Nys+zJk8WsvlTrfWr9lsXPI0RYHxZ+i4zBKqwP4XmAxLr+Du
         c/Qeik5yHsDSXlZhJ/tMp4TWr2QOmm28Y91pp2dnNfckll7cyCIQlU8efyYZY7efMh
         6NoGebPhGnBwby6JJ5IFVAqFp7i1c+2+K48wfQDH7N4+4KweTfc4oCf/GmUz3aceW3
         +S+NPLo3hYo/wRRHs4fYD47SqPhvxf8ItXIGKnhXNBmBEoado14D/jxJKTNwU7MUlF
         cZHbS0p/yZedapsAzqMwZEuZvhq7cUPeatOt1qMXsQJZUOoEUeCdG935k+rMk/39NV
         TiSxuq+V7c5hA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Costa Shulyupin <costa.shul@redhat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Wu XiangCheng <bobwxc@email.cn>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:LOONGARCH" <loongarch@lists.linux.dev>
Subject: Re: [PATCH v3] docs: move loongarch under arch
In-Reply-To: <20230717192456.453124-1-costa.shul@redhat.com>
References: <87edl6wr9p.fsf@meer.lwn.net>
 <20230717192456.453124-1-costa.shul@redhat.com>
Date:   Fri, 21 Jul 2023 14:02:06 -0600
Message-ID: <87tttxc9tt.fsf@meer.lwn.net>
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

Costa Shulyupin <costa.shul@redhat.com> writes:

> and fix all in-tree references.
>
> Architecture-specific documentation is being moved into Documentation/arch/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
>

This, I think, is ready to apply, but I sure would like an ack from the
loongarch maintainers.  As it stands, please let me know if you object,
otherwise I'll apply this in the near future.

Thanks,

jon
