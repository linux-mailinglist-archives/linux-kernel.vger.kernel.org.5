Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73E87E9236
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjKLTSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjKLTSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:18:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ECA258C;
        Sun, 12 Nov 2023 11:17:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3003C433C8;
        Sun, 12 Nov 2023 19:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699816676;
        bh=1+3tJtMjI7wpQEi6NPy5Fgb0dusz+MuX2kpQJz6RI4k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fwq61TBUCv5b9oq1+N0UvEBNCdvDrKpr/XAPsXJoFERz0khcWI/+XeyXNDYgXv+0s
         z3CFMy6Li4aENoLq3CRb0HOQHDgkM/IT9gUfRIr6cia8QbAJL3grYdaBNj808u4hoS
         qZNHHZZ4v5lYRBwL9lxnpWo4JsdWppBKrdISbjvo8VYuE8ZBa0b4oOYwIihrgDM3dx
         OVQMr/2FFRvEAoSvKANY2YBIkXGJtc1GIHjcjIsuvLUMGifIk4lpMlx+lxoW5d8nfK
         V6h9sgXVTSdo7BC1c62mTtZcFdL/zeu3f5Jh75od852yDXcZFbDnp0DIru5M58cxgY
         6LL96zOg99Q9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4F01EAB08C;
        Sun, 12 Nov 2023 19:17:56 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.7-rc1 (part 2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZVB4JP/NpxqHCb7a@p100>
References: <ZVB4JP/NpxqHCb7a@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZVB4JP/NpxqHCb7a@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.7-rc1-2
X-PR-Tracked-Commit-Id: a406b8b424fa01f244c1aab02ba186258448c36b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b57b17e88bf58860dad312d08db7d6708ee6d06d
Message-Id: <169981667665.29349.10646731368750295063.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Nov 2023 19:17:56 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Nov 2023 08:00:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.7-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b57b17e88bf58860dad312d08db7d6708ee6d06d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
