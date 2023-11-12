Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13207E8DB9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 01:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjKLAzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 19:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKLAzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 19:55:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C1930F9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 16:55:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BE13C433CD;
        Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699750546;
        bh=uwSYhoJGjrvnFMdxDjEZiJOR3nt1YfMreVZ/T2Dv+hw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XNBBHv9eHQp/Z6l4k9c5NcC5YsIo8pDl+fvRJ5scAEYpVIoWr7GZu+ub2rCHIzket
         Ie+eKE8oK9wLGtvBLS7r+xI/B6KugX0WE005mXpgRbmG+XI7yGnZvSlvehXLdZ4q6D
         nP2QGCdvbxGwcB5+ZAFmWAZN+Ya/A1rFB36hc5CWt/GgSQ2lVeaKgg3Xp6WV89EXf6
         kgxQ2kC5b1dwMg08GI13fkOpTrwFiGtvghFHyGAoTUFiZRyHvu4CBM1sB11oEPB8Ar
         3k6MbiLkyF28K95zlgEybVq1cltRlruf+96/EwM0L8K599HcxIyGfzKaJ/rg1Zl026
         o9hXrL1oEdnFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54C48C3274D;
        Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] RISC-V Patches for the 6.7 Merge Window, Part 2
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169975054634.11360.7607646896972532722.git-patchwork-notify@kernel.org>
Date:   Sun, 12 Nov 2023 00:55:46 +0000
References: <mhng-9011bd86-9f72-4223-b78a-b4c69c1c927f@palmer-ri-x1c9>
In-Reply-To: <mhng-9011bd86-9f72-4223-b78a-b4c69c1c927f@palmer-ri-x1c9>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
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

This pull request was applied to riscv/linux.git (fixes)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Fri, 10 Nov 2023 07:48:39 -0800 (PST) you wrote:
> The following changes since commit e1c05b3bf80f829ced464bdca90f1dfa96e8d251:
> 
>   RISC-V: hwprobe: Fix vDSO SIGSEGV (2023-11-02 14:05:30 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.7-mw2
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] RISC-V Patches for the 6.7 Merge Window, Part 2
    https://git.kernel.org/riscv/c/56d428ae1c4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


