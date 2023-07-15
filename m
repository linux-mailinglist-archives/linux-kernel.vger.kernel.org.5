Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC57275469A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 05:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjGODqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 23:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjGODqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 23:46:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4642113
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 20:46:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C510461DEF
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 03:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A740C433C8;
        Sat, 15 Jul 2023 03:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689392779;
        bh=ndV0xs9b5Yz27xvcW8OA4T5bCHsVUJAg7LMx3qXj/tQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XiLi/dLKLUxemHO8ZHGlj1pgVo4ElruiG4iwxrTU3GQ8wuEdaH4zw+BNxWYGykJMp
         mzv0pnwI7AZwTjtxsOreTIxnpfwku0YRojEcIPOJYOOMu6qtH7+eDDJn0z6TbE3cXm
         IQTBiT1Zfza/aXyuozrCN/0eIeMfpI+viL5v/tUMHd7oeKUR4xJlQ1lOzmWtoz+wXt
         eQLRkUhLusPqzIMEcZlsPyPV/the2dfZEOeUUEp3mokn5jMpCEVLOSthm/qKjPBejS
         6euGc+jcDP6KgibLq1Sj+HNoOuq7ko25Tl3mhHmFaw8GC5Uzy2QwcFiewcXmdqUZMu
         2yKL89FZ8oNMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15E62C4167B;
        Sat, 15 Jul 2023 03:46:19 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.5-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230714203722.GA3273303@hirez.programming.kicks-ass.net>
References: <20230714203722.GA3273303@hirez.programming.kicks-ass.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230714203722.GA3273303@hirez.programming.kicks-ass.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_6.5_rc2
X-PR-Tracked-Commit-Id: 535d0ae39185a266536a1e97ff9a8956d7fbb9df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6e6cc1f78c772e952495b7416c9ac9029f9390c
Message-Id: <168939277908.22484.16914685212363607611.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Jul 2023 03:46:19 +0000
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
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

The pull request you sent on Fri, 14 Jul 2023 22:37:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_6.5_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6e6cc1f78c772e952495b7416c9ac9029f9390c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
