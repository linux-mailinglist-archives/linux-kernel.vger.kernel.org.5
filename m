Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10822799B84
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 23:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344863AbjIIVyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 17:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241989AbjIIVyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 17:54:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9D0195
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 14:54:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 923BAC433C7;
        Sat,  9 Sep 2023 21:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694296480;
        bh=M4RZP0fGF69UFqpB/5dNAWQW+UFqhTOf0JxckaFLP2g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hjx9RSl+doWPs7O7nGsP0kmBBHGVNkMED+OSekQalLUCX1Dx41RQaFqfzH0eWpJUL
         4XiLdjx+VhHAMIp4L7mO+GbMe/pkeyZnoXOA8HMEUQfJIlt7HAGpcJKncEIyuurMoz
         15+Y9ol3CMq70pDiMnPXtMKNHYHjqKT7nEZPoghmO9xPOrHBHmvSvnrELQfblan7Db
         lMnJRWYNDx5i+N51HAuWJm98byTXSJtcuoeWgHFFCsSynH4oqU1jlaISpy4lj3cMQg
         069Ozl33TYG9lu/vkO/7Oj1OCeDFhcelEROWXG+TfPNDe+R+fIQS/aGwf6W+uaal6l
         VbMT8thpnP0pA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F9C8E22AFC;
        Sat,  9 Sep 2023 21:54:40 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.6 Merge Window, Part 2 (try 2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-2cae48f5-f42a-4432-b0e2-bc1ee3e01ce5@palmer-ri-x1c9>
References: <mhng-2cae48f5-f42a-4432-b0e2-bc1ee3e01ce5@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-2cae48f5-f42a-4432-b0e2-bc1ee3e01ce5@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-mw2-2
X-PR-Tracked-Commit-Id: c6a906cce61a8015b622707f9c12003f90673399
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b37a0a2d46f0c5fa5eee170ddeeb83342faa117
Message-Id: <169429648051.7760.11942823102814181411.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Sep 2023 21:54:40 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 09 Sep 2023 07:25:43 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-mw2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b37a0a2d46f0c5fa5eee170ddeeb83342faa117

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
