Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4771797F16
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbjIGXKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237132AbjIGXKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:10:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9798B1BD2;
        Thu,  7 Sep 2023 16:10:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41F35C433C7;
        Thu,  7 Sep 2023 23:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694128242;
        bh=V4CrQRyosoIn9quYLa9Fu8QjEX3o+zQDMHSt/u/meng=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IEOcLl4Aj2ln9iGMlRiMHmLdWxfmhCSUN+LVCEFp/5mdSVzAo/QP+E+7dQAvLOo1k
         2smp/1xE44kb0hc6sc4/kKq8Wfumt5WiEw65TdVtStQcPfSdFRas0gU6JAt5Ia/2Jc
         oW6Fm93Q2VqgShwOIHc8ID4k/s80NrQC2BNM2n9D3PPkSK6DzzurIF1BGOV32+hfFf
         48ZhZbORqqtCiglmpq6UBLlGKC6eSOMhzdEABntXOIrfikitDaoDkyDYSG7yFWVRVH
         LJ8LNPuuOjOTacSDeyCrO4dnpqHwxyatEunq3nETSqvWnW+g7XdBOKR98veSgjJnuW
         jAHjno8xmGT0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31CE5C4166F;
        Thu,  7 Sep 2023 23:10:42 +0000 (UTC)
Subject: Re: [GIT PULL] RTC for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230907204645b1480693@mail.local>
References: <20230907204645b1480693@mail.local>
X-PR-Tracked-List-Id: <linux-rtc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230907204645b1480693@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.6
X-PR-Tracked-Commit-Id: ce413486c9a0d735d86cc7d88660abeac99c2501
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff6e6ded54725cd01623b9a1a86b74a523198733
Message-Id: <169412824219.8351.12421694295925937533.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Sep 2023 23:10:42 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Sep 2023 22:46:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff6e6ded54725cd01623b9a1a86b74a523198733

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
