Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A7880203D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 02:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjLCBYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 20:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjLCBYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 20:24:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4B011F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 17:24:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67AE4C433C7;
        Sun,  3 Dec 2023 01:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701566687;
        bh=jCGb32HC2ZtbjbIrvtAjY+kCdo+v8JJzQNSaJCvjfpc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GpfgFyDMa6aNCA40Pcdb6Kl7I/dnZAPY2wCuQ9jqlZQsZqvjWLfuOZEsFAUj5WbOr
         qj0Fip7aad6nKmZsRK5wtm8WirTzoxUy0cYpPV71/ATMT8+lcXylzabedpTGpAXDg5
         tvfzmHLqd5vqRMkjbjm2ycrjnYC/Wm7QmXB+IYP+iZS9jQNdKoR+29cN4yfqXJSda7
         uvBiuNqD36unKssIuxYW8hZakQCIUoOKhWmG9slrVPVI4TkfoxRfQ1IUdfOds3m1er
         5iMg0yXgJI78sQAuO0AljeVaN0+SweyqcGBKO11Ieh6vEXkXZMMrWiiaLIdOwCqCS0
         nxPq4zSK8AYuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54F1CDFAA94;
        Sun,  3 Dec 2023 01:24:47 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muZp5cizyqC94OT0KkwfKkUBAA0cR3J-0nMxprFpQYwfg@mail.gmail.com>
References: <CAH2r5muZp5cizyqC94OT0KkwfKkUBAA0cR3J-0nMxprFpQYwfg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muZp5cizyqC94OT0KkwfKkUBAA0cR3J-0nMxprFpQYwfg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/v6.7-rc3-smb3-client-fixes
X-PR-Tracked-Commit-Id: 0015eb6e12384ff1c589928e84deac2ad1ceb236
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 968f35f4ab1c0966ceb39af3c89f2e24afedf878
Message-Id: <170156668734.5793.14675332190606854573.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Dec 2023 01:24:47 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Dec 2023 17:59:05 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/v6.7-rc3-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/968f35f4ab1c0966ceb39af3c89f2e24afedf878

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
