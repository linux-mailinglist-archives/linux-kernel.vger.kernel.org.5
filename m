Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4AB7B4273
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 19:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjI3RCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 13:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbjI3RCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:02:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC4EE1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 10:02:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57A45C433C9;
        Sat, 30 Sep 2023 17:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696093336;
        bh=5qGi2YCEHd6kQxR5v93za5a15O1F1SDz0D6DWAwbi70=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mzIetXB/LhtV2B545Q0w6LZC21WllNf7CgngTgJzEUAT/LZlVdeOrzavl7yPGKgFO
         UrU/UvQPN/p7hN5a+m8vAfIr9F+fFZDQK+akVyvqw2lTJDGQ9MKiPGdX96cmF9JQMb
         ClAc4c5DsrH/caSneOgcbHHUGtj9sMh5VFW+HAXq11hGVApIRcc/FxwHcFD1VY+Ld/
         dIvBZCigbPiKWYCdimxXf/ojT9wcXasjA7BoM+T/7cT4s65xJz3NPjvJpNw9e/T9Lw
         1+pM4azEyz80amHYSu9NSCgr32BPeURZCn7i2bH6NuRWRbuVk/p17RgWKbcK1wBwi8
         BiDoJVxs7CVtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C78CC43170;
        Sat, 30 Sep 2023 17:02:16 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gaw_5VdZBL2ZbqMkAXyFTMEAcq_nO3FQaQc7qGBZJi6w@mail.gmail.com>
References: <CAJZ5v0gaw_5VdZBL2ZbqMkAXyFTMEAcq_nO3FQaQc7qGBZJi6w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gaw_5VdZBL2ZbqMkAXyFTMEAcq_nO3FQaQc7qGBZJi6w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc4
X-PR-Tracked-Commit-Id: f4dcf06bc6e0161920b700ba3966411d716a321b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 830380e3178a103d4401689021eadddadbb93d6d
Message-Id: <169609333624.18163.11828807637726153320.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Sep 2023 17:02:16 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Sep 2023 19:11:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/830380e3178a103d4401689021eadddadbb93d6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
