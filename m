Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777407933DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241799AbjIFCuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbjIFCue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:50:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C12CF0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 19:50:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7460C433CA;
        Wed,  6 Sep 2023 02:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693968627;
        bh=lTNLwQ7okag0fOcjp9NfJ2YNfkn/HkdbRQdwKEU1NEE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cWJ/3/8tTZtivtzRaZy3EmmqrMzo3rqMAy4h+GSKAXTq7UoMPw8wl2fxVo2NjMqG+
         uU76O2irK/j8GSbZ8wW0iO8QzzOfYPST8vYv6xJZRAAVBH9Q5xuTjlA6ZZH0Fc9T9l
         RA5jBb65hO8qJXdbYdh+/k10t3Le7jkduiIRcwnCvnrdsOGXSI7k7PZqe+J4pLxJ7f
         8BVEsIszxYsqrtNCQwc+Mip2Z8gP7GgR+77JCWpTw2m6PncqbrZJaCC1Kr2X3/sXA3
         SP+/N/6LVwk0MeT9hm/tjK2PQq6/OkLyYwXmGzDge60zVniDtH562IhA0Cn8yMlICH
         kHBEOuwVC1L4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97A54C595CB;
        Wed,  6 Sep 2023 02:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Kconfig.errata: Add dependency for RISCV_SBI in
 ERRATA_ANDES config
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169396862761.1987.8028551010129102757.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Sep 2023 02:50:27 +0000
References: <20230901110320.312674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230901110320.312674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, geert+renesas@glider.be,
        linux-kernel@vger.kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, lkp@intel.com
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

On Fri,  1 Sep 2023 12:03:20 +0100 you wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Andes errata uses sbi_ecalll() which is only available if RISCV_SBI is
> enabled. So add an dependency for RISCV_SBI in ERRATA_ANDES config to
> avoid any build failures.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308311610.ec6bm2G8-lkp@intel.com/
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> [...]

Here is the summary with links:
  - riscv: Kconfig.errata: Add dependency for RISCV_SBI in ERRATA_ANDES config
    https://git.kernel.org/riscv/c/005846ea7265

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


