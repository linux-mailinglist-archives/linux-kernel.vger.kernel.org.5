Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656BD7F9814
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 05:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjK0EAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 23:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjK0EAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 23:00:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C731131
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 20:00:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 167FEC433C9;
        Mon, 27 Nov 2023 04:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701057623;
        bh=MJhYrf8f29Vrw8fBuxfWISHzDTmZGwDZYtVGyO1ypfs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TPsvV6x9vPbA7+PCk1oUpuOagJve7LYBdtXxzzBJNSidbnBZBQTcg/aZilrPbEgEf
         gc3egEQedakby5ng75vEET2maeEyYL7iopP6OY3vrmPNudTdkM48qCYFr2MGMqIo1N
         RykVzQFYJ+3xPMtIOYJmBca7/SC+5+xvMEu14WZiCh23do1snGcKIC7X8l7GXlSMUv
         SIcillBsCohE3ADMDw1u1ZP9eMdYK+F5e/W4Kar7yFiANOAxlZ6rLMicDvyKmAzLTe
         CbTD8Zx0bgGVPtd5hk2JlqsQ8j6acwp9/MW7Zp14B2vs9KdFt7aUG5IzuJuaGNu6U/
         0wOq8CPRcc24Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC6ABC395DC;
        Mon, 27 Nov 2023 04:00:22 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/eventfs: Fixes for v6.7-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231126100356.389c325d@rorschach.local.home>
References: <20231126100356.389c325d@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231126100356.389c325d@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc2
X-PR-Tracked-Commit-Id: 76d9eafff4484547ed9e606c8227ac9799a9f2da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b2b1173a93fa056b4539ef52e5f03148345d498
Message-Id: <170105762292.16434.15747037694024366777.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Nov 2023 04:00:22 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Nov 2023 10:04:57 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b2b1173a93fa056b4539ef52e5f03148345d498

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
