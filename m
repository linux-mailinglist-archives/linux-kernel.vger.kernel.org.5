Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5807DC44B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjJaCMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjJaCMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:12:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F0AB3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:12:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB0D1C433C9;
        Tue, 31 Oct 2023 02:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698718349;
        bh=/S9RjkfQM+srEm/wdyQkwnt1KJxjEKkHwPDy29O7gL8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pw8Y+9lWg4/pNqZw7YyV6eh1cdQVY7e9z72ET/tXK3Yds1fCssjmYyEP39OxGAmQR
         x0+xKe63duuXOb7DI2BZ26vuW1gCJAV8Xy6vMsugpRNRTuzS3OrE/6NN4ZjxIxtyf1
         uyMn6idw3RytYWnh16zZuiaTt17zSVQRjuF1aMKjSugh6JY/t67DgN5Te2sW1US6lk
         ZcqxCpmt4C1SQxyFCR5VsuMJvE682e2EEMMAFn6lrovg661j4eiFd6BRFOgpibR8CT
         zfj67Mo4np1xxfPx6VY9yXlRXw8gdUCgoOD3BVwRb8h1QkdEnJl9uIiM+ggqzeSezy
         unjDJ48nFHCqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C705FEAB08B;
        Tue, 31 Oct 2023 02:12:29 +0000 (UTC)
Subject: Re: [GIT PULL] perf events changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZTz194jcY008KDCm@gmail.com>
References: <ZTz194jcY008KDCm@gmail.com>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTz194jcY008KDCm@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2023-10-28
X-PR-Tracked-Commit-Id: 744940f1921c8feb90e3c4bcc1e153fdd6e10fe2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bceb7accb7b60f9844807c7433af06493ed058b7
Message-Id: <169871834980.5591.654322225427050816.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 02:12:29 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Oct 2023 13:52:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2023-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bceb7accb7b60f9844807c7433af06493ed058b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
