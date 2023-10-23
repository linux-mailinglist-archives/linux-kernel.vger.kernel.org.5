Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AECD7D3AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjJWPap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjJWPa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCC5FD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 438DDC4339A;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698075025;
        bh=B5OsZe8/lVf1JmDcA021tEGnZnS+LMlkjLr6pX3ZOT4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QXJY1fq1FwwcnGpx9Dslv1haoPlKdmOnKQYRAMVQo1VBzHGh3OHReSxV3bveVYLvU
         vZOUBW6Cy5nK0ToUok+LIE1/y2gA74eTu0QiKDp1ojoCwz8TjTJaqluOpmq3uD0T6M
         /vIQFsmqVL6FFwVACpW3A4xnLYeZa7ysB7N3K6vPcRDLtj8/FyRZX91CuBKKj39rNN
         JpDiWqb/YzdjJaGvm/6stwHsjcaiptTeL8PGhAFsz2WeLreiZv+Q4HVZ6BQiNukyPn
         M20xh69t3e+HqHf7qciCYU4pCXKmdLu9+wcF4fjpQfWcCeQagbScL+FhXS4a6YKGNy
         sfO/LjILAJGhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D075E21EC2;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: Clean up errors in segment.h
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169807502517.26537.6705085074698625171.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Oct 2023 15:30:25 +0000
References: <1712b338.95b.18b27c8a5b6.Coremail.wangkailong@jari.cn>
In-Reply-To: <1712b338.95b.18b27c8a5b6.Coremail.wangkailong@jari.cn>
To:     KaiLong Wang <wangkailong@jari.cn>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 13 Oct 2023 14:45:42 +0800 (GMT+08:00) you wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: spaces required around that ':' (ctx:VxW)
> 
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>
> ---
>  fs/f2fs/segment.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: Clean up errors in segment.h
    https://git.kernel.org/jaegeuk/f2fs/c/37768434b7a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


