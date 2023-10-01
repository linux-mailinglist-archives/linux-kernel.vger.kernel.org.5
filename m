Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C8F7B48BE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjJARIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 13:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbjJARIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 13:08:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BB283
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 10:08:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5CBCC433C7;
        Sun,  1 Oct 2023 17:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696180098;
        bh=rIxOYjI3GOdZg9X/m/2x92ZThBipc49IsicSCL9XT2g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ehhSlzS2UBj97C3+Q9jH5Xj4RpOdJh2yraxeubLfjvVmtOPn+iCHipo3syf3xH4/R
         KraoC3a68jzoPO6XvSl37djjtGwOIrX/r+ZF+kc3dhF1q/OBJVdzuvIkzjDENswK/F
         NoSWVdm1tWzZYxMzTUWW/LNkiPNblS2smrFLbZggLHP4LiKCKUQ32LUSEKQWoXqDqx
         RbHEjUYdF5ySgHxf44gowwRIdhRhQ7GAzyr/LarJldr/MQ4k8tgPlguq9Y7LlwTboM
         0mlAa3okJ933lRoo57bIT/nyLefbjw9bym6s2W1/oIqcBi3d7Uy891FtfH/W649PE7
         TWNT5ReBGSHcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F36BE29AFE;
        Sun,  1 Oct 2023 17:08:18 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZRkvXkyEXYfoAPiA@gmail.com>
References: <ZRkvXkyEXYfoAPiA@gmail.com>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZRkvXkyEXYfoAPiA@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-01
X-PR-Tracked-Commit-Id: 599522d9d2e19d6240e4312577f1c5f3ffca22f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a38c57a87aeb5c6d71a1b6dd572569112dbce38
Message-Id: <169618009864.11241.5479391659294189712.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Oct 2023 17:08:18 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Oct 2023 10:35:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a38c57a87aeb5c6d71a1b6dd572569112dbce38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
