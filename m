Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC3C791C8B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353459AbjIDSLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353430AbjIDSLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:11:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19683E6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 732DBCE0F9A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 18:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 597CEC4AF75;
        Mon,  4 Sep 2023 18:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693851069;
        bh=cFYymj3Ka1spHJa4/0G+nw3LrDmT9lBxaGODfikfc8Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HIoQAEctV7TS3fRVm0POXSQq9Ll+Bl1t7kZywcSeWsEy2YnSs+onEhSyT/mQseWrj
         bMPC7nhuY0L1UH9EBlpQyhyj4N7jWrTvmXPJmi3TkpUdkWj1ELjgvcLjpNKq8mlsQO
         bOEDpbVVjkdi0O3wHsXx9ygm7Ar5ooyxZZ06tLGcsKos/YK9M+1dPg7MKA/FPeMbCM
         Y2iIUHdQNocTzMUkxr/fBaE9jA1Jb0RX/Ye0HUzsav2FHJ2X8rQnVuAmCDY8qiQZae
         uEZdytHlkUKOKcWemWUidZ00bi2rCgj/Y+zQFLXT+T+mCPmSUtS6JmTM/XqFemCFNp
         KsyokaD/sILsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33A77C04E28;
        Mon,  4 Sep 2023 18:11:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.6
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169385106920.19669.8631180334558169868.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Sep 2023 18:11:09 +0000
References: <ZPJ7P1J+jbyL6Mve@google.com>
In-Reply-To: <ZPJ7P1J+jbyL6Mve@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
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

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Fri, 1 Sep 2023 17:01:03 -0700 you wrote:
> Hi Linus,
> 
> Could you please consider this pull request?
> 
> Thanks,
> 
> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs update for 6.6
    https://git.kernel.org/jaegeuk/f2fs/c/92901222f83d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


