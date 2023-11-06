Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662AC7E1921
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 04:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjKFDTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 22:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjKFDTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 22:19:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BF8FB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 19:19:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EDF5C433C9;
        Mon,  6 Nov 2023 03:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699240767;
        bh=wiqMzuMaV956d+3ym4s4C73aptfsfHg0OVa1RHrqErA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OhFIp7npTfuK/j4dipGO2nnp97mw2uz9EL9eDFTpXb8uTM2udivLnR//XxEk0dCi4
         mIYEqc8YqKm4v2lSai99AmciY1qvo/gX3KsAoFuwhnxRClHacVgWz2X84u1r6UoPgT
         /EQZMit4+AX8xypeoVEW/tIdcLH3P01ByIHKrJfsiEJfmmLeXK7upi4bhfjw4XjOnZ
         dRhEzZq9n9NtiCHPi5PJF6KbQCn803b1qzEn+XO5+/j2wkXuNHMzyaNH9/IOncsPtD
         c7/fpbUjAuRxs4gM740vYDVKJcQ/g90zQS886MKj9raOws5XxZL3h3vFurFO37vkA2
         XhHsVfztmBVrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 197F8C395FC;
        Mon,  6 Nov 2023 03:19:27 +0000 (UTC)
Subject: Re: [GIT PULL] RTC for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231105230218a45aa668@mail.local>
References: <20231105230218a45aa668@mail.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231105230218a45aa668@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.7
X-PR-Tracked-Commit-Id: cfb67623ce281e045ec11e3eddb1b68b879b53a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2f51b3516dade79269ff45eae2a7668ae711b25
Message-Id: <169924076709.12392.2756557352194646388.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Nov 2023 03:19:27 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Nov 2023 00:02:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2f51b3516dade79269ff45eae2a7668ae711b25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
