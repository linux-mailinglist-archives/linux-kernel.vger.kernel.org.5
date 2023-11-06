Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255217E1923
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 04:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjKFDTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 22:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjKFDTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 22:19:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471B2BB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 19:19:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E514EC433C7;
        Mon,  6 Nov 2023 03:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699240766;
        bh=h7xcA19zdhI/T4E3b5MIEXaVr0v1Og9skFgWRkSG6rQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NzYasiL1Scp+uKHdYPXoynaFI34kmZl9LnKO2Yf3FX9YVz0WO2SwCaK/R3C8o8TLq
         +ML+0yQk0JSIhVjQYDx5hHCl+qhtA6CdlyLgS13vSodGEcxE2/5h2pzWLaYIKXjQIJ
         uvMdGDkgUAVQT3eAmLsxtN3FXUk7RldksWi3t8Xy3aQ3lpKaxy9y7pOPIbyS/TFXHX
         RB/PezszCZGwgKTt++ZZutaGLJIFVH/ccr1FnFizS4/BEr1fr46VF6ZPr8i631hPh7
         5mF3CaUvKBdJipM0r8qdY6p2fgF1LNR2byGviHrT+/ZXVv2FG+EoWhtTauoPb4EkDQ
         hnkFr9VHg+SVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D38E2C395FC;
        Mon,  6 Nov 2023 03:19:26 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY2JHKRv3+cjvnLONK+BDd=j7SbPa_oEecqQ7gtw19R5TA@mail.gmail.com>
References: <CABb+yY2JHKRv3+cjvnLONK+BDd=j7SbPa_oEecqQ7gtw19R5TA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY2JHKRv3+cjvnLONK+BDd=j7SbPa_oEecqQ7gtw19R5TA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.7
X-PR-Tracked-Commit-Id: 96cb7a4e296da9aaae0ad61394fdb2828e0a21b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b2c9e41e73fbe50f519072009b1e624ea230163
Message-Id: <169924076685.12392.3487230352954390071.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Nov 2023 03:19:26 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Nov 2023 14:42:02 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b2c9e41e73fbe50f519072009b1e624ea230163

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
