Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2D380AA13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574201AbjLHRIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbjLHRIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:08:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CF6193
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:08:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F28E3C433C7;
        Fri,  8 Dec 2023 17:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702055318;
        bh=113Sq3inUAa/B0pP4nz/cKmVnH4VmCK5nq9lG/EW980=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tuuJ6jTTg9JM3KEbqGN2mlvOSKz3gFls559iMD/cYCu9o0H/eamHqqzP+EYhm4p/A
         F7pWDJXufLG5U8S585shcWXgejmsH/w9pyzNbmR7LedeLX0yOOHixBlCgns4ICS1gg
         zqA95wOqTCOZUq1YPJo39xK/2ojqS6xsIPS/u9/wIOiRp9HAPdeY9wVeeORruPDjt3
         XD4YoTQLZKBMU+yV08Nxi51mzPFqF6LRiAO512g6gWds4PZsMpL96lH4PCi6kX2eWL
         ui1TVDDI6+7vyV2giFVA/Er47saBxZ7F4X/rmLEx7XZ+ny+uIUXxwyfPEVyK6JmvlI
         xDT80Af4xga/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2429C04DD9;
        Fri,  8 Dec 2023 17:08:37 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for v6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231207133717.0b6d55d7@gandalf.local.home>
References: <20231207133717.0b6d55d7@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231207133717.0b6d55d7@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc4
X-PR-Tracked-Commit-Id: f458a1453424e03462b5bb539673c9a3cddda480
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17894c2a7aa60a6da7495cc8500a53523e64c4b1
Message-Id: <170205531792.9242.9331232809470746846.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Dec 2023 17:08:37 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Petr Pavlu <petr.pavlu@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Dec 2023 13:37:17 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17894c2a7aa60a6da7495cc8500a53523e64c4b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
