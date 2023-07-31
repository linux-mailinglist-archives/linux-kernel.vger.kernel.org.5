Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43378769C88
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjGaQb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjGaQbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:31:17 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C851722;
        Mon, 31 Jul 2023 09:31:15 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5C6F92B0;
        Mon, 31 Jul 2023 16:31:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5C6F92B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690821075; bh=WuhGN+0w12HzEnIjIyqr3pVITUuBo6hhUZepmI9V0I4=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=F4xaU+0GfW9MY8ozX0wGQOiP60L0TdKARqQ38plJBvqkJQhrIpZfZ3Wt40ySFvciR
         zTasFRcmCw3DPBwPgF598lm5UpFGFiWGvTtmiGubF26NtL6qKleYe3aKzsHEGy/aHa
         4jWQulSZl/89wXLqRbaajJ70FSVcgL2fo6fAcnc1uxaiLMIkoJW5IcFLd03FJ9VEvs
         WeBa4hVullBOXc0pgzlCmPyO70m9oJzMb2LM/bV2hn0TGsLN5+fkNonY3bbcSzKF/W
         FS2Po45yZjlS8r9G6mcCQa88DNZoWT0aLgalLooVqEC2EekBCEquAu1Ip1K8rUEbpM
         pH/ou6e6BgTCg==
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
Date:   Mon, 31 Jul 2023 10:31:14 -0600
Message-ID: <87tttkcab1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
> ---
>
> Changes:
> v3: fixed typo in drivers/irqchip/Kconfig
> v2: added fix of MAINTAINERS and drivers/irqchip/Kconfig
>
> I'll continue with the rest architectures.
> Thank you.
> ---

Applied, thanks.

jon
