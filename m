Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D127DC35F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbjJ3Xus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjJ3XuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:50:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF4D10D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:50:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 901FCC116B9;
        Mon, 30 Oct 2023 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698709808;
        bh=L+LhhzY8mzQligXSrjfJySpAPz2hxpL4o6cgW1KpKUc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jl7vjLJ/Zf7gmvUT4955hpwsmyVFfQo0ancI3TxQrp4gnBJ47ibaPMtxp6AxGmoVW
         Sw8KE5UP/OmZCjClm+F2+QokJUD6umu7inSRueFdEYBo/X3T0+YpsAQL7bbdBcrPmn
         wmCqM+86tp68GxIz7/rIGEYf7avO1/t4r5t+bgnrMisY15xdLvmUMD9uObzucVNYw6
         NBszKeqXag74ST+cTg87mZWr8EM+NNNWG6QLvxmHIXlgpgpYuQWjR7NPmgK/Olq9iT
         AHhy1lpaMzbYbSYmW7+MPBYdu0GbFWx05GqCdusv4Yog7e4hWHiCHSMKZXSqRpF8fH
         r6QlsWuhEWJjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7EC50EAB08C;
        Mon, 30 Oct 2023 23:50:08 +0000 (UTC)
Subject: Re: [GIT PULL] Scheduler changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZTz9RpZxfxysYCmt@gmail.com>
References: <ZTz9RpZxfxysYCmt@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTz9RpZxfxysYCmt@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2023-10-28
X-PR-Tracked-Commit-Id: 984ffb6a4366752c949f7b39640aecdce222607f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63ce50fff9240d66cf3b59663f458f55ba6dcfcc
Message-Id: <169870980851.17163.1082644255436477074.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Oct 2023 23:50:08 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Oct 2023 14:23:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2023-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63ce50fff9240d66cf3b59663f458f55ba6dcfcc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
