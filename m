Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616E380BCB1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjLJTMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjLJTMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:12:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E03F3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:12:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30131C433CB;
        Sun, 10 Dec 2023 19:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702235538;
        bh=7v1kHN063ujhudh2hi432qRzHRj/gmDKZGjvwrXfCrQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Q6r4QV2z7YhrpmfMz81PSbj8/kmxuW9q7hK/7oLL53Xkvj4p2ZMoxR28QJ+YQrfJT
         dnbjLMy1m5QcpKS0VFrNH44MLtlxAz90Rspgs/6COLowwBTsdrNvBBhE83+fA0bx9c
         I4MF8I/AlQRgT8yX3nfqZpBVYgPMArqrRfNv4lYgaNzGOgI4EvCb9sNZezmwoC0yGD
         WsLv4HofmUtMRvW9lC2ShZdG3SipaAlRYSO5GGVsUcRWYgRQywruDSrwcp2FQ7cX2t
         bU1i6ySNWMG8Oip6tmGWo9IzkAb3MSCPzzR3UcuWdWwQOOuNSc5JhsbYA9dZ1GqIYH
         d9INB7htrcXeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18110C595D7;
        Sun, 10 Dec 2023 19:12:18 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v6.7-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231210110924.GAZXWcZIYk7wDdydJS@fat_crate.local>
References: <20231210110924.GAZXWcZIYk7wDdydJS@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231210110924.GAZXWcZIYk7wDdydJS@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.7_rc5
X-PR-Tracked-Commit-Id: 23ab79e8e469e2605beec2e3ccb40d19c68dd2e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a87498869d6d1e7347cd01f337a77984604eb5e
Message-Id: <170223553809.2016.9431047058872476936.pr-tracker-bot@kernel.org>
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

The pull request you sent on Sun, 10 Dec 2023 12:09:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.7_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a87498869d6d1e7347cd01f337a77984604eb5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
