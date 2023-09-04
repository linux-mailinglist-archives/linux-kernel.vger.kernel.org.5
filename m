Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9253791EF7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 23:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbjIDVNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 17:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjIDVNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:13:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC62FAB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 14:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6562FB80D71
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 21:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09F6EC433C8;
        Mon,  4 Sep 2023 21:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693862015;
        bh=0QhkyxDJz9hefQzkd7ZcX5u+JbvRr5w0wLDCwOCtQAw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ecj4m0cw3ZeE3tMUAqbB5ACu5jrY16UhvkcN22mHbs+zXteVM6AcrIsv53C0JviKM
         yDKIzVwvUOqEHl2WSObOYCpwJ1hiottPw7D1hXZxz1A3fboR8n9oTEDinpcQ5oaVop
         KeGc09RAwutXsLU5/MM8DSEVLv4Y6fHic+N6T+PCPhjcvxtkEnVCaXSP/nSrSrDguM
         mHBOeAsbN0TzEartoVDWWlH0Z4ReQNfQVzjCF+royYMPY0IXf5s+IlslHrZsAM5yYk
         q9tMwD/fRAhTgVNxxL+qaL2/BpuVRUKk9b9MdZqN6/kOZdbaGGZVsQGr+d6jBi1Gwa
         L+YYWKbz7mldg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2F9DC0C3FD;
        Mon,  4 Sep 2023 21:13:34 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <169381359147.1522629.3831235635630258619.tglx@xen13>
References: <169381359147.1522629.3831235635630258619.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <169381359147.1522629.3831235635630258619.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023-09-04-v2
X-PR-Tracked-Commit-Id: 5146e1f589ccb04cf987b45296aa27f90a2407dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4accdb9895349026d85e526036ff28c07921d7cf
Message-Id: <169386201476.29740.4371275643738099146.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Sep 2023 21:13:34 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  4 Sep 2023 09:46:50 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023-09-04-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4accdb9895349026d85e526036ff28c07921d7cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
