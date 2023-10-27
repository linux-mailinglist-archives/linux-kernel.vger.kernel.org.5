Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDDA7D9999
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345876AbjJ0NUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345637AbjJ0NUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:20:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE431AA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:20:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DCB7C433AD;
        Fri, 27 Oct 2023 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698412829;
        bh=YAk84VJOwIpChhwNXLqiGhcPcgNcRILY9tm8GXp1qpY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=U15/DfsOdV+iq4jbJb2p7ZnxaXXF1gplhYbJMemUVKQ3HOfVnEkIMpMfMHCM2ftOw
         thvh8NIQ9yO0a4ckEAfQQS/njCTSiB+3MwFZEUHu4ZadpFrHxJDtDRsY6cu7Sgg915
         LB02MGa3od4BL2tEGrLq2rn/i3+rS93sVaT1kcstPAx8O9n9ZdUBvxD1IhK8Ynfubd
         jztHdTszgu1Dq1F3dav4hfJWkCjRYmBN4BLAGBzaTFi/IolUReZx+Gvj9x88wutfVl
         86+f6NIs31vyBSMrAYnvT6Zip+DktHKd20hYbHMYbdTX0u39iBXeHyifsEayeEdn1H
         j9uDfmBJzrqGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55350E2A04B;
        Fri, 27 Oct 2023 13:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] riscv: Using TOOLCHAIN_HAS_ZIHINTPAUSE marco replace
 zihintpause
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169841282934.15670.6832237271707727931.git-patchwork-notify@kernel.org>
Date:   Fri, 27 Oct 2023 13:20:29 +0000
References: <20230802064215.31111-1-minda.chen@starfivetech.com>
In-Reply-To: <20230802064215.31111-1-minda.chen@starfivetech.com>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, conor@kernel.org,
        jszhang@kernel.org, samuel@sholland.org, daolu@rivosinc.com,
        heiko@sntech.de, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
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

On Wed, 2 Aug 2023 14:42:15 +0800 you wrote:
> Actually it is a part of Conor's
> commit aae538cd03bc ("riscv: fix detection of toolchain
> Zihintpause support").
> It is looks like a merge issue. Samuel's
> commit 0b1d60d6dd9e ("riscv: Fix build with
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y") do not base on Conor's commit and
> revert to __riscv_zihintpause. So this patch can fix it.
> 
> [...]

Here is the summary with links:
  - [v1] riscv: Using TOOLCHAIN_HAS_ZIHINTPAUSE marco replace zihintpause
    https://git.kernel.org/riscv/c/a09560a7b160

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


