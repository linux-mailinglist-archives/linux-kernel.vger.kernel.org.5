Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980E47A3723
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 20:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbjIQSZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 14:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbjIQSYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:24:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05342131
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 11:24:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BDEBC433CC;
        Sun, 17 Sep 2023 18:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694975068;
        bh=A3oSpnLYVGyyCXMsyBCg+q+XIlWh6Ymg5N0/+lKMylY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EQJ/HGbT2H+h1FIzYb31TP6FV6DkgisSdaLcH45Nv3vrfyuv6cvFywODfs34HIUyW
         W49eTAjHz3DuSAgTXMUutv5GD7kd5Lc0+edcAT76FM9qsx3/t866RFp2Sd7XFoJ2ZB
         ZXiZ1Vg6WxIg5zwOuvveU219R9mQ2IBKRDcX3Jka7pu1IxHTvBjvpRxjeL8AUfEut4
         HdP/bsN5O8pHBF4plUcXgx5sA0Wa4jY+2iZMPZsZx1VrBXiDAKxPD3KWQfjodbHsRr
         +kXpq+oeCRSvtQvP0AqGgPBQd+aU8N03+YKo8aMbm9/4ZjmnGCR9x94rZha4jFZgD6
         kkH/tjL5dnogQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87F3AE26884;
        Sun, 17 Sep 2023 18:24:28 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZQc5wbfmwslRp8yM@gmail.com>
References: <ZQc5wbfmwslRp8yM@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZQc5wbfmwslRp8yM@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-09-17
X-PR-Tracked-Commit-Id: 108af4b4bd3813610701379a58538e3339b162e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5a710d13247975444c9a18e28413e566c334271
Message-Id: <169497506854.30007.1014878281461949863.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Sep 2023 18:24:28 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Sep 2023 19:39:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5a710d13247975444c9a18e28413e566c334271

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
