Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD88811EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442178AbjLMTck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMTcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:32:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4EFB0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:32:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C42BDC433C8;
        Wed, 13 Dec 2023 19:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702495965;
        bh=rbmHVytUb1V53aPqe32fijD88KUqOLYNVRjVaPk4Rt4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mm8TMtBMPlZ2BL9D1AEhA8qB1BvtXeT7HTWUqOmOtvKvZ4+EQZrNR1ROCS67cAEv1
         NStmaw40UHlAzaxJQItrYRmm4r0/nksPsjKOGqARME7Gb3VSZGexXZmkSdsiDXZQQL
         cRwXGtz6AuNhRscsyX6GouQjIJfFsVaSYM0mL5DR/lAnqNOdy7A3Vs2c2ZemeOPDPY
         t8ZBCJmdlPccOKpzD6uEMootIxXIenZbx23wGqPPMFMWKUnBABMi3JDVzN+yqc23KV
         b3Ebr5dCSQifZ43LackJsy2ixrdxKR4i5c0/LICAPRq2lKA+TciKDLwyNYw9yPtN+6
         k1ow4dNnPAdvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFF70C4314C;
        Wed, 13 Dec 2023 19:32:45 +0000 (UTC)
Subject: Re: [git pull] ufs fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231213161857.GN1674809@ZenIV>
References: <20231213161857.GN1674809@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231213161857.GN1674809@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 485053bb81c81a122edd982b263277e65d7485c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
Message-Id: <170249596571.3944.15321090833418459973.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Dec 2023 19:32:45 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 13 Dec 2023 16:18:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
