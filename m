Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431F575562A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 22:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjGPUsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 16:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjGPUsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 16:48:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABAEE45
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 13:48:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A91D60EC4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 20:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A2B9C433CB;
        Sun, 16 Jul 2023 20:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689540482;
        bh=EKBYH/te/v2p3+djDuaCEbtWFr0F+IZUqYCZm3zpO/4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eSUv2gt9CMmlaH4W6T6Kq8YorX3buTITd4c2WNS/EFpWvshPYyXnkRoOrKtzUsnLR
         tf1lO7U+L7H62F7sOg86jglDUlr5DWDuXTwkRw8gyusxBYfaXzEqh/SQXUGzKW+1rt
         qHxKE4Guk7xzkssCRP/4miMUTJtjiGNLpn5Xh6bDYHXQYXYLSI0FEGQxe93wCJMGhF
         UK30E3DztBTWbObNpnR9uF8uPWcDLI9stMddBLXhDljdRzeel1+6jCz4OuY1C77ODe
         IlekLZNknx1GqwaB56hFF3+qc1rkY1jcDBpEdxGbGcdQkiS8Pg9CrZPo6Z1Z/jfFMI
         oiu4FQDpmHeYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73EA8C691EF;
        Sun, 16 Jul 2023 20:48:02 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.5-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230716184943.GGZLQ7x4VZlQZb4aWq@fat_crate.local>
References: <20230716184943.GGZLQ7x4VZlQZb4aWq@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230716184943.GGZLQ7x4VZlQZb4aWq@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.5_rc2
X-PR-Tracked-Commit-Id: 27c68c216ee1f1b086e789a64486e6511e380b8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1667e630c228ca2e7577de7a404c89de3d9f7772
Message-Id: <168954048247.28685.3479345181392091356.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jul 2023 20:48:02 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Jul 2023 20:49:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.5_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1667e630c228ca2e7577de7a404c89de3d9f7772

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
