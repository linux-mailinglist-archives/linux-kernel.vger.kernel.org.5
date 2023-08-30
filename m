Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912FB78DF6C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjH3TO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343693AbjH3Qea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:34:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22BB1A1;
        Wed, 30 Aug 2023 09:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D7EA61FC8;
        Wed, 30 Aug 2023 16:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B541FC433C9;
        Wed, 30 Aug 2023 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693413266;
        bh=UKUxifRXz9K6/DkjUlY6SBIYCA3GgsTRL12eXRZSzps=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FoGMPTkhktSHe4dMJZbA5IOI0FPC8joGQrCmUZgzxzPWAtBPLj45/s5/Bs00oU3+t
         l39zGpH2AG3C3TDz5FW+MHb/BGHb7WYRh6LFtNU0Rp0z0swA9Ttjj0b0vwYcX7NeO5
         bb5pdAuo6XcanKECJLBdsDeWPB/sKGm7TJUH7jYJZ6iFdBUSykoJvOLLzrcGsvou9o
         JjS4e2etgdyfiusjidA8sZ5vYPf2kZSdKOt/W9eWEhKq7tsmNLhuv9j6D+FMhJRXFH
         FNqr821+W4w9Tb38uDMJ6gYIhC8iRKCYdvGp0WRUHoruH/PHvKNOPhqccJQNOLqalF
         TXwjNiPD2EYpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2C19E26D49;
        Wed, 30 Aug 2023 16:34:26 +0000 (UTC)
Subject: Re: [GIT PULL] Audit patches for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRBq5jsaDDs5bFy6HR88DQgbu7agjZOBvZfR17LY2GS8A@mail.gmail.com>
References: <CAHC9VhRBq5jsaDDs5bFy6HR88DQgbu7agjZOBvZfR17LY2GS8A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRBq5jsaDDs5bFy6HR88DQgbu7agjZOBvZfR17LY2GS8A@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20230829
X-PR-Tracked-Commit-Id: b1a0f64cc65ea2ebfaae9e0ce623e993a7d24257
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ea67c4f462e1eab16ced755816143cbd1ebfc7d
Message-Id: <169341326666.28213.7014295122642174845.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 16:34:26 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        audit@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Aug 2023 16:40:19 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20230829

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ea67c4f462e1eab16ced755816143cbd1ebfc7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
