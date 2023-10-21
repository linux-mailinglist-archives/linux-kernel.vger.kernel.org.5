Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3847D1EEF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 20:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjJUS3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 14:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJUS3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 14:29:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3163126
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 11:29:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43365C433BA;
        Sat, 21 Oct 2023 18:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697912949;
        bh=CYMFehuDpXW0RdJK67WBZSawfhbZJZr4lwSgcxinr44=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=idYgsz/6HBGG04X0s9HFeAr0QOhdBBt7kke6JaZ/W84nvZ8gFoDmJJvtyIRuUA7+r
         V3zQdnCmX16Sh1/bZ2k/e/c8gbk8GMk/VPjt7Q3ECwbJMbRo6VzrCwnD5H1BQYBff8
         ssRg1bCNVRvUNUXOMi4yLMKI7AUS8exO1mctvZKlThPP3ROHtB+us0T95FJ1sbgzEm
         HVvaBXj7f3PM3+oRwd+mdFnWrgJ6k+zu8vFg5cox4ajx5ta6Uh8q1OBXFb4su2NhXR
         lpoF1zUEAD8yQjm3Ky08LbY0WszXxmJnPeLN4ImeF0nJXmq2KMpXroG0YR7rUp1u3v
         YRVDKskz//lYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30B62E4E9B6;
        Sat, 21 Oct 2023 18:29:09 +0000 (UTC)
Subject: Re: [GIT PULL] probes: fixes for v6.6-rc6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231021190124.9e591c603d227379453d3307@kernel.org>
References: <20231021190124.9e591c603d227379453d3307@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231021190124.9e591c603d227379453d3307@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.6-rc6.2
X-PR-Tracked-Commit-Id: 03b80ff8023adae6780e491f66e932df8165e3a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 023cc836053539148ffd015d3938887ef19af1cd
Message-Id: <169791294919.7212.6381900807541601302.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Oct 2023 18:29:09 +0000
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Oct 2023 19:01:24 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.6-rc6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/023cc836053539148ffd015d3938887ef19af1cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
