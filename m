Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E77E79911E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbjIHUku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344574AbjIHUks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:40:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7948A7;
        Fri,  8 Sep 2023 13:40:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48B03C433CA;
        Fri,  8 Sep 2023 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694205643;
        bh=FMvZJR4KS5QRR4bwnzr3jgnn4rs19maSXvrZttLDA40=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gt7QDTn84QDg6J5Feg7Ok4E2FSMwF7pcTF04FPtUyuKLVk2HGEfWWdfWcjjU79SP2
         KjtEVxzNkk8txdvawp0hpyXzl623CTlljTY0knD6kPryoIQ1bDhNTfEUXYf68zmpdw
         Wn3LJkPPMTvW3QW9Kmx+Q8aXqYh2zTGgCeGpTVPChpneULX/IZK9XAa5lxPAeuE7Nq
         fkEQyCRCW5BYTMF1NWBtHFkIojhicyeeAcmj87x/bSUnwXQ7uHmRqBtoYeK9tHVUT8
         uvesyq7oFpn3aLi9x92fA+NaWxX8C4GF34UuPLAN7PIOvwPiVnRnxa6U1wVZSR0PzI
         /4sji4DCCNZQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EC57C04E27;
        Fri,  8 Sep 2023 20:40:43 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gOBBqyhwbi+FyQDgdwW3_EbtA0DgJYsH9kNxNMR=LCbQ@mail.gmail.com>
References: <CAJZ5v0gOBBqyhwbi+FyQDgdwW3_EbtA0DgJYsH9kNxNMR=LCbQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gOBBqyhwbi+FyQDgdwW3_EbtA0DgJYsH9kNxNMR=LCbQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.6-rc1-3
X-PR-Tracked-Commit-Id: 081690e941188acfad41b8dbde2112029a2aa206
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd88c59e7929ee1a155988e87df27686aa1de967
Message-Id: <169420564318.32167.7295132677376765748.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Sep 2023 20:40:43 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Sep 2023 21:22:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.6-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd88c59e7929ee1a155988e87df27686aa1de967

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
