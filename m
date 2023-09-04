Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F177791D68
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjIDStk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjIDStj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:49:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE49018B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0E368CE0D97
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 18:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60696C433C8;
        Mon,  4 Sep 2023 18:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693853373;
        bh=R6TxtF1sWCU4O7iJSD6MZRAQWhfGbnPEqWrG9Y3xEJU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X0FoJlEkip4ohdfBS7Xq8loA254L8uvWtO8XwQbJ64G5bKXsgg6JLkf73jM6mPGBc
         AmjPaH/sgokOcIJBMtg85xcd129u8KlWDjx2gdu6EGS1Fs9MD6Yt1xeB51ozFycZE/
         28AkSsMg8vq6EA0CqFfjZN6paLLilMYd4Bpby1mwFusmJBL4pxwhzqAGemlcEtk/Uh
         boyGAZJ0viTO6K57prbas3c+rUKU74zMPIZmiCGtFAYUykfzd1mC+m02kThhdj75fe
         1WEyXa/eFd2zATkmq0PKsICD1h3xjGhxkaIDPg6HFbDH/SQKMhZtTPlrkI/5V537Y/
         D/LrAr7+gmSDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DCF7C04DD9;
        Mon,  4 Sep 2023 18:49:33 +0000 (UTC)
Subject: Re: [GIT PULL] tomoyo update for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c4ed154e-ac0e-b002-4de3-c09f113a79fb@I-love.SAKURA.ne.jp>
References: <c4ed154e-ac0e-b002-4de3-c09f113a79fb@I-love.SAKURA.ne.jp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c4ed154e-ac0e-b002-4de3-c09f113a79fb@I-love.SAKURA.ne.jp>
X-PR-Tracked-Remote: git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20230903
X-PR-Tracked-Commit-Id: 254a8ed6aab39c869d99da97f25035ed15756337
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c5e0e81202667f9c052edb99699818363b19129
Message-Id: <169385337331.21931.15899272977888451144.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Sep 2023 18:49:33 +0000
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 3 Sep 2023 19:25:06 +0900:

> git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20230903

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c5e0e81202667f9c052edb99699818363b19129

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
