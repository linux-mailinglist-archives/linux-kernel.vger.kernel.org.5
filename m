Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7351D7C9A00
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjJOQYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjJOQYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:24:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE38FA3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:24:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 999D1C433C8;
        Sun, 15 Oct 2023 16:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697387057;
        bh=+1qmMSY2BrH8cjL47D4rLAEodP5zmN7TMEJ9CJ8UEX8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zx1moN70XStUDZYNUNE/UFouNAK8lpb0rHHMvJGr7rvcCqxrmqysriCRe7088Drd3
         iTjqFNcG/Ua937R9H7DoCBjYBhrgo41qITfPI+7eNuUYtKfxk/T5hAt8XUSCN2i7ec
         JUBonBF9Ah3g2vfPLHpgPn9YH5mPC5JQZeiCko/FFHnifH8N4wCEyuHFewrO/3ubsZ
         eF0JG2Z4jBZDaueO3mATJu4FWwL/yCQKD+pklayD+hIJDQI+/mfPsjMfvmlRzDGz36
         rmsae9S8TNPySjykUrzLJoWKSOqDT4NPDlicji1zfcZiRGALTPqOFIBwQeIKANXmMd
         yu5w4OUaBzxrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8771DC395EC;
        Sun, 15 Oct 2023 16:24:17 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.6-4 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87mswkyy5w.fsf@mail.lhotse>
References: <87mswkyy5w.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87mswkyy5w.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.6-4
X-PR-Tracked-Commit-Id: f0eee815babed70a749d2496a7678be5b45b4c14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8bf101b3b1171923a011a47923a93f4b22e6cb0
Message-Id: <169738705753.6658.7721808898393616702.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Oct 2023 16:24:17 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        atrajeev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Oct 2023 21:31:39 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.6-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8bf101b3b1171923a011a47923a93f4b22e6cb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
