Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CD88000EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjLABY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjLABY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:24:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00A8194
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:24:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F07FC433C8;
        Fri,  1 Dec 2023 01:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701393872;
        bh=Qnc9Ow9uW1WXd41S5OXRqUVE5Vxrs5QYLhkMLt4I2Hw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=akgwYWAaF8e68BagB5MxnMORmM4ydmbhlcuiT8c5QgAYfqR3thyB6e2uIbu6O0ngB
         yjR4GG14THLthAxgvqjRL2BCOj4FjRLdZ6lGfCJvOEIcT0uJq/CM0JgJoLyR/W/3wl
         W+iEZ6ecqkkUYQVt6UKDhVBLiGVI0yB6e+/7UVTprMLkh3NppwY7417fDzdqwgKxQo
         Irrl27lgPoRmAn8QTPd3Xp9tq5cXSWHYzo2AzvuZQkZF/iKIx73wSi73OtW7lHLMW2
         mnxoy69HuDbd6zKHzodxAQBth6GTt9lEpTqrp9AjCzFZWYmHSqptNurTQYRIEALUk9
         LNXPtxWbDZ0jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C9C4DFAA86;
        Fri,  1 Dec 2023 01:24:32 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.7: 1st batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231129192158.1026606-1-namhyung@kernel.org>
References: <20231129192158.1026606-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231129192158.1026606-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.7-1-2023-11-29
X-PR-Tracked-Commit-Id: 57686a72da08ae555d93148aa8756b16417a6aff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2594faafeee2f4406ff82790604e4e3f55037d60
Message-Id: <170139387224.13864.8455010638349731961.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Dec 2023 01:24:32 +0000
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Nov 2023 11:21:58 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.7-1-2023-11-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2594faafeee2f4406ff82790604e4e3f55037d60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
