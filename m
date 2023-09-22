Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8877D7ABA7E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjIVU2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjIVU2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:28:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47308CE;
        Fri, 22 Sep 2023 13:28:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E17E5C433C8;
        Fri, 22 Sep 2023 20:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695414489;
        bh=gO4/CLli2zp7Egw4YEK7oD2RggSvd4Mmdsf+A2BWeYU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hXSCyJR5xYQD5mTEbjhFarIrlbQuojC5iFhjy4t8sqZ1YDQZNVdc9wrFnYjSGVmM6
         8yQxhyT2ZJCsn4wXwmdJ1OAQGy9f+BjjkrOiOGlC/7UlhXKFXBBRRk2FSH6bcjN5Wp
         SXxpNEsmcwgUDkUMj/vigslVrBeI2yyabxP5nWIQ4veDkF4nEZlbeMwMKXK82U4gqB
         Mm0RiGvXD9ht0Dypu/g+bpox9AAluTe8SwAufOsDVHkhUkaYIgTcrl/RB1y5ohk/Ua
         4gyQutoV4jCJZTWqpHACMizI8gJ2xXR+5d86+ixkWO46v36Eqk2UwrNh1wGQ25VkNV
         JXt3ezqn2xGZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE1A8C04DD9;
        Fri, 22 Sep 2023 20:28:09 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for v6.6-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iV2vMCF9xJ+ZyCBoMcREsrw+1EuFdV-1Byr-96L4Ws=g@mail.gmail.com>
References: <CAJZ5v0iV2vMCF9xJ+ZyCBoMcREsrw+1EuFdV-1Byr-96L4Ws=g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iV2vMCF9xJ+ZyCBoMcREsrw+1EuFdV-1Byr-96L4Ws=g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.6-rc3
X-PR-Tracked-Commit-Id: ea3105672c68a5b6d7368504067220682ee6c65c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8018e02a87031a5e8afcbd9d35133edd520076bb
Message-Id: <169541448983.12920.14243080572833654533.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Sep 2023 20:28:09 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Sep 2023 20:20:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8018e02a87031a5e8afcbd9d35133edd520076bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
