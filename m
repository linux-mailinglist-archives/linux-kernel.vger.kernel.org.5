Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973C779013B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350550AbjIARKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350519AbjIARK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:10:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4A7172D;
        Fri,  1 Sep 2023 10:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EF0FB825D0;
        Fri,  1 Sep 2023 17:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECBC8C43391;
        Fri,  1 Sep 2023 17:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693588220;
        bh=pKY11iYJa08gjVlrr3J/LdsdjMcsxSA1LCL3XZB6u90=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AVkyW9JtX6kXhSQ9ztqMC7NfoMTGWNk1MnGtjCTGaOsoy65tbQfYjwT1YZEH1N3GL
         hM9Ls4ziVcwqpPcremjtjTaV5/j1SGe3A4GXv3N/aS1NkwkMXcnbRF/FmTZ2LDbo0H
         4thT418xy/VE78XkIr24xlp5N648hyMykGaEjbABRE0gw1OhPc46LUj4sV6m2Dv68u
         RKMzqbg/if55JvwyyDe7z5H6gyDo7aXDwWulDhLq1QWi2to2vqUaLDPOn4RVhT40ml
         /kQ6fVJSYYak9L3GJoFSK7IPloZMbDfAQNBpXTGWmvR2KoSM+8EOgGLnEuiz8FoK+i
         RaTv7LAntAaQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D418BE29F32;
        Fri,  1 Sep 2023 17:10:19 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver changes for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPIBMzDL-iw24DFI@kroah.com>
References: <ZPIBMzDL-iw24DFI@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPIBMzDL-iw24DFI@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.6-rc1
X-PR-Tracked-Commit-Id: ebf05c7dc92c11b0355aaa0e94064beadaa4b05c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e1e49550dc85694abd04d86a8ee36bc98bd8b9e
Message-Id: <169358821986.1073.5757876404867685871.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Sep 2023 17:10:19 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Sep 2023 17:20:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e1e49550dc85694abd04d86a8ee36bc98bd8b9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
