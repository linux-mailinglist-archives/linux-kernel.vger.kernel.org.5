Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99427FF95F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346565AbjK3Saa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjK3SaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:30:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3599B10DE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:30:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9F97C433CA;
        Thu, 30 Nov 2023 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701369028;
        bh=X/S18rDtdxyHgxoYAi5a9JWKaZcSVpxepeUSLeT1xX8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vDdITaceRlVOiKh2ptGtFykvgrUX9I3qvNHoPmRzhbG1L774/dy8jZQqowan3dBZN
         Lnh+bkW4B0TAdpu9V4/7qtYH3gz7snddltguQiIG+yHtFvL0v/9RwdS1ohllvRLPpl
         VdQ3rmlcz2sxMmbUl278gYhyNhYrAfDN1S0iv3ZUhYmqhNVJfkE8+OvLdIf+VEj8F0
         0dVtCbMIGwOTGwa+NndraBAgXmiIaD9og/5diiW98MXeWolOaH49ESmrG+ryJI6BPw
         PX3f+OstumRS81fHCwfGV9bJWmVIc7vmNk5xDLMlTHR/1zntKfIacmYqkulVgJoryp
         NRwlACyw58Dfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A950EC64459;
        Thu, 30 Nov 2023 18:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: introduce tracepoint for f2fs_rename()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <170136902869.21709.10431255824319332465.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Nov 2023 18:30:28 +0000
References: <20231128093130.2885216-1-chao@kernel.org>
In-Reply-To: <20231128093130.2885216-1-chao@kernel.org>
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

On Tue, 28 Nov 2023 17:31:29 +0800 you wrote:
> This patch adds tracepoints for f2fs_rename().
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/namei.c             | 16 ++++++---
>  include/trace/events/f2fs.h | 69 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: introduce tracepoint for f2fs_rename()
    https://git.kernel.org/jaegeuk/f2fs/c/5f23ffdf17e8
  - [f2fs-dev,2/2] f2fs: show i_mode in trace_f2fs_new_inode()
    https://git.kernel.org/jaegeuk/f2fs/c/8e9cf55ef89c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


