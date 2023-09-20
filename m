Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5A27A88F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbjITPut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjITPuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:50:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE81A9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:50:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78016C4339A;
        Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695225025;
        bh=/1672Hbz58PbiCTUwJZm1qr1uRwDuYVk0zfuDwqJfm0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GAmidUmtByFG8Xtpk8rggPpB/ji6VR6J7VnGb4aX9FVQ4HZQIqx/G3Ht/x+gZBhHb
         EbU4bfxB64mXttF646xhh6PqCjKPFr0PlozCuIQtlABZibZYuwjclr3rvmEIYAfO4w
         RN4rZX6wulcZoZJSFiHhpCQ/TGCC9cI5e+ZKVGvlXYTcelNOAkxqPwvNlJUiNA5wZ3
         OJSR47v26BRE1upTW2bDEdZ4YTnrIJKboQ7kX3XHQFw7oGuArxCrdoYuOtxejcT/Yh
         kOTHDlo6qJX79lonWrRX7Kd1BGQ3vqTpyvCB8HUCi/2R2mLzH7jmtOmjoFapiyRth1
         sWBhIsqubeLVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F1A2E1F66B;
        Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: preload extent_cache for
 POSIX_FADV_WILLNEED
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169522502538.22557.17553337845342817079.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Sep 2023 15:50:25 +0000
References: <20230920004645.1462354-1-jaegeuk@kernel.org>
In-Reply-To: <20230920004645.1462354-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 19 Sep 2023 17:46:45 -0700 you wrote:
> This patch tries to preload extent_cache given POSIX_FADV_WILLNEED, which is
> more useful for generic usecases.
> 
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [f2fs-dev] f2fs: preload extent_cache for POSIX_FADV_WILLNEED
    https://git.kernel.org/jaegeuk/f2fs/c/a3edf9f0bbb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


