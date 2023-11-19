Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A457E7F0941
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjKSWDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjKSWDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:03:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCD1137
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:03:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C66FCC433C9;
        Sun, 19 Nov 2023 22:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700431389;
        bh=XfC39Q7u3+Vybuc9QCJC1HAwphizoQj6sppcOU8Blc4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hLF7Mt+MEHfgrOko1d6za91mQOT31p4n1pSffsD8iZEE8MOf4idHb7yIkW8ahpZqH
         hret6GNNlJnRpEF6H9R5T2YzPxNPgpB02PfU0DHxBWR9k66uJCxcExQEGdwhE2sz94
         yAW60OdA9+x3+IKgfDidqUPvigvOHGvaE8lnDWFCOOlj5JwOMy3xoG1f/N7MTDPYT3
         mcQr2ZgUFPUh7mODDLwjGEnRLjelszBZAdrLS3nnLqaZTEKI7c7cQ1/nAMZg6vKE+f
         Pbl+uy9BgUgoowiM225UYUTLRz9u+LXJNm9hCNcD73qh2sYd58Ta7+JEdm1kskCG/w
         82Psr/Dsz8vxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B12E8E000A4;
        Sun, 19 Nov 2023 22:03:09 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v6.7-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231119125753.GCZVoGUQHr5N9ILels@fat_crate.local>
References: <20231119125753.GCZVoGUQHr5N9ILels@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231119125753.GCZVoGUQHr5N9ILels@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.7_rc2
X-PR-Tracked-Commit-Id: 6d7e4782bcf549221b4ccfffec2cf4d1a473f1a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a0adc49548e9116fdf9d7a39f5e0d8c1e16bef6
Message-Id: <170043138972.9984.266311065134991965.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Nov 2023 22:03:09 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Nov 2023 13:57:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.7_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a0adc49548e9116fdf9d7a39f5e0d8c1e16bef6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
