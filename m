Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403937D20A7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 03:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjJVBwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 21:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjJVBwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 21:52:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CA5119
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 18:52:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6219CC433CA;
        Sun, 22 Oct 2023 01:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697939525;
        bh=Ow5j75APyrHCFc4i5S6/sPasuIIK/e2/tkSldYoVSjA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MmXAzx1shqHWx/JMc5S2ZdSFxxn+xrglysUOErxLu6Ywbg+TYkX3cje0wM3RoKbqb
         E22gOrBdbrg7Lt9PedeKAIpD8yBxChYy0EfC5xfKo7gEVIuAsbUi2CtQDn9EEAUAfM
         cLAi0GiJABT8xix0a0RJvPDGmo9mOKWA8wbE2JbmPOQ6iMxZtMft1lcvTDo+aPrUZe
         /R8O3iyzNDQZqcHVlsBHQifb5pYqRg/jClTvgYIEZ1z4uUK4PzSRxXEMMQJr2CxOMK
         UzFTCt/vZSesSDd0Fek5V5UoMr0JRmwCKSVcn6jLsD5z8xakpZsE+ZtJrLx8Da16DB
         lqM05ZT+xRSyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5090FC04DD9;
        Sun, 22 Oct 2023 01:52:05 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.6-5 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87y1fv4er5.fsf@mail.lhotse>
References: <87y1fv4er5.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87y1fv4er5.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.6-5
X-PR-Tracked-Commit-Id: f9bc9bbe8afdf83412728f0b464979a72a3b9ec2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1acfd2bd3f0d9dc34ea1871a445c554220945d9f
Message-Id: <169793952532.9872.1513283742626010407.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Oct 2023 01:52:05 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Oct 2023 12:39:26 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.6-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1acfd2bd3f0d9dc34ea1871a445c554220945d9f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
