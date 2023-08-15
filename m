Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BEE77D422
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbjHOUbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbjHOUbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:31:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EC91BF3;
        Tue, 15 Aug 2023 13:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F40A6068F;
        Tue, 15 Aug 2023 20:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8326BC433C9;
        Tue, 15 Aug 2023 20:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692131463;
        bh=IeyYqTdjDJfzsWsfMsl0xcrSJlvA0VnjxbtI8L15xFQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fo70bdUBhs6M2XQV/WH49AahxIBFp3rhVrGH363+xizyeOp8q5imd09mHIIzWtwlz
         52qWY38qc5zpduA9m2NfVkk9bsMhxAOZa2mNNQ3D4qutfPAZOjGPIU8q5B0QKFphKj
         MLL7LhCxiK+X7uFWHvRBzucCJEe9EnQsNUchAvNF1wrc5GdoNnNO812AUvla2JbV8M
         pBy/ANN3eP7iBGw2ScgRyBzUXsPyJSa37Rd/NkRnpoMc9K1YcbvHjStZNzplWXFS2I
         B2Ev5ehqZb5m6kIE2tzqaLTJRGKgkRdBo7NNfYOV0QXet5M190oTCMkZtQt9QLOQ29
         9C0ntP7yUdz+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E4ACC39562;
        Tue, 15 Aug 2023 20:31:03 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.5-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZNveCSXhx2LrtgVL@p100>
References: <ZNveCSXhx2LrtgVL@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZNveCSXhx2LrtgVL@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.5-rc7
X-PR-Tracked-Commit-Id: 7a894c87374771f3cfb1b8e5453fbe03f1fb8135
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
Message-Id: <169213146344.8674.3368541176536406771.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Aug 2023 20:31:03 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sam James <sam@gentoo.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Aug 2023 22:20:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
