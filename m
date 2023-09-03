Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF04790DBB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 21:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347309AbjICT35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 15:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347223AbjICT3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 15:29:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA7FAB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 12:29:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 203B4CE0B08
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 19:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E00CC433C9;
        Sun,  3 Sep 2023 19:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693769385;
        bh=a70ajkxiUPkGjXKq1k6l58Y4DWuh5tusQ9IbQeiEdLo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VcxyH2c0o7KEd2fNiy8n//DdtZ8RVAx8mJUbHkEvJBrg/3KnAmZ+80dCP0kzC+Ybw
         0P0TrJbkeEHt/yRosZs+5YyUe9dK+CiOzT2gHQnQKLAP9S5FHyEzq9DcIe5/KMoi3s
         q6T2zKcVIMrzZ/0Qk4SwTEza+tMWIiuNckSWIuVbiu1WUh+Ka1qzbw7BzmUFbEheRO
         2C4Il1B78P/Cm7n480chcUWwqbQvaCFzhtZpCcLwfb8Zngv4E6uma1q6GGXG2HwzIM
         BB1uU8nhZsSrdp/3CPNvSdy8JG5PtW6Jpq7BlJ8/k7dXM9YcHy69nOYkm8RgqdYu/d
         PCjavKaaBfPHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11E6DE29F3C;
        Sun,  3 Sep 2023 19:29:45 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPTF4zXvA+SRQkkA@matsya>
References: <ZPTF4zXvA+SRQkkA@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPTF4zXvA+SRQkkA@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.6-rc1
X-PR-Tracked-Commit-Id: 72f5801a4e2b7122ed8ff5672ea965a0b3458e6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 708283abf896dd4853e673cc8cba70acaf9bf4ea
Message-Id: <169376938473.24971.4071541456059244970.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Sep 2023 19:29:44 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 3 Sep 2023 23:14:03 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/708283abf896dd4853e673cc8cba70acaf9bf4ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
