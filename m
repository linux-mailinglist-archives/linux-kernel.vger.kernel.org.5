Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AE77908A2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 18:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjIBQN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 12:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjIBQNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 12:13:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D761FE42
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 09:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B79FB8015A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 16:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 331D3C433C9;
        Sat,  2 Sep 2023 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693671200;
        bh=C+ai9rVqR4bwx/oDyszwbQVC6eQiBdLIZ6F76IWGP9o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J9JevuwsF4x3oF9KnFZcB/gryANz/AFJ8aXP269GbzFW79gltg15v7u8p0scTNzNm
         uaankOF3523pQv4ObjxZoJ+xLTZnPcZbxqMp8FF78YJxNZ3VwBU1VgG6z6DmVijbO/
         AjssJLgLYPmp36STVvdo8D6hvgxnmNm48RVEudtjPgEMFR5aRfTr7apJCVbOc7c8s9
         mmSpgXkRUzk6OvAgsRt8h5tg9hW+UztfyFjb7DWsexcYHn9clc2G/HKrJfrmPGllwN
         4hAKdPIKpAzItdUc2nig/jEEoWxJhUh+OXn3QttZuYogP0YRohGUx0IPwob8h4PyKZ
         v5HNe/Utr0Amg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D5E5E26D49;
        Sat,  2 Sep 2023 16:13:20 +0000 (UTC)
Subject: Re: [GIT PULL] CPU hotplug fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPMK1vcdJ977n89r@gmail.com>
References: <ZPMK1vcdJ977n89r@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPMK1vcdJ977n89r@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-2023-09-02
X-PR-Tracked-Commit-Id: 2b8272ff4a70b866106ae13c36be7ecbef5d5da2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23dfeae882ff45649d2379dde9c63c9476546db5
Message-Id: <169367120011.31473.6285653672013601500.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Sep 2023 16:13:20 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
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

The pull request you sent on Sat, 2 Sep 2023 12:13:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-2023-09-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23dfeae882ff45649d2379dde9c63c9476546db5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
