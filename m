Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A45E80BCB0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjLJTMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjLJTML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:12:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83357F2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:12:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FCADC433C7;
        Sun, 10 Dec 2023 19:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702235538;
        bh=2cDYdTUMn0UuLC+5NcHe0y9qyfwUtT/JMBwk8JO6RBs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e0i2m0IBKy9Hi7LDG2SSZm3uCoarG3RrjGoC2HDK82Ftc8v734YVzGYDhMW1Xk03C
         9Xk9M0M0itNA6IIT9koFAUdHcXjl4AVIljdf0V6jFBHAJ3NUbP6SOvlPKPixVf/spV
         TdhdKYepLFIa+CcAiCNAnW3k3c182g5jZuJDMTUowBvNn/iLJrbbx9cqyCeQ7ZpwP6
         IZmO1u/908rlMolUYcQGuUp/9UqHjwjFpopG2FhnjeTFEevuCbzMST1PffIqRYG4Rh
         meU6hfEoDzXZuigZ60yRWhuwH5VMDKxiyNpM4CDZHiXnZpCBi7HBUUVhMsccY3fH/V
         /4Q6a+nCMTaVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B377DD4F1D;
        Sun, 10 Dec 2023 19:12:18 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.7-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231210105949.GAZXWaJe6DeHU9+ofl@fat_crate.local>
References: <20231210105949.GAZXWaJe6DeHU9+ofl@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231210105949.GAZXWaJe6DeHU9+ofl@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.7_rc5
X-PR-Tracked-Commit-Id: 382c27f4ed28f803b1f1473ac2d8db0afc795a1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 537ccb5d28d6f398215e7f578e46ee7836f5ac47
Message-Id: <170223553804.2016.18062417799398725332.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Dec 2023 19:12:18 +0000
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

The pull request you sent on Sun, 10 Dec 2023 11:59:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.7_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/537ccb5d28d6f398215e7f578e46ee7836f5ac47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
