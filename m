Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8E978DC9F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243138AbjH3SqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244552AbjH3NUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED07CD2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6475D61D29
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3CCBC433A9;
        Wed, 30 Aug 2023 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693401634;
        bh=hVtW05MKV0sf+IwOEnA77nj8VabEYfwLfx+JdrrM5ZI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pVqYuCawbpySbWx7oJa82WSo0DRz7LHqGQqpmRgIVVauivbzUh6A8pH3pCIdHPSMu
         zCAZlkHT1qH9t/LegYPbzGtYGMrKdRrPPd7YFrNB2X57Y3nFNXsCvCW67Jkc4LceCq
         6rtqYK32VSRp6dvRwyuja0X0+7vNPAO87RvpDc3qLM+s99rzOHUGG5lL3hT3Btf13w
         iECrzczJ0RSPq/7b7ZA4GNAhiCveZtPmuyTp9EtnKzJYp936vt/50t+zgrOLrRN57k
         te/YEn7tYOdQcWHnlIUKyZB0G+mPHzbzNFPxOknSqg9MiaNNA3RMcOESL4fw1U/zbf
         UuQ/QMfrG6dbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92961E49BBF;
        Wed, 30 Aug 2023 13:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: =?utf-8?q?=5BPATCH=5D_riscv=3A_mm=3A_use_bitmap=5Fzero=28=29_API?=
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169340163459.19859.10905358770015380538.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Aug 2023 13:20:34 +0000
References: <202305061711417142802@zte.com.cn>
In-Reply-To: <202305061711417142802@zte.com.cn>
To:     <ye.xingchen@zte.com.cn>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        sergey.matyukevich@syntacore.com, dylan@andestech.com,
        ajones@ventanamicro.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 6 May 2023 17:11:41 +0800 (CST) you wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> bitmap_zero() is faster than bitmap_clear(), so use bitmap_zero()
> instead of bitmap_clear().
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> [...]

Here is the summary with links:
  - riscv: mm: use bitmap_zero() API
    https://git.kernel.org/riscv/c/88ba8c83bead

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


