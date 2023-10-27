Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737A97D999B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345899AbjJ0NUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345418AbjJ0NUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:20:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB654128
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:20:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48E0CC433CB;
        Fri, 27 Oct 2023 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698412829;
        bh=f2AN9n2SGUdj3WhF7qofZVbhCYe/MlJUbsmLiJFPCGg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ueYP+9ZGhQbeZiMxxDUuMCVQng0X7FCICwBG+6SBbpwNfZUnnRwqywM16KkE/mNtk
         vbr94uhR0+sKg8b2BaNC+bsxHN08rBokCt0ZSKG8/MP2nCcyfrnNqFm/4Ru6z7TUqy
         EvDoMm7Ur0oANAfcNwGz50t6gh5+6t04ttp4S1cCgmwllyj45dl54P0IlI5yJav/I6
         kSZTMOodNpU6ANCzGtaNbIPCci2uy23YSuw3Bebxf/QeW0dKS5Tetiius8DpM/mE+5
         F3+pJ++N5m2RCJgKpzsxaiCHP7kDEX7XOGZD8B+EPZhZEBCmVuFgSehRpWGnGVD/SC
         BwoDRGbLNovkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B020C691EF;
        Fri, 27 Oct 2023 13:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv/mm: Fix the comment for swap pte format
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169841282917.15670.3034020143210458340.git-patchwork-notify@kernel.org>
Date:   Fri, 27 Oct 2023 13:20:29 +0000
References: <20230921141652.2657054-1-xiao.w.wang@intel.com>
In-Reply-To: <20230921141652.2657054-1-xiao.w.wang@intel.com>
To:     Wang@ci.codeaurora.org, Xiao W <xiao.w.wang@intel.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, david@redhat.com
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

On Thu, 21 Sep 2023 22:16:52 +0800 you wrote:
> Swap type takes bits 7-11 and swap offset should start from bit 12.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - riscv/mm: Fix the comment for swap pte format
    https://git.kernel.org/riscv/c/9a2834e91d3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


