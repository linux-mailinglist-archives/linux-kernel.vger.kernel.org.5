Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5069580AA1A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbjLHRIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574356AbjLHRIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:08:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE1585
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:08:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E1FEC433C9;
        Fri,  8 Dec 2023 17:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702055318;
        bh=FlIdJCa/UXaESEyh+p8lw9JH9iwcDM/hgfUOTCeDY/0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HbS//9adsc1QtUqJGVnaCspRwIRj7Br3OFCKinNUbZayXnI53F4qdnNhgRymEfP9o
         sbuK3F2/M7kfkdY+drvqVWG6vRX3/i8490i8E0rbR3uX3Cqo5JB4AEAS3nIMODO1G+
         ztIbtgOZqr9wtKEhNdAn1iI6oK9JAn7KkFNEEB6bhKgh3JIDr/iQ+SH2kFtFerQVEu
         ig1VdaReK54+hXV0IMvxg+flxXGCj+8xLm2tpyxcgSOTvNV6Kkh4DcMRibadMw8TQz
         trr747cfS0RJKM70dAL0OXRTbc6410w9F92sMBCVhUikshf+FYSfNzNPEVSbvyzu3c
         QU4gxWIvp48iQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DB48C04DD9;
        Fri,  8 Dec 2023 17:08:38 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.7-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-1c062b80-96c4-4146-a689-9338ce7c524c@palmer-ri-x1c9>
References: <mhng-1c062b80-96c4-4146-a689-9338ce7c524c@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-1c062b80-96c4-4146-a689-9338ce7c524c@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.7-rc5
X-PR-Tracked-Commit-Id: ed5b7cfd7839f9280a63365c1133482b42d0981f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4df7c5fde316820286dfa6d203a1005d7fbe007d
Message-Id: <170205531818.9242.16251848338049388170.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Dec 2023 17:08:38 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 08 Dec 2023 08:09:19 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4df7c5fde316820286dfa6d203a1005d7fbe007d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
