Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30A77E4E91
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjKHB2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344133AbjKHB2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:28:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED81195;
        Tue,  7 Nov 2023 17:28:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C882FC433C8;
        Wed,  8 Nov 2023 01:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699406901;
        bh=sBwnTLnHQd3zXUnutnaTQru69UlPaGCMF1OUF5I+bmA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EDV+59GSX1XjYjlzYhwrAV0K0j2uWhVXY6Gz5eS/I27YkzT1MgPjTW6hoL6r/OXom
         fTtHAJAvpgD6F/v8td+jiaMJY86QmosTWcZX4uQH32+xRFnxthpGOj5JIR6XwY9H0K
         eQmBbncH0OxFvRhXrHTW6GqUnGYZNsR8gBxeVpxN1iu8h4jbdx8E06Na9/Tpa8h8h/
         e7U8shetyHINXMDX3Yb/DWjAtmyIvi00Y6cWf9/OOzsGtKKnqUjwjOqI8DRYxCjTek
         /xJaQK08+fcWGaZ8tMSh4YmskTLM0e+zqX0Tb+mrbwurmDtZxatmHFHPGhbytGboys
         mPkb3uglFESFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC744E00083;
        Wed,  8 Nov 2023 01:28:21 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gggsvrHYyOJn3g3Wd3M8vpG0sPdcWO8k7hDx4_wsq5cQ@mail.gmail.com>
References: <CAJZ5v0gggsvrHYyOJn3g3Wd3M8vpG0sPdcWO8k7hDx4_wsq5cQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gggsvrHYyOJn3g3Wd3M8vpG0sPdcWO8k7hDx4_wsq5cQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.7-rc1-2
X-PR-Tracked-Commit-Id: 36cbb924d60bf2f1f684b3739edc61cba8350160
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 305230142ae0637213bf6e04f6d9f10bbcb74af8
Message-Id: <169940690169.31371.8951799052204627765.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Nov 2023 01:28:21 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Nov 2023 20:56:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.7-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/305230142ae0637213bf6e04f6d9f10bbcb74af8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
