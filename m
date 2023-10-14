Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32D57C971B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 00:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjJNWuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 18:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjJNWt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 18:49:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7933FD6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 15:49:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14995C433C7;
        Sat, 14 Oct 2023 22:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697323795;
        bh=KA8eEz1iLtMkurLsZ6MtcmMyeQjcj7BNdtdzUaDlO4w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HBqzZyXkFuPvoolVn1PWjIMHHSDmEsTpQhDjEehXSmK/0Z763KP6zUyoN4mkyO2Lg
         yHLeOF9aLriQ00bk0dcKPiiISpO4PCm1+iaDLG9aMkY/5ItMDQJgxH6uFBmdLIO5CP
         vPfi/JBzrOR+eG7m9k/QUPK1GxaKKFHcbamq8sI0yqfreYHliEgUz9lfk5isVn7HBQ
         yFbB5h7DPh9NRAsl3rNycP2q1Uijrvt+ttxVsZ6gPasnyegTJ62lO8Y/HQGgkrJWwa
         Kxd8zPscnlVBouhy1TUeGNPtlT+fbRPwT3zmNVJ36BoyxEPrmFRv9VK7vxfqVX3qHz
         DjVFOixgSIaiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0264E1F669;
        Sat, 14 Oct 2023 22:49:54 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSsP6Fq86Vn1goMS@gmail.com>
References: <ZSsP6Fq86Vn1goMS@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSsP6Fq86Vn1goMS@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-10-14
X-PR-Tracked-Commit-Id: b01db23d5923a35023540edc4f0c5f019e11ac7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42578c7bf6e5eb816b694133ba33f0ff67c68582
Message-Id: <169732379491.22000.7043038629024436935.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Oct 2023 22:49:54 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Oct 2023 00:02:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-10-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42578c7bf6e5eb816b694133ba33f0ff67c68582

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
