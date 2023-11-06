Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AEC7E27FB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjKFPBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjKFPAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:00:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61B8A4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:00:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 287D5C433D9;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699282830;
        bh=fsH0EcJFPJldadwX9edPxnf9TI0xu3QSOxwn6f0XkpU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TkqsSIj2ElDEAeFUuPjTIskNX4GnW42wgemrPBhq7LpMuyUPMC1At+isID90JzUBY
         J5yEE6nRBUbk2QHeshVAsKsh3R2oKUe0tMpoh63bKflSJnNqTSTxxZLCV3cmf6FGK+
         tPziAYD12gRWMd5HwZoB88H+Ktu2q+1u7HbRlYs4mCbrmpARjqOSvrHlhVEw9ZOLPt
         IOLfyXpy3yi0MZrPCZNIH9aDQl5u5Jx6xwoxR9DXQwCvXKkb2YzgkeROfRxg7cifej
         ml3g9rJBI4/JCItaFWO8EDcsvr+uolcMdvNTac/M/2sVt1jXQRftTgN5lw2uLrObgl
         zyzXivdFeoaZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1345EE00089;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: defconfig : add CONFIG_MMC_DW for starfive
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169928282907.16503.712664664958063675.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Nov 2023 15:00:29 +0000
References: <20230912133128.5247-1-tangjinyu@tinylab.org>
In-Reply-To: <20230912133128.5247-1-tangjinyu@tinylab.org>
To:     Jinyu Tang <tangjinyu@tinylab.org>
Cc:     linux-riscv@lists.infradead.org, william.qiu@starfivetech.com,
        hal.feng@starfivetech.com, conor.dooley@microchip.com,
        palmer@dabbelt.com, apatel@ventanamicro.com, ttjjyystupid@163.com,
        falcon@tinylab.org, wangjiexun@tinylab.org,
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

On Tue, 12 Sep 2023 21:31:28 +0800 you wrote:
> If these config not set, mmc can't run for jh7110, rootfs can't
> be found when using SD card. So set CONFIG_MMC_DW=y like arm64
> defconfig, and set CONFIG_MMC_DW_STARFIVE=y for starfive. Then
> starfive vf2 board can start SD card rootfs with mainline defconfig
> and dtb.
> 
> Signed-off-by: Jinyu Tang <tangjinyu@tinylab.org>
> 
> [...]

Here is the summary with links:
  - [v2] riscv: defconfig : add CONFIG_MMC_DW for starfive
    https://git.kernel.org/riscv/c/07863871dfb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


