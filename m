Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8112D7D1EF0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 20:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjJUS3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 14:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjJUS3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 14:29:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC58135
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 11:29:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56691C433C8;
        Sat, 21 Oct 2023 18:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697912949;
        bh=7zQqeKynSOuLb5QKxMoDQQnbXA+XhnXkG2CNyjhsPr4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MHHFVkZYdHjbCMucibzoPsw9jT86QbUqOUuq7kPcNqO8V6uZz1B5Ab/JWfUPgyNuQ
         eIekiIMJyKFIvqFz95vCHrMoOm9URerd8GjsNcMT72hsW7ufBULbqBXDPFmI3arht0
         gYaZjpUzHu96hTdmSdd2WZ1az+T07CxIBNq0SSVh1gcbUftj67AqqQRzGktZ0bpY2f
         mJDBrOB8CIjvX0alO5iGFXRWsurnHEva/bHaApT2vGHyzheEX9yjI7HKdDBeu1zhS7
         OHMNyIV/5v7BWI086i2B+hus4LIGqHsBKuUheOCnPormyu5Sja/ODKJCmQHxQXl1JJ
         jH309v0XnLjjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E212C04DD9;
        Sat, 21 Oct 2023 18:29:09 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZTPuCcQkcn4TVTMn@gmail.com>
References: <ZTPuCcQkcn4TVTMn@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTPuCcQkcn4TVTMn@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-10-21
X-PR-Tracked-Commit-Id: d2929762cc3f85528b0ca12f6f63c2a714f24778
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45d3291c5201fced351e62d714e2912400cc7f4d
Message-Id: <169791294925.7212.17851864671872491297.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Oct 2023 18:29:09 +0000
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Oct 2023 17:28:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-10-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45d3291c5201fced351e62d714e2912400cc7f4d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
