Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17B87E27F0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjKFPAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjKFPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:00:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5424D100
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:00:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 392EBC433C8;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699282829;
        bh=xSG+Ja17EDqBU85fr8ps1SzNAsdaKw9WxD9i/lfipeY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QZibdXyCXVmwOX87BsRnnWf+9oboGZDdYb1eYiLcbAS+mzutFZcCoZFL9EgNIIguA
         bzoQhBm+owb5t6LSQHtKqxmk8FOB/koKQ1sCXfyZfJAL4vPgGfwnjzBw0IkVbHoOa/
         dn/KwjzGR9aT1kg3/rahaIL4LiXEVCz0u/rCjAahBSwlyz/dIxLDWPLkukt2Fi2sCO
         QfT7x/v21dw2tzq3EXCe9mchLdAQCj6ZOogJmkXKwdASYelC/S/vkFau7hBuXnwRKk
         /EdSRhCbzEYnt5cmnMaYTdSKQ6VD0RJHpDjJAKqfMqeps6/GogxmpUme7WW64u9p2e
         AwIzOF5/jQFrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B0E6E0009A;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: don't probe unaligned access speed if already done
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169928282910.16503.15372785968223640890.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Nov 2023 15:00:29 +0000
References: <20230912154040.3306-1-jszhang@kernel.org>
In-Reply-To: <20230912154040.3306-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 12 Sep 2023 23:40:40 +0800 you wrote:
> If misaligned_access_speed percpu var isn't so called "HWPROBE
> MISALIGNED UNKNOWN", it means the probe has happened(this is possible
> for example, hotplug off then hotplug on one cpu), and the percpu var
> has been set, don't probe again in this case.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> [...]

Here is the summary with links:
  - riscv: don't probe unaligned access speed if already done
    https://git.kernel.org/riscv/c/c20d36cc2a20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


