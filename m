Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07BF7FF95D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjK3SaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjK3SaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:30:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3653A10E2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:30:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C02F2C433C8;
        Thu, 30 Nov 2023 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701369028;
        bh=apCs06f4J/Du08lI0NgP2FT6ujYJ6vHVZ/T9S1lKJeQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ysnh1Sh2sCaD4/iAgls8JZt2CSRDEH6v3T7Xf13LwLICRSawMUFPaWclKJkZnGLHT
         DHaKsnJR52es2NIToxhAIPDeWVKqKNaH/jRcP8JM6nmrhdLpg/i97C/PSYVP9niF2j
         eKq95KbQy37EfJNS56+n+hmJx7PmRTVr1EV07wM3Fri+oOdtlksP/RuF80/2fPngcq
         Dhnhhv2MpqjkwlIMXFUMruWjjbEmG3FOLRqE6VUP/WXaHjvpSewedK7Zmbf09geE2T
         MY1gdUc2NhyO1OYr8M8+Db87bbSEDz38TOgRrO/tgxs/TGjbkIouD91/6la6hTnwaU
         sDFNxx3O/nhxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A179DDFAA82;
        Thu, 30 Nov 2023 18:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: clean up w/ dotdot_name
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <170136902865.21709.4443581224551288791.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Nov 2023 18:30:28 +0000
References: <20231116062556.2451839-1-chao@kernel.org>
In-Reply-To: <20231116062556.2451839-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 16 Nov 2023 14:25:54 +0800 you wrote:
> Just cleanup, no logic changes.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/namei.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/3] f2fs: clean up w/ dotdot_name
    https://git.kernel.org/jaegeuk/f2fs/c/ff6584ac2c4b
  - [f2fs-dev,2/3] f2fs: use shared inode lock during f2fs_fiemap()
    https://git.kernel.org/jaegeuk/f2fs/c/9458915036dd
  - [f2fs-dev,3/3] f2fs: fix to check return value of f2fs_reserve_new_block()
    https://git.kernel.org/jaegeuk/f2fs/c/956fa1ddc132

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


