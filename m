Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9DD7F0943
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjKSWDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSWDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:03:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6A9136
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:03:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88D54C433C8;
        Sun, 19 Nov 2023 22:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700431389;
        bh=9QWlRaQMv8GsodtVQJ5B/PKUzpT1Mw5/BDikm70FjIo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=keEBy6JxI1CMw1EwpsnmL9QwdWWMbvDdUkU22MV7Bm6AyrRLuI5+pF5mICS7aLW8P
         KgNw2Y2ncfku7d2mErY2zNYVljWJdw0OZZr3vBh5vWfE6VIFMOFDTrxQOTycGiYhHu
         +Ly1Mx0TAL7NaH501jSIRZe4pTRhLzt4XtgfaXJ++gbMWsovoERA4W5mTywEgWxKei
         /Q1MIfZJR9BAd+ZEZi9vGezRMsuwxp2Jq2J/KUnKjz5UIOr9V2r/DxzkmrnHYhqadi
         TDpcEqZZBpu+lamR2DK2QYYO/piSLBV8no/yNwjaeiMoE3wUDVIzVjMSaee1m6+QjA
         EJ+czrOAdv9Aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77C30C3274D;
        Sun, 19 Nov 2023 22:03:09 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.7-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231119123855.GAZVoB39FG7JDZxDN6@fat_crate.local>
References: <20231119123855.GAZVoB39FG7JDZxDN6@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231119123855.GAZVoB39FG7JDZxDN6@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.7_rc2
X-PR-Tracked-Commit-Id: 889c58b3155ff4c8e8671c95daef63d6fabbb6b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8b3443cbde91251970893fe4d5dc465c1a76a7e
Message-Id: <170043138948.9984.3814114506532429484.pr-tracker-bot@kernel.org>
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

The pull request you sent on Sun, 19 Nov 2023 13:38:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.7_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8b3443cbde91251970893fe4d5dc465c1a76a7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
