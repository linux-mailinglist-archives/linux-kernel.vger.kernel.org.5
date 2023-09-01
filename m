Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BC77900B6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345897AbjIAQZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjIAQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:25:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FDD10EF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 09:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0455B8259C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B26F9C433CD;
        Fri,  1 Sep 2023 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693585515;
        bh=xFHHICU0oX7e9xcoLMZr0SP3idCLvPufOEnHfkrVwLI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nnN8Pm8CqO1rSwNEp4GVKpQXmbBdVNwgrpUE4BD7il58RtdAqAsCYBd9W5+3nwU58
         oQRI2UNv2AXxzhJiyyFjFtBGnTANHXyZhkx1MmucPa5B1W76HRS6hvQNFGQEcjRPgc
         ld0aBTSQ6I6Kuze9qH4KnS50uzxcJLEgIHrm5UjUaF+85H0z6Vs2OeQM5jmViXNgRT
         FmGemGGavIQdqWQGn4+CxujbaEzV2AD0RSvdh30WZ/TLEeuc0yqb6tL7gs7YgOwmQs
         xEDFohIXEURXICq2qtzJaUYxNclIVLqdUb//DWDPYjhclvC/vzQGa+gNGpAxOxQItN
         SeGcK3+iH/1FA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 999D8C64457;
        Fri,  1 Sep 2023 16:25:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] RISC-V Patches for the 6.6 Merge Window, Part 1
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169358551562.8276.3620661978678741860.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Sep 2023 16:25:15 +0000
References: <mhng-d12081f2-1ff7-4f68-b320-f3aa5c458365@palmer-ri-x1c9>
In-Reply-To: <mhng-d12081f2-1ff7-4f68-b320-f3aa5c458365@palmer-ri-x1c9>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
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

This pull request was applied to riscv/linux.git (fixes)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Fri, 01 Sep 2023 07:41:21 -0700 (PDT) you wrote:
> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
> 
>   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-mw1
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] RISC-V Patches for the 6.6 Merge Window, Part 1
    https://git.kernel.org/riscv/c/e0152e7481c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


