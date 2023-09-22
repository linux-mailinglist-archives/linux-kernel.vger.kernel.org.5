Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B517ABA6F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjIVUTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjIVUTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:19:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB56CCA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 13:19:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C6F2C433C8;
        Fri, 22 Sep 2023 20:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695413948;
        bh=klGRCdqqEQoMiHDLnugHXywgdhKnhnlaVcY7h6c/DMk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SJDDXCuJZodZUYjTpj9qG+hlVMtvOQS7lgS/T7O8x/AKmCPXK4XcXgVRTCPOBDEat
         204HSgUNbyGkLHqlSV5c9HyBCGzWiONlHuh26cusB5/cE6ktqB0/BOoDyP96qQI91J
         VxyO13LXuSCew2B/sXp4muqlY0/UMd5MbakPzAUMX4K4NgKZGARjbmoQdZraF8oT8A
         q48OnaVX/PgOB9uUamLeCFkr0AyMQn+8QU2thiA9w9wKdpjaFV1clYkqe191phVAEY
         a3DWvv4hw4W298YXLOy44KLu8yUIYRIJNk38ALHH4HRYBdrWmSliFcjPFFhcOxcZvi
         kT2KL5uHigzJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55F85C04DD9;
        Fri, 22 Sep 2023 20:19:08 +0000 (UTC)
Subject: Re: [GIT PULL] locking fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZQ1odhFD+Kz1Eutj@gmail.com>
References: <ZQ1odhFD+Kz1Eutj@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZQ1odhFD+Kz1Eutj@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2023-09-22
X-PR-Tracked-Commit-Id: 41b43b6c6e30a832c790b010a06772e793bca193
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 725e2d7ec8936462d638a146a1359a815f9a5def
Message-Id: <169541394834.8311.2742374815459979240.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Sep 2023 20:19:08 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Sep 2023 12:12:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2023-09-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/725e2d7ec8936462d638a146a1359a815f9a5def

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
