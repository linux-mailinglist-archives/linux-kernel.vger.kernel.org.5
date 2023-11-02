Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1487DFB6B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345530AbjKBUVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKBUUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:20:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A3DD6B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 13:20:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A82BFC433D9;
        Thu,  2 Nov 2023 20:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698956430;
        bh=o+okMsX1sujuGrVBY8RFU/Wu9ztfX9TyxTvpmsJCxx4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HHDH5fW0VoxooDlTJ+8nCB5rfErz3QU6csb2u63bYlKAc6kiSvrDayvvYChCW+IMH
         a7mtiHV8kej5cPyJ1h0X6+h7+xFcZMk+Um3WR4lOVGvd4UJH3V2i46r4OTOKSWHqQI
         iYDaqWP4P/zwIpv4fVYtPcp62WuQDFfnmTylMtQlAjcu74d6WfF2lie6rQ9k55E80Y
         jwVyrJ2I5T3RoQ4FJWF6DB/PKvZAcbHzgi94UiMPF1/BDuzwJ58WV3MsbPAwrIB0BD
         GXXwvxz9aUIaZbHH8cYR90KL6sIlQigiYe3rQ3KsehR9noDPzPrJRhTi3BaCGUFO1v
         A5fUJgUgMGWvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84251E00081;
        Thu,  2 Nov 2023 20:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] riscv: errata: improve T-Head CMO
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169895643053.22248.14459905412132338813.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Nov 2023 20:20:30 +0000
References: <20230827090813.1353-1-jszhang@kernel.org>
In-Reply-To: <20230827090813.1353-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 27 Aug 2023 17:08:11 +0800 you wrote:
> This is a renew of Icenowy patch series[1], patch1 is necessary to
> make T-Head C910 powered SoCs CMO work correctly. patch2 is to name
> those instructions following thead-extension-spec.
> 
> Icenowy Zheng (2):
>   riscv: errata: fix T-Head dcache.cva encoding
>   riscv: errata: prefix T-Head mnemonics with th.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] riscv: errata: fix T-Head dcache.cva encoding
    (no matching commit)
  - [v2,2/2] riscv: errata: prefix T-Head mnemonics with th.
    https://git.kernel.org/riscv/c/c1c99e5f1b13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


