Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D0F78F5BB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 00:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347896AbjHaWnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 18:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241364AbjHaWmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:42:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327DBE0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E12E9B82436
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 22:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAB27C433CA;
        Thu, 31 Aug 2023 22:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693521763;
        bh=xNK06ZKlebzI7R1qR2QLFzbNAoN99c1xJyD8nnE68IA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ps1DhtVGBbxtIPUYUTY1AulztIseEMClmRIDUcalby1OOdp9ixaX/NTd3lGAWrQo0
         dmpTWoJXa/qVzlLTC8lPGax4q6V1+iDFubBbqI33cmqrmgaqgT0LBEvQC3dzRPvNdi
         lK36SNdpRo8FEB0bfGm4diMNeoUT2Tf+cwZEnMHgLBoKWUmN74dYzZrs7RP664lWg1
         BOLEDGJRt1aWv/bzC0Tt3RO07cdFkEPbDuGE7pSMHqmwaj9NBjOZe+NXHLESBYHyBo
         ko2ZT7FlowjJM9EXw2vh87sSeDNAes4TTy6wU0yPyMZ8BgmNoey5+RZ5OcnKoqVkjg
         UxqMn8PIixurg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 996D0C595D2;
        Thu, 31 Aug 2023 22:42:43 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230831142152.GA28483@redhat.com>
References: <20230831142152.GA28483@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230831142152.GA28483@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.6
X-PR-Tracked-Commit-Id: 7c53e847ff5e97f033fdd31f71949807633d506b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 659b3613fc635fb1813fb3006680876b24d86919
Message-Id: <169352176362.24475.17137877746163457310.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Aug 2023 22:42:43 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Aug 2023 09:21:53 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/659b3613fc635fb1813fb3006680876b24d86919

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
