Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F348D7E8DC5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 01:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjKLA4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 19:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjKLAzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 19:55:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1B13253;
        Sat, 11 Nov 2023 16:55:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 904A9C433B6;
        Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699750546;
        bh=GWFlwV5YPrVZ6YqtdodHarmTAW1nmW1GwfZG0HStF+4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CLW3YqRliByr8MVQWRDb96pqbs+bgb8VYnYzh8IgZuWvnLxifxD1laYtt6yXJaCas
         mv2WgeLdJKaJNW2i4omu/dTUTBVCDYoOTVuNvNqL1mxZfPoLICkDFUWX5LCAfyZlGw
         rWzlCyMrwStgDH/r4b9Xgrs650LOTj3m4AQujf4KSEAo9ZOuKxS2SkGLELPR8H60TW
         gUW6+PrJwfGEdTaQxBiAECGR7JgEn9BDdRRsSgl3j5Q+PbfWBetaaVFS3UBwHNhwt7
         ZZuOd1sudlgi0QrmPefAsQSKA1aL74V/QYMzTvOc4Trja3vUQH6Bz3ipGNVJaeu6H4
         loRxLJnJOUeGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71B15E0008A;
        Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] docs: move riscv under arch
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169975054646.11360.7774579809979814716.git-patchwork-notify@kernel.org>
Date:   Sun, 12 Nov 2023 00:55:46 +0000
References: <20230930185354.3034118-1-costa.shul@redhat.com>
In-Reply-To: <20230930185354.3034118-1-costa.shul@redhat.com>
To:     Costa Shulyupin <costa.shul@redhat.com>
Cc:     linux-riscv@lists.infradead.org, corbet@lwn.net,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, federico.vaga@vaga.pv.it, alexs@kernel.org,
        siyanteng@loongson.cn, philmd@linaro.org, hca@linux.ibm.com,
        ardb@kernel.org, atishp@rivosinc.com, alexghiti@rivosinc.com,
        sunilvl@ventanamicro.com, evan@rivosinc.com,
        conor.dooley@microchip.com, heiko@sntech.de, andy.chiu@sifive.com,
        bhelgaas@google.com, songshuaishuai@tinylab.org,
        ajones@ventanamicro.com, bjorn@rivosinc.com, anup@brainfault.org,
        bagasdotme@gmail.com, charlie@rivosinc.com,
        catalin.marinas@arm.com, bobwxc@email.cn, samitolvanen@google.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        workflows@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Jonathan Corbet <corbet@lwn.net>:

On Sat, 30 Sep 2023 21:52:00 +0300 you wrote:
> and fix all in-tree references.
> 
> Architecture-specific documentation is being moved into Documentation/arch/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> 
> [...]

Here is the summary with links:
  - [v1] docs: move riscv under arch
    https://git.kernel.org/riscv/c/ed843ae947f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


