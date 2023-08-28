Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0878BAF0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjH1WQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjH1WP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:15:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4BF129
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:15:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23B0E61CD4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C461C433C8;
        Mon, 28 Aug 2023 22:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693260953;
        bh=AA3KkCNqM9DM+qQyQLNTHHiFYUTPb5efJgVXOXsN/D4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hj9gytoRZhL9jkgzlGyNWIZ4hBHm5XtsW1tkBml6VJcrEb+3BgixSRuGgRKwpq3Jy
         1xbF1uO3o2vM50QvyHfM+57fIwYUekrfg1npvKh7nuiOcBvxxXolwEx0eMAt3k4XQi
         YNWWRLcM1iHhF8KPLLPNRiey2Py+NyZAlZvjAEmI7db2688FTyl8ER6Cz2Xz2ROcl6
         9TsJWIJSavXD1cQQt7UqMaHkrIDIGzxmnWoCbw9xl9HQ1yN9FImlh3dxtWgucBRs2C
         YUAZ3rqX3HBvnFYbc6hB2HfUxiaesLy7kyQZAVMtvGuor8+z5V/v6JOXWhE7gGzcwL
         DYZ0liCqzCKPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78674C3274C;
        Mon, 28 Aug 2023 22:15:53 +0000 (UTC)
Subject: Re: [GIT pull] core/entry for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <169322654636.420889.373907562030292433.tglx@xen13.tec.linutronix.de>
References: <169322654636.420889.373907562030292433.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <169322654636.420889.373907562030292433.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2023-08-28
X-PR-Tracked-Commit-Id: 1dfe3a5a7cefbe2162cecb759f3933baea22c393
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bfce7759c46132154301a742b54a64ff97b498c
Message-Id: <169326095348.8741.7474653785849929170.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 22:15:53 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 15:01:10 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2023-08-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bfce7759c46132154301a742b54a64ff97b498c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
