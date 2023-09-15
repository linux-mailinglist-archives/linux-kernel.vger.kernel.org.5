Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1107A2761
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbjIOTrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbjIOTrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:47:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08EF1738;
        Fri, 15 Sep 2023 12:47:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86007C433C7;
        Fri, 15 Sep 2023 19:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694807235;
        bh=lnGqubk818b5sfKyz5v4D54sJerHIMc08S2ulS6WhQo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ij/+d7b5X9nYw269yd0O9ItuP7x802PS5wgMcXG7oTtKwRDfv54CEKJCjbiWtRmtQ
         cxttGoSXZIUDkwz3/voOb4J5KUOhq+jMCiH8tsnGgcaim2Yl4cPztuR2/Gyd6KDgsA
         ctAXeuo4RC2L4TZuBYW7QammxBw9d2L/cdhgwrErwB72D8bG8qOyd/s3zV/tbe5XaC
         xJR1k7efY9q99zOvx6KJVOw0/812sjSqTixaORO4gjMw5gwDDWSv+814zf7UIIe2zw
         Rc6LBw+FLWagdHA33/bs/VIhC/tmLTwDPDpysFsX5K0TkawVw/qnXCPSQ8mXPQCY4W
         s4CaGciCvU/QA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 748DBE22AEE;
        Fri, 15 Sep 2023 19:47:15 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux fixes for v6.6 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhT4yfGtBf3ECh9gMEQg9Tx4=ZjHDj_uEDPVqR=ihWph4A@mail.gmail.com>
References: <CAHC9VhT4yfGtBf3ECh9gMEQg9Tx4=ZjHDj_uEDPVqR=ihWph4A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhT4yfGtBf3ECh9gMEQg9Tx4=ZjHDj_uEDPVqR=ihWph4A@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20230914
X-PR-Tracked-Commit-Id: ccf1dab96be4caed7c5235b1cfdb606ac161b996
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02e768c9fe47618056d876b5137424763486d886
Message-Id: <169480723546.21547.11410809862045289832.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Sep 2023 19:47:15 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 Sep 2023 14:42:43 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20230914

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02e768c9fe47618056d876b5137424763486d886

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
