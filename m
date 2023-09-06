Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7423A794182
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243241AbjIFQ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjIFQ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:29:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94BE1BCF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 09:28:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2856CC433B7;
        Wed,  6 Sep 2023 16:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694017667;
        bh=u5m+U2r+6I65Yy4/E+JYFn8hlxjcVjkI4XxXxPzU8Qg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XEEEPaVks1+22u6r2VXx0ey0Q4HeehMxU16I5h+rhq58Zcff/DW8VeVgDjgIK/i4b
         gGyGA6IRcaMLm1JZshnQWq2oAZw+q8FxQC3oolSy7teLkIhv6wFh6SuV7yJwfeJUI8
         Dnhc4adyBkoB8vjCSzQyYfMoUwv1NdJfe7Vz7rLRxrE148cVH00ACXdYdQds3uud3c
         bJYD55PyZaWHn7zJQ6zNYhJVA5it/zi1CnoAEP94hcpW0mUT22iZv+nc3qX4Ffz5Od
         15ohZNAgfm+tX2+4A9hsSmyVyUNpuYlDivDOtGJmK5hiVOQWZFUbeVVFSLWb4dLO26
         2AdvjMk4FMjaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E49BC04D3F;
        Wed,  6 Sep 2023 16:27:47 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230904141139.GC13143@google.com>
References: <20230904141139.GC13143@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230904141139.GC13143@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.6
X-PR-Tracked-Commit-Id: a4464092f2c514a7f0788906d340f0bab59fdd73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57ac7ff8cb4d30fbb91d4ac1d44aa35c22bb8d52
Message-Id: <169401766705.7147.10785518123433119004.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Sep 2023 16:27:47 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Sep 2023 15:11:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57ac7ff8cb4d30fbb91d4ac1d44aa35c22bb8d52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
