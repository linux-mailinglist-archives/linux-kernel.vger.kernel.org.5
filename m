Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B86580BCAE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjLJTMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjLJTML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:12:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7416BF1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:12:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 137C3C433C9;
        Sun, 10 Dec 2023 19:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702235538;
        bh=SfGl5/l5mszggs07mf73IyaPvpbrRB3M+3vvdYUjyhg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ac73Wdu6dG50lap5Fu4xh0E5ZctpkrUj/uYvfERpQ4JXeyldJfqoEY5NGnwzsauCp
         ctFNzdpbGOWXVHyvUAKZZQ6MAKlx8hE1q/l5mKhpLd0rYmtI+NW7j7RhUpoWWgvTRD
         sxO3KghnhQvKJdoeyc1GQZka6+CtZDEDmoIeLKgLdBDv4N9zqw9oS2YN1Y5JO0mEC4
         8QGc9/AQOyXetYACiHuecn2gUvnGGfdc1UatojXaiPWCaDVPbb07/U9rot8+m/xB0r
         2hJc1sPOuDU4NRUbZpCASmgZa0AZjkSSuYzl/6Jez5d1Y1sBxFWwQ3GvHlM9P7zoBv
         PxvcXc5UjfDjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F308BC595CE;
        Sun, 10 Dec 2023 19:12:17 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.7-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231210105016.GAZXWX6N31tS8bu6k3@fat_crate.local>
References: <20231210105016.GAZXWX6N31tS8bu6k3@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231210105016.GAZXWX6N31tS8bu6k3@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.7_rc5
X-PR-Tracked-Commit-Id: 9b8493dc43044376716d789d07699f17d538a7c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5412fed784876892c4d0960f003795b6dbdcfc5a
Message-Id: <170223553799.2016.12573171525395960793.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Dec 2023 19:12:17 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Dec 2023 11:50:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.7_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5412fed784876892c4d0960f003795b6dbdcfc5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
