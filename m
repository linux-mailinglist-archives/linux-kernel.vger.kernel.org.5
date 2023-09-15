Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B7C7A2762
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbjIOTry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbjIOTrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:47:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2A91BC7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:47:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABAA9C433C8;
        Fri, 15 Sep 2023 19:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694807235;
        bh=HTwJDE1itbMhWqMseN+yvhY3jCEDcg8wm4o1L2FiZ24=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZcJxhYryKDtdCWe9KZrqWLhR4b2gpY9IzfTWrLNl+HZB12hO8hjwKEJph30AqZ53j
         HCbRK5Q4hy5IrkCn6DdUO8IAQgwoklBhQeHC0pseSmCGVoJ+zOJ+toZVKoZB9xrkrP
         20ydClb7PHp/N9JnQ4xBsGVs8TsZjygJSgTreygHZEv0gMycs+5pQlEvM7CysyrS4j
         jb0+6TwQPGPSswtliTaFRJ0cgXNAINaK8aZO0Nl9R4tXNqJ68wFqLG1t63Id4rBy4/
         XgCecEPndDXT3ksC5CdhHQVyFOUmjTlk7RzRmLov302hcsgN/G8YlDgeCyKLAflo3Z
         +QkKPGWNg/efA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 953D3E22AF2;
        Fri, 15 Sep 2023 19:47:15 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-28c66ddb-6068-4bcc-a1be-28c830775838@palmer-ri-x1c9>
References: <mhng-28c66ddb-6068-4bcc-a1be-28c830775838@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-28c66ddb-6068-4bcc-a1be-28c830775838@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-rc2
X-PR-Tracked-Commit-Id: 8eb8fe67e2c84324398f5983c41b4f831d0705b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82210979f3dd210d019ebec2a59af0ae8be596b7
Message-Id: <169480723560.21547.9380714855077130866.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Sep 2023 19:47:15 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Sep 2023 08:12:25 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82210979f3dd210d019ebec2a59af0ae8be596b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
