Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584DC80AD72
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjLHUAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHUAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:00:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7CE1729
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 12:00:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC5F4C433C8;
        Fri,  8 Dec 2023 20:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702065608;
        bh=rX6tGxo4i0Ik6CWIlwVrEXD15N5tEyMXB+vw8iZnK68=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eGlhotFH1s0DyvFFypEDzgxX2r2FsoYfZPIaRIVNmyX6GIs0RatBIMGSUbjTlCiCh
         H2PU0GKQFFR6eFvrLIAWLIQAoFKG5+8iR9y63QG90kqcTqZ/SpVoE4su2SBOXOdYyo
         bvvUUZHz9+pnsSe5+Dm1f/LO0haS6ofUWjwSb8u/skKu5AXTiBf5nSa5VjhhC4IG5e
         J+jb5eK7JnsyanpwsTNFyH2CNROuoo2G0a5871wPV6WlY6+uOdx7VwEM8rqw5xUVrq
         AV+geGDgBMavLEWhoVCXCh8zfe65BION9oJDvnCgs6wAdQa8EYKmh4XztKD4G4Bf8B
         hyBugIy1b/a1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9702FC04DD9;
        Fri,  8 Dec 2023 20:00:08 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.7-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0guGojjx9qzhz_hNM0f2o4uevm2p7Pq3E=oUo+L1aVW5w@mail.gmail.com>
References: <CAJZ5v0guGojjx9qzhz_hNM0f2o4uevm2p7Pq3E=oUo+L1aVW5w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0guGojjx9qzhz_hNM0f2o4uevm2p7Pq3E=oUo+L1aVW5w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.7-rc5
X-PR-Tracked-Commit-Id: bdefd9913bdd453991ef756b6f7176e8ad80d786
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 081ed90a8c662455a79843add14857b356de37a4
Message-Id: <170206560854.12654.10751453620853004735.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Dec 2023 20:00:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Dec 2023 18:56:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/081ed90a8c662455a79843add14857b356de37a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
