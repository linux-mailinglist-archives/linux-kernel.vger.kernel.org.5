Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D0D791EFB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 23:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240542AbjIDVNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 17:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240394AbjIDVNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:13:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1207CAB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 14:13:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8EE7B80E46
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 21:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F9C2C433C7;
        Mon,  4 Sep 2023 21:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693862017;
        bh=gb/A6EIvf432NmOK+C/g9NjfcH9LMWERDHrATbNrwDs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HMUCYVw10fASi6YyG5lx6nZaBySovt7YUy4dMb21iOHnkpqI3bmqg3tZ3vkoy+2AI
         ZATiYRkjO1znYTtVqq0dk0GBZznX5Ne5sm2A3xhuTIRHYfj3gQx5zbnglWqW79+3gI
         Eyo+LDURkCu9ZS7QcQqHbl6FiTARBNQBx9HaGDpoXCZlLqboFG+VLi202Vsc2TyxVM
         GmWVjKpNjLgZIxkukE2Iw4MR3/vNY3G3AhFn1sOXxNaDzGAAqiLsgRneIbL2RIVO+3
         ANztd7jSOwcAcCL+KrkSpMyTUnS1xp3H6RojZSWFp9BSxSBkKWsd9engldwqFknqgI
         rgHkJm6LvuFnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5454BC04DD9;
        Mon,  4 Sep 2023 21:13:37 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230904140818.GB13143@google.com>
References: <20230904140818.GB13143@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230904140818.GB13143@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git leds-next-6.6
X-PR-Tracked-Commit-Id: baca986e1f2c31f8e4b2a6d99d47c3bc844033e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2be6bc48df59c99d35aab16a51d4a814e9bb8c35
Message-Id: <169386201734.29740.10667011034947973077.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Sep 2023 21:13:37 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Sep 2023 15:08:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git leds-next-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2be6bc48df59c99d35aab16a51d4a814e9bb8c35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
