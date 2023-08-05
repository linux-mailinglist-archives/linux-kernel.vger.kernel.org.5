Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66921771211
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 22:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjHEUTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 16:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjHEUTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 16:19:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0DC1BE4
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 13:19:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B139560EFC
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 20:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FDE2C433CA;
        Sat,  5 Aug 2023 20:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691266742;
        bh=gMa0iAKH5ufHWe0+cx5YT1H07eKFhauEC8MqAKT26Cc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hY5pSzfoWF0deZalX3J6Bbxs6eKOgbCiDFVsDJ07zBz6vjDU7g40AOemqORX8vfWx
         CABhXGo/UtCFcqb1r0SXsd9E22JsWQTM1mkWZerB4HntTo3FF5vNVj9rZIIOjDeLek
         St7vhSILTttOT5M6Jr99Dk9OklFNIAfXLiD6dvdXKdW1r+IV9ApQ1zaa/RelP8Euhd
         CO9tAEv/tBdpyvPVHZ3yYicoeskPoH5gbIaTbDXTl3bnj78HcYLfVgHRwXNQNHLw2H
         4VYDIW5bPUND4abo+TAMxhjzVPuNvJpYg1qP4B1Il9s4ErYYjY4fvgrCd30Ci87TuA
         MYn7Ctly9HJXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF8E0C6445B;
        Sat,  5 Aug 2023 20:19:01 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.5-5 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87sf8x4pyx.fsf@mail.lhotse>
References: <87sf8x4pyx.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sf8x4pyx.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.5-5
X-PR-Tracked-Commit-Id: 86582e6189dd8f9f52c25d46c70fe5d111da6345
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 251a94f1f66e909d75a774ac474a63bd9bc38382
Message-Id: <169126674197.17470.5676586902574906015.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Aug 2023 20:19:01 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, bgray@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        naveen@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 05 Aug 2023 22:45:58 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.5-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/251a94f1f66e909d75a774ac474a63bd9bc38382

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
