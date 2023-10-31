Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CAD7DC696
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbjJaGb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjJaGbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:31:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD2DB4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:31:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86731C433C7;
        Tue, 31 Oct 2023 06:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698733882;
        bh=VCIMtvdh0RRAVq8n1Hp3w02jxra4ep1zIp5/qHzsAKI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pq/ZfgGPFITp9RZnd0lR/c/IcOjBIrT5foz7r6LT5uFegQAt/4sJFfXiTIY7IYVYI
         ooJZvtcfAcGpEBzh5t5kRsA2+PyrMXtbiXcpkgL2BmtkudjWkmWXMBI4Sa82YU/a1O
         4/XsfxcyQEQ5IofxxIhW63dbx07SsyJK8SWCi6LRw/KhhPGZVn308jrdEfLKQaPQ4P
         RQ5yb6KNe/MK4DGC9eZZeWL9v+5fAtCCCLuDHKkJwi1XK9FmvYrgFn2l5hUVn5RlzO
         Ll4x/l5ApRxoQJZUGmYOIT2AesUucfyuldCfwteGPvCgkxYGK2exnp0H/aGTM+uGhb
         tfhpdNBFYLSdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72372C395E3;
        Tue, 31 Oct 2023 06:31:22 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20231030
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1996b683505b00b7d4456eb37f42a24a.paul@paul-moore.com>
References: <1996b683505b00b7d4456eb37f42a24a.paul@paul-moore.com>
X-PR-Tracked-List-Id: <audit.vger.kernel.org>
X-PR-Tracked-Message-Id: <1996b683505b00b7d4456eb37f42a24a.paul@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20231030
X-PR-Tracked-Commit-Id: 47846d51348dd62e5231a83be040981b17c955fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9886c976668cae1614b46922b56f14b467da7be
Message-Id: <169873388245.12768.16669076140366603002.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 06:31:22 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        audit@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 22:02:31 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20231030

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9886c976668cae1614b46922b56f14b467da7be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
