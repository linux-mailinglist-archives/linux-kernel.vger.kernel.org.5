Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B697ACC09
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 23:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjIXVYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 17:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjIXVYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 17:24:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BCCFB
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 14:24:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6D5AC433C8;
        Sun, 24 Sep 2023 21:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695590657;
        bh=vquzV9Z9cvNw1PCuFvu/NSysH3mMHjwILsZor7UH6IQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HyYeStJpyGkHZQUZGE0o+f8/zyfRGIXBF0MNEXoxL7VVepYDxaj/8wAsnLhNzgTgx
         adUKzfWUgJSq8NGDs7LStzIhmriM6lnZIOilzW6YqSHcOdJ8uovv1F1+aSrmGI/4AZ
         m1KpSriPI8ZBTXqTdcmFRkbSs1Gw7o7kvdWbjjmi4u+p1Os1GLf8syJJfv5a1SPoPX
         NVYlcsU9fokP2YiVxLzKUzqNu/h8sM1BY/dx0rdu1DFuSE0IF1/7DI2FRugKEmCAtU
         5NsW9h0OwEiCTNI9QUmoXOZKSmFixyFwTHLcjqvraePp2fq71cPjUFct/8Dtdl45Za
         YsyoFu0mQaIrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A31FBC04DD9;
        Sun, 24 Sep 2023 21:24:17 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for 6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230923191420.10c42e4f@rorschach.local.home>
References: <20230923191420.10c42e4f@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230923191420.10c42e4f@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.6-rc2
X-PR-Tracked-Commit-Id: ef36b4f92868d66908e235980f74afdfb9742d12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5edc6bb321d970c77d666a6cf8eeb060f2d18116
Message-Id: <169559065766.13804.7703829762889414346.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Sep 2023 21:24:17 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 Sep 2023 19:14:20 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5edc6bb321d970c77d666a6cf8eeb060f2d18116

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
