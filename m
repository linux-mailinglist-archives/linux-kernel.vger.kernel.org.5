Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355FC7990B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344416AbjIHUA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344405AbjIHUAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:00:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7C11B0;
        Fri,  8 Sep 2023 13:00:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5F03C433CC;
        Fri,  8 Sep 2023 20:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694203248;
        bh=DBoEgOhaqju0RCt9JWAmNftyEfKPJg/DUj9mce1D2ro=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S0x1PKyHosKH5I7RTjVBfMX9cfl4X9cY5Wd9IwIgC5XgqKe3UogooJlWhGoaZfIxq
         8YbETV0PYyzPRlyo0oODWHfqH/nJ/38fmF0YVS0jP/qx4iLV4G3gZFt5CMwdt6qdiD
         lAQ3M0IihwpQd5/I3L93U4X3XLYBeZtozCZBwFzLVtvwVmYQh63TzVABwoID40sC73
         VtGuQZtaUIYYgPFdp6o+5nYT4LjuIbWMZIUKpuMYWQ5dqdXecvkMnQhhYt5gfH3+ba
         SdqFq/iMftP9BCWInB/knkOzKB0uLFQcyHltplM6b1JBAGuckJ2Ogh2WO8cPwabDcH
         SsywO/RNhJS1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3495E505CF;
        Fri,  8 Sep 2023 20:00:48 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock updates for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230906174638.189459-1-mic@digikod.net>
References: <20230906174638.189459-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230906174638.189459-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.6-rc1
X-PR-Tracked-Commit-Id: 2a2015495142ee0a35711b5dcf7b215c31489f27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0a45eeb5806b4daab5811432e7dbae062035dbb
Message-Id: <169420324866.9132.14620509214358454124.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Sep 2023 20:00:48 +0000
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  6 Sep 2023 19:46:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0a45eeb5806b4daab5811432e7dbae062035dbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
