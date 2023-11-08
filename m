Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA017E5CBE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjKHRwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjKHRwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:52:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25761BFA;
        Wed,  8 Nov 2023 09:52:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A7AAC433C9;
        Wed,  8 Nov 2023 17:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699465931;
        bh=dFqe0s/G1EJYN/XqcJCqrSQhPGT4gLExXzxVmY5ZxQk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KGN7PvVgJMfJQagFFtvo+u1qb7XWGILRpzKcVVrx5jHAvyC59xBnLRPd5bmyOD871
         B0q/X5m395QULGy9WA7PQpTvL8OY34ffUQ5//F8c9dHTsbEy1uxAkmFZis2P7de5FB
         snJ8lxNP47OaJbnQXFotbJR/g6PoDqr9CImZPBt/JEXxuqzshymoFFQaYqst0cm4Q9
         JhM1c0ogNwRkXVw/+aY9PHX90orRxyhjkRBBZDTVHxFakmKTlsi2nI7bM06KaRG1QY
         eQftAyHabq3rc4qGI6MZsSC9QYvjMqTA8nFuR8VZ0+NG7AMxzsvPO6GfoTcK3GGZLG
         pu/ND6wrQChgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 578FBE00081;
        Wed,  8 Nov 2023 17:52:11 +0000 (UTC)
Subject: Re: [GIT PULL] RCU fixes for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUoX2lAwknn9JkEm@lothringen>
References: <ZUoX2lAwknn9JkEm@lothringen>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUoX2lAwknn9JkEm@lothringen>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git tags/rcu-fixes-v6.7
X-PR-Tracked-Commit-Id: a80712b9cc7e57830260ec5e1feb9cdb59e1da2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90450a06162e6c71ab813ea22a83196fe7cff4bc
Message-Id: <169946593135.29156.12000710140286019429.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Nov 2023 17:52:11 +0000
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Z qiang <qiang.zhang1211@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Nov 2023 11:56:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git tags/rcu-fixes-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90450a06162e6c71ab813ea22a83196fe7cff4bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
