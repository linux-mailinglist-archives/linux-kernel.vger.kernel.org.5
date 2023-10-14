Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFE97C971C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 00:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjJNWt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 18:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjJNWt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 18:49:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F0AC9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 15:49:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5578C433C8;
        Sat, 14 Oct 2023 22:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697323795;
        bh=r7KmBeLhIBHztwszX055XwePH4046HAouTs+IP0R7nQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TpaNn6NprZ2j0FjjLY9/BOGIsnDfJ7XXqqBHX9k5Ap45ehJHhUrNmRShoeoGu9DLD
         ziKkMU6W+TKMf0XW3G20G1kFUDD74PnQ4oN0ODqXfuKmSMRiRdcPVAg2RwX8ijWzR2
         JbDyyUkRnlJGdkg1TMezw4IGfCjFyw6yMkYpkjG9zQWVozzzWxTIWIZMiUMzAtcs5g
         XfAcFTbBM0zz0zvyWB72nVnM3qpeF17VcIn1FIK5O+FLEpKREck9JewAGCBOqnVl2u
         iielkfR2zQjU1yLcJDtqcUIomzGX9FSPt5sJ+KHz6OmOlMvSFi1BPJlgLcMQ1JvfCo
         i80MAVQkgDyDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C918BC73FEA;
        Sat, 14 Oct 2023 22:49:54 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSsO8/2KhWgd6kLS@gmail.com>
References: <ZSsO8/2KhWgd6kLS@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSsO8/2KhWgd6kLS@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-14
X-PR-Tracked-Commit-Id: e53899771a02f798d436655efbd9d4b46c0f9265
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23931d935363846a9b39a890d4aead208cd46681
Message-Id: <169732379481.22000.5001415593902459941.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Oct 2023 22:49:54 +0000
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Oct 2023 23:58:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23931d935363846a9b39a890d4aead208cd46681

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
