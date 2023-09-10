Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144D6799F48
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbjIJSIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 14:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjIJSIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 14:08:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87A9188;
        Sun, 10 Sep 2023 11:08:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81B86C433C8;
        Sun, 10 Sep 2023 18:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694369326;
        bh=J0aaIBeWFyBrzvKntuSVVFSamTzOmO++30dugFF8XoI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=of7eB3fAgWSOZLU8dnQSHEiNfMK/S+wWxXj57amNjbPXGF5f/oN7R7SlZpX/yrUC7
         CWx8GdXFf4xAL3zVlBf/l8mHAjwi2ZaUyWmiooMvc/A9sMojGUUSLofNB76UnjbGNY
         AWaz7FH7pERw/kUCFBTG2yr5zCtkIS+JYOeC27vnL/FKse1sqJmZPCUIyUg1HkHxbQ
         KmRbu8Lw5PmamPSfrUqm5qATargBYWnhdF8QWRoXZWE6uavq85nPsysJXLGMNgwHS9
         jy5vuND4v6s9Ji/ahqjNFqK1vmjv2sM0r/Xlks0HPnr9XBxc9wyRQuxmRJz4UFf6i0
         v2EA+SgGYbBtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CA64C04E27;
        Sun, 10 Sep 2023 18:08:46 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZP3s4yKcWtgCn6zb@gmail.com>
References: <ZP3s4yKcWtgCn6zb@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZP3s4yKcWtgCn6zb@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-09-10
X-PR-Tracked-Commit-Id: 6f7f984fa85b305799076a1bcec941b9377587de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e79dbf03d87b2d9978d76ddc1c06424b07b215ad
Message-Id: <169436932643.25650.16162340598525455096.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Sep 2023 18:08:46 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
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

The pull request you sent on Sun, 10 Sep 2023 18:20:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-09-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e79dbf03d87b2d9978d76ddc1c06424b07b215ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
