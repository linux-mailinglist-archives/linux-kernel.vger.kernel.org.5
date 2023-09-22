Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB597ABA70
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjIVUTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjIVUTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:19:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11403CE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 13:19:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9ED5EC433CB;
        Fri, 22 Sep 2023 20:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695413948;
        bh=cfO7idRa9+p9l5kGemuA1/zF1+uWYI7d4xZEy+r781w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V3QAxUrvzgj9J6asagmQPP+xQ9WfMZMEfKheCzXj69+P9TBv5CpHzm2ujj6BisKnf
         yTEk2kVzi9QgGP3e1FoSwb2V6kkdjG3s5Zi4vHaDAPRUfZxOAvMQhqXCeKXn4pkoCa
         rpdqQF6SPhMnOwn0bvUHx3FUzL+1tiH8qswlSJe8PoWdLm77oSH175JKcbl7bx2/l7
         8m2NCptiJdcZ9Fcir0hQobfJ1/qZIc8RDtqSspuLsgc+VIMGHnsaA+VJ3vcRY3bYBx
         5K6vULDBmpKise61b+X/6KK+A6FLIC61p3H/v/MtS+LEKqFWK9RXxFufm2fd0fC1hJ
         +WprtIO+w24Lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AC57C561EE;
        Fri, 22 Sep 2023 20:19:08 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZQ1ryz9yFQ3Bcc3J@gmail.com>
References: <ZQ1ryz9yFQ3Bcc3J@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZQ1ryz9yFQ3Bcc3J@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-09-22
X-PR-Tracked-Commit-Id: cff9b2332ab762b7e0586c793c431a8f2ea4db04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b47b5766b21a59bb247488b374e62c3b72639fb
Message-Id: <169541394856.8311.14203190647808185127.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Sep 2023 20:19:08 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

The pull request you sent on Fri, 22 Sep 2023 12:26:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-09-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b47b5766b21a59bb247488b374e62c3b72639fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
