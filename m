Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4304C7933D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240435AbjIFCuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbjIFCue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:50:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1259DCC2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 19:50:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B730C433C8;
        Wed,  6 Sep 2023 02:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693968627;
        bh=WXX8ywA+GcQsFV0bzI3D/8d0rLcnUXWMBd/za6XIDJ8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Qa/U9B4a4XIWLtVvmOJvZfQC+KJKICzElSsEJ3e2belqRIOeQqGHi2adEosOkooAk
         SIuh9xlukKszW6tIrcX/9YGRU0mCMo/CX9sw1jrogqvz+UyFG/BX8mELYgkDeNla07
         JY1rAqbZWE5HW6YMqKYZ9MB0k/ZW9N78SHWXca2N1ZfTohnpGICpkLB5le+ixDNjxA
         U98Fye0CclkAwW1Fhz0i1K+g3MIsYyAS/2IH3QQDFLoog4e3gFrc7AXGzHTdxRYv88
         STnnXzbbj7tCSaIq5j9nE09l4t3T3OoVdHBwjJMf4ba4uuCk07fs+mWpIi/X5AQE0D
         yjm3BIlNBoIbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FF6EC2BBF6;
        Wed,  6 Sep 2023 02:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Kconfig.errata: Drop dependency for MMU in
 ERRATA_ANDES_CMO config
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169396862745.1987.4794758415693130418.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Sep 2023 02:50:27 +0000
References: <20230901105858.311745-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230901105858.311745-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, geert+renesas@glider.be,
        linux-kernel@vger.kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri,  1 Sep 2023 11:58:58 +0100 you wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Now that RISCV_DMA_NONCOHERENT conditionally selects DMA_DIRECT_REMAP
> ie only if MMU is enabled, we no longer need the MMU dependency in
> ERRATA_ANDES_CMO config.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> [...]

Here is the summary with links:
  - riscv: Kconfig.errata: Drop dependency for MMU in ERRATA_ANDES_CMO config
    https://git.kernel.org/riscv/c/6fd57a739233

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


