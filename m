Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC047A3216
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbjIPTAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239402AbjIPTAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:00:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57534CEF;
        Sat, 16 Sep 2023 12:00:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28032C43397;
        Sat, 16 Sep 2023 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694890816;
        bh=xIqcK/R//RlxYgC2Ynj/gClbab/yVat/iBg2ny1/nTw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mnpfOyBilsnfK0ctIA+LfiHww+qmucrmdtg0//Grpp/CV6CKw2OFcY05jUb2ZWsBC
         sgyNouVVotQ3mx9ah0/zwyY50Uir18XT5pL3i597mCj75VYJsTwt2ip8HRn0Wqz9v3
         5+2bGydbM2UEq9Iv97er59aahn//ZEqc3Cc4GieQ5MHAdGmbUAsWoggJxmrcM4SMci
         xTbipejHTGFT27g2iDDwjvJsFTwrNXQ/e3RSrxJod8l5RdjDco/TuxFD0YfGKDVqFn
         wo/0uREBSkr9zZc7rsly8UGk6hJ1rci09CMrtW/wOR3Iw0kGzfdwo4t6r1zyTZAgi1
         2OJTzKnSk+7TA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 132AAE26881;
        Sat, 16 Sep 2023 19:00:16 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <94d10ea743052bef7798f5ab2aafbdd30d8c8657.camel@HansenPartnership.com>
References: <94d10ea743052bef7798f5ab2aafbdd30d8c8657.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <94d10ea743052bef7798f5ab2aafbdd30d8c8657.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: dae40be7a1a72474e225795c0d6f43a4ac596a3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad8a69f361b9b9a0272ed66f04e6060b736d2788
Message-Id: <169489081607.3998.7906098468045259721.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Sep 2023 19:00:16 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Sep 2023 12:16:15 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad8a69f361b9b9a0272ed66f04e6060b736d2788

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
