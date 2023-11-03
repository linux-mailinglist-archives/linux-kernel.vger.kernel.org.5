Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36297E09B0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377905AbjKCTxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377999AbjKCTxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:53:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DBBD60
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 12:53:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AEA6C433CA;
        Fri,  3 Nov 2023 19:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699041207;
        bh=eWbf+K66GYytFJTtMIaAJdCE2F8axlLD9adripxwAVE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=POjf9aza5WzC9bDqfmPS0ldnJVNKtBldXdtAR+f9PWa3X1RtE2zpxxsQ/R5PecvuS
         iDIOVj6OVYyUgjnDygYH4be/Zr/LkW3GYv2R9D/032CXEmyMXbgHD9gwVsmudh4Mzz
         UDvgCYPHychwC/t9VVT/EAxlEZu9BMbIDL2//0hTkqFQyM2ER2hVxB7dDy57/iOI3s
         HlVguDtEANfTxDuAIAv65562JfjRwjuf57XS3Op88ebMB1NGOrokefi5JcyPrhJ1S/
         C50bj1glZko9bszb44QtxgrbUJQuDgb6lFjE90OuRl4d7DtpX5vqNNnfly1pHuRKpw
         HvINLSP+vt5oA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1971AEAB08A;
        Fri,  3 Nov 2023 19:53:27 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231102150620.940538-1-namhyung@kernel.org>
References: <20231102150620.940538-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231102150620.940538-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.7-1-2023-11-01
X-PR-Tracked-Commit-Id: fed3a1be6433e15833068c701bfde7b422d8b988
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ab89417ed235f56d84c7893d38d4905e38d2692
Message-Id: <169904120710.17286.1383363118665594734.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 19:53:27 +0000
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  2 Nov 2023 08:06:19 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.7-1-2023-11-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ab89417ed235f56d84c7893d38d4905e38d2692

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
