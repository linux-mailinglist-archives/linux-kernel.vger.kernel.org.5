Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38387F857A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjKXVaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjKXVaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:30:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5A6199A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:30:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 192D1C433C9;
        Fri, 24 Nov 2023 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700861411;
        bh=nOfWBEduNJ9yZfwz3IP6wbwCTwXWK6SJImz14bYFZlc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VBex8qQBQKINbFA2HrEIIiRSuInHZoUwatM+tfW3RC9GWF5Y1c8Vi38QqvuBVfETN
         Wjk5Auf+V5fjngeF+ZyfpnoKCOxPyG/upoXm4wVef0i02pp2fuiG5hOc3N2uZRD9AM
         M+EEyD+BAP0bM7nDd6TIG5suPQHjxUtbpE9n61gWFxBuxyUBUsG7KI/1Z/Y1TCiom7
         JVtc48Y+3Kswy3LctAeY8IJgMFOneclPghGg434aK5NY+Awoo+0G5d7Zye/QnnDHgh
         7y0tHxt7JmsTrrqlnyznXG4UEslfmxO5qI4Ods/t+D33PIOjWtqcebyhStpeTiVQcv
         ZmlHDPAYQXuPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDB80EAA95E;
        Fri, 24 Nov 2023 21:30:10 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gO3nY5nSnsFUha5a9WiOAj6kZLek0sVSB49NiweFw4_w@mail.gmail.com>
References: <CAJZ5v0gO3nY5nSnsFUha5a9WiOAj6kZLek0sVSB49NiweFw4_w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gO3nY5nSnsFUha5a9WiOAj6kZLek0sVSB49NiweFw4_w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.7-rc3
X-PR-Tracked-Commit-Id: b85e2dab33ce467e8dcf1cb6c0c587132ff17f56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b345fd55a2b79d6aa92042b19be802425fc353cb
Message-Id: <170086141095.4355.1044345234368406493.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Nov 2023 21:30:10 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Nov 2023 19:23:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b345fd55a2b79d6aa92042b19be802425fc353cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
