Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580A677A0F4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 18:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjHLQIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 12:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjHLQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 12:08:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CD310DE
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 09:08:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECD0961AAC
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 16:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54BE0C433C8;
        Sat, 12 Aug 2023 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691856500;
        bh=YhJuv2YUd8RcLDNuIf7QaFoY7JrG2Me7vEH6nxE0w0k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nJHIyHE4jk7pvua8KnOaSgTdMxsCWNVizEauyiYzOr7YunbMYW+HOLdmvCd0aSlh0
         8B7BLww7v5Pv5JdSXYOPUkxRcYd0curCPC2I4jrD+1VGYIOA3X7SvDUT6RiL7rA8ZP
         iW3HeiuCf0b4vR4kREXJutNhPIOYpyf7VB22CUk9nY3Nt3UIIvId+Kwu9DVe33JxXF
         shL/Kf+ZDe6VgkNSPI4t6RKxkSYJT/kFyDbOwmiejor4YRr+67M+vXmToztszXhkFG
         SKohqQP3yDBrEuAZo3aSmnDD6PAVb9iiGbcFyxEcWQzLlfc0Q6/YIP86aW7DjkBpHA
         vmgBlBrZQCmfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 433F4E505D5;
        Sat, 12 Aug 2023 16:08:20 +0000 (UTC)
Subject: Re: [GIT PULL] x86/bugs for v6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230812093053.GAZNdRTZ8KT1SMIUtQ@fat_crate.local>
References: <20230812093053.GAZNdRTZ8KT1SMIUtQ@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230812093053.GAZNdRTZ8KT1SMIUtQ@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_bugs_for_v6.5_rc6
X-PR-Tracked-Commit-Id: 3477144c878a52fc3938a529186e81ea030e7779
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 272b86ba9d97518b3c14b97514b6544eef87e7a5
Message-Id: <169185650027.27778.14861352581783296471.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Aug 2023 16:08:20 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Aug 2023 11:30:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_bugs_for_v6.5_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/272b86ba9d97518b3c14b97514b6544eef87e7a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
