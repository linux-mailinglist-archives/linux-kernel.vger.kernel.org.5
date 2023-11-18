Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159687F01C5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjKRSCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbjKRSCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:02:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8373BD5;
        Sat, 18 Nov 2023 10:02:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29984C433C9;
        Sat, 18 Nov 2023 18:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700330530;
        bh=QveyNC18qMIv/bml2ZxJ4NFNmiVSUsho0mFebwctKaw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L+2DXsacGRlI/eD7NWD6hDxgTdVWfvMvEd5VtHhOSPoeYKKgnFJPczzcRL0JBNmhA
         j8nKRvnyVQp0XzqasGIglPxj05FR3WXtrNN0NbtT6aJKU1q6+9Pd6gHj/2omReGTSN
         fGlKEWJzKVVBkXo4xFeXBzuihkjdqH7+qHmCNjAHxC8+3Yb9QrFk/3/qJ9aZ4b0iHs
         +KPI3EI3hfF5kYXSEcHGIxxZsRJXxnH0sb0P1cypJC0oUnYYLrOgN+IKB0ZZLNNh7C
         4VBq275pkRW9M8yTMlA7A5RNqTqsxb3H62W7S3WyMnQ5FRd2mKdvuG8rKdvTqTtUth
         vztiV+0vbCXYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DE19EA6300;
        Sat, 18 Nov 2023 18:02:10 +0000 (UTC)
Subject: Re: [GIT PULL] turbostat for Linux-6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdKn-xtmin9OjnzHg8wy4PM8Lc3Per=3y3UWORhjdroYP3w@mail.gmail.com>
References: <CAJvTdKn-xtmin9OjnzHg8wy4PM8Lc3Per=3y3UWORhjdroYP3w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdKn-xtmin9OjnzHg8wy4PM8Lc3Per=3y3UWORhjdroYP3w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
X-PR-Tracked-Commit-Id: b8337e6a780dad9505f9d44da07c0a5c52fa0a04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ea991a50dd559ad2f1a5094d73f9583811979a5
Message-Id: <170033053005.28320.5678620610990243596.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Nov 2023 18:02:10 +0000
To:     Len Brown <lenb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 8 Nov 2023 00:03:38 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ea991a50dd559ad2f1a5094d73f9583811979a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
