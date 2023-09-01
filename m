Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A772E7903B4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349958AbjIAWlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350972AbjIAWlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:41:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9A1E40
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 15:41:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5BBF7CE2503
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 22:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAFDBC433CA;
        Fri,  1 Sep 2023 22:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693608060;
        bh=T78en1Ki9GOPWf6/ajllP7yHV0/iUqo4V3qkfeXjxgo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s2QfWcywdfSNcbK8TYyVNiXDD2XqdzMVbgVFri5wf6JGtzWEWGpxE2Hkm8RQ3p8QJ
         KyxfBebCBLoWcqfB5Kdut5H/0hqjrhQsQwhAujCExNn8+lWDEGFZILeU+/YSeB48zT
         9WrwOiZzWSLiUmxuDKK/9GCD258UVuVgDsmHkI2fk/z125W5GY68Cl8S/AZuZo3EbX
         MtS7Mo6cAT9MDU//hg10H5tFADBqgkKiIOIf2MHFqpYmospKfXysje0nXb2131KXHH
         rP1piRMzT9SapDg4lfpgvbmY72WsuOebJMgq8XKQOjtrSJhr/lazVkKukUHves4iZ6
         +/RYdmF+ULZLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA9B0E29F33;
        Fri,  1 Sep 2023 22:40:59 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <rbbohtzjjqpbh7w6nmkqqoi2ca5jfl62sxtjyv5go5dock32yr@vslcd4yadpdg>
References: <rbbohtzjjqpbh7w6nmkqqoi2ca5jfl62sxtjyv5go5dock32yr@vslcd4yadpdg>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <rbbohtzjjqpbh7w6nmkqqoi2ca5jfl62sxtjyv5go5dock32yr@vslcd4yadpdg>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023083101
X-PR-Tracked-Commit-Id: 9fe5167a6c2163a3814c24221f0f52363bae06c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29aa98d0fe013e2ab62aae4266231b7fb05d47a2
Message-Id: <169360805982.11463.10523916460824037884.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Sep 2023 22:40:59 +0000
To:     Benjamin Tissoires <bentiss@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Aug 2023 16:37:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023083101

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29aa98d0fe013e2ab62aae4266231b7fb05d47a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
