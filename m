Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5177E0A47
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378242AbjKCUXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378349AbjKCUXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:23:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306CBD53
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 13:23:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBB59C433CC;
        Fri,  3 Nov 2023 20:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699042964;
        bh=1yGEC1VTlVTYjeEdE3n21I8XP17kht2E8duzzRHaS7E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kGia1E8nDg+VZ6YlR69aAScIiKK+k2ca5Y+g5Siqi5Y/xVN9NkkRVZEOea/Psxz4b
         Vb+ypwcaa1Dc3DnBCEu7mBPuRV81jP3+mVq0kMfsBi6yzBr6w3AOGuCpYy6+Zgte8t
         qZDH8/spzOZDBdD18CS6NYkOITHeeTbhex29Ux6qaFOx/YZjm6hnJ5fTvGTn1wqbNM
         0ih8LWFIcpHKX55A8Gu79Tecy6kCg3hUqsmg6SKvr+65+UiQLpzjt8mQbQSqYceuwY
         hcNNtr0IKg48dJTKAJdhwJd7UIGSTWmlgVj1DUJUPUHCues/kl06w8rLTwVivYT+I0
         uweuDC2jVeyog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2342C04DD9;
        Fri,  3 Nov 2023 20:22:44 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.7-1 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <878r7fgzvw.fsf@mail.lhotse>
References: <878r7fgzvw.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <878r7fgzvw.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.7-1
X-PR-Tracked-Commit-Id: 303d77a6e1707498f09c9d8ee91b1dc07ca315a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 707df298cbde200b939c70be2577b20775fe3345
Message-Id: <169904296478.5035.1249699175679053125.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 20:22:44 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        srikar@linux.vnet.ibm.com, jniethe5@gmail.com,
        bigeasy@linutronix.de, song@kernel.org, bgray@linux.ibm.com,
        adityag@linux.ibm.com, tanyuan@tinylab.org, robh@kernel.org,
        mikey@neuling.org, duminjie@vivo.com, bhe@redhat.com,
        haren@linux.ibm.com, stanislav.kinsburskii@gmail.com,
        geert@linux-m68k.org, yangyingliang@huawei.com,
        nnac123@linux.ibm.com, wangyufen@huawei.com,
        m.muzzammilashraf@gmail.com, gbatra@linux.vnet.ibm.com,
        naveen@kernel.org, npiggin@gmail.com, peter@n8pjl.ca,
        hbathini@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julia.Lawall@inria.fr, visitorckw@gmail.com, linux@treblig.org,
        linuxppc-dev@lists.ozlabs.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 03 Nov 2023 16:38:27 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/707df298cbde200b939c70be2577b20775fe3345

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
