Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844BF7AF068
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjIZQOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbjIZQOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:14:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C178E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:14:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02EEFC433C8;
        Tue, 26 Sep 2023 16:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695744877;
        bh=I2/eCq+ueesjbaY1wQtRUaEZU9IZyKf5RNPtZKzXGQc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F7alCDU3JBFLO6G+ixaNXv2Hus++yh9AmVNtlPRQqR5bdZv4hm3k5gOq/3H1m0tCn
         6IFfaJKCw401KveRKoLAkhooAN8bw1G6qCp8fZTd8wLuTDt+gPACzojDNbUPutLXjt
         ba7Ph5sL8pdEOopjqcPcixkWiPlkVZXQEFcY5cCHwjSsKK0GQjym3yjIXWinRY2Rq9
         erfww6t44D3Z8XytzNIIXupaY+tAxFsFXHzucG7GwILJtD453F33AF3uw3F4dWrWKU
         mleTr6JhWqxNYtoVVplmuzYaSYOiilY7pxlYpwB4lfCAqHN5+jZdbULGie2hTjy2VN
         +DNNzPuJoFOfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4DF3E29AFF;
        Tue, 26 Sep 2023 16:14:36 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.6: 1st batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230925223709.3417084-1-namhyung@kernel.org>
References: <20230925223709.3417084-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230925223709.3417084-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.6-1-2023-09-25
X-PR-Tracked-Commit-Id: e47749f1796d1df39a7eaae95f2784aaa43df57d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c519bc075b3306a5b6a6d5f1e22f37357e936d9
Message-Id: <169574487693.15087.7978378581214612181.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Sep 2023 16:14:36 +0000
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Sep 2023 15:37:09 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.6-1-2023-09-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c519bc075b3306a5b6a6d5f1e22f37357e936d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
