Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478987E9239
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjKLTSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjKLTSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:18:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2562688
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:18:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8B28C433C8;
        Sun, 12 Nov 2023 19:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699816698;
        bh=/TZ7o3tk8rEPaAr6JQ4CmQpUUUJ7GHwPC7nP40qSa18=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gZ8PEmJNrnJH0Sf9jhGqfGN8fR27zEx48t3G9Pko8dVD93RKxuZ2RlVZWxaG/+dhf
         ah5ohHYrn4WyDmHgV3cqqCk0XVHSgA7anUes9qGe8lCn2y3yZmFU1pcVMwV3HozqQ/
         Npr7DYLz0f0m7Mss6PJ7gm8R7v+CKsbkkfP71rGTucxVw/lGRjSVitS9ljCs+DfXH+
         nR2gaLa9XFpVe48Ep0K2/BupFECiMV93AidE3SQ/0cacnCDTpltkWjenDclXDZpJ0T
         A+qJjqCZ/yMLO0vnYADBYEg3c1b/ldznC0dWwTG2oPmERCGCehpk8I89vnMY2qew/O
         duTKZM/Gkhrhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4527EAB08C;
        Sun, 12 Nov 2023 19:18:18 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.7-2 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <878r73930n.fsf@mail.lhotse>
References: <878r73930n.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <878r73930n.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.7-2
X-PR-Tracked-Commit-Id: 644b6025bcaff59737270d812c70302f5a8d4a8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5dd2020f335a7a60c154375a168791a2b87f35b5
Message-Id: <169981669873.29349.4673474762245267399.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Nov 2023 19:18:18 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        nathanl@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, tzimmermann@suse.de
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Nov 2023 12:25:12 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5dd2020f335a7a60c154375a168791a2b87f35b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
