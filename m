Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A0B7F0945
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjKSWDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjKSWDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:03:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E20E139
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:03:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB087C433CD;
        Sun, 19 Nov 2023 22:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700431390;
        bh=cDFQxNhte2zM04HtTpuSLxnHcmcUPuppAjMFm7cfkdg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QrKj4TXB9fmcDVpQ8iO6L3r98Oin2cAQarhEAa4SeJXHolccUWdPnZSI7Mmn/N+Ok
         bVdSxJYRWP1kKsU4SWFmshkFbKd+s1I8PdGkvqhHZlxU42+lCMR5wnxsdNwk3BrISn
         79tbEzbukrXA2rdSivuFii8LyW3iRrsshlR2MUThNRnKzmNOf+QKG6HKPWBEEesiOT
         wJZDOafgVH+B4AtrWyfOo6ppvUNGa9VtpGkIrhqSd0HckRn5vDrThVAmG+FxAnlpnI
         W3PJ43jK2vAxBLlgLNdTqTnorRkfUU1LCpH8k1M2qLgfVqJO8AfrfwWlwMob6bUjBa
         zfANmXl7pF/bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9B90C3274D;
        Sun, 19 Nov 2023 22:03:09 +0000 (UTC)
Subject: Re: [GIT PULL] timers/urgent for v6.7-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231119130421.GDZVoH1TocfbiUjKfA@fat_crate.local>
References: <20231119130421.GDZVoH1TocfbiUjKfA@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231119130421.GDZVoH1TocfbiUjKfA@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.7_rc2
X-PR-Tracked-Commit-Id: 5c0930ccaad5a74d74e8b18b648c5eb21ed2fe94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0014556a2a1991df08b2b5d586a1bcc9e762ffd
Message-Id: <170043138988.9984.5704419855738075448.pr-tracker-bot@kernel.org>
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

The pull request you sent on Sun, 19 Nov 2023 14:04:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.7_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0014556a2a1991df08b2b5d586a1bcc9e762ffd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
