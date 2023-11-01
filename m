Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5307DE71F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjKAUuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbjKAUuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:50:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F9D120
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 13:50:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 754FBC433C9;
        Wed,  1 Nov 2023 20:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698871814;
        bh=RPJ/6C0oDYWolB1OcgR+Qo4OIIWKuJEI9yonjfjEeTI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iPrWcHmRt+5es69KVR6TWaA3ucEbZnmFJqaK6Pk0rqaSIzySYdGVXNO3KE9usHvdA
         ff5mkFQnfTj7i7jUynkJ8M2GPyvmHnYgNw1z0pDveBAxGGOqm6ON4oRury4VaE1teg
         zTeRcMFa78rTdTbISrsgCLQmHv4nl2eTCC3HmeYvSKeQzuDXiNENhZje3A+UUoaCkw
         Y/qSqyj4esqc1ZHzQgHHV8UNXgQ41Cnaq1jdPlznZyNDRCitFKg+LfF2N6nSRNwkVT
         R01bV7+v+tPf9ZMqH0Ttdo4uuFSzT9CE3sIrWHTjPCdnfcJoZfiXpFHID/sImbEt+0
         XmEK6WWr+2KKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 607BAC3959F;
        Wed,  1 Nov 2023 20:50:14 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231028155524.19315-1-jgross@suse.com>
References: <20231028155524.19315-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231028155524.19315-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.7-rc1-tag
X-PR-Tracked-Commit-Id: 2c269f42d0f382743ab230308b836ffe5ae9b2ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca995ce438cc641c47d4b8e4abeb1878a3d07c5f
Message-Id: <169887181438.2957.13741778337095541343.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Nov 2023 20:50:14 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Oct 2023 17:55:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.7-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca995ce438cc641c47d4b8e4abeb1878a3d07c5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
