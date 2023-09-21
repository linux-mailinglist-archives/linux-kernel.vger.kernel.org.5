Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F56D7A98D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjIURxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjIURxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:53:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BAA79614
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:34:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC20DC61180;
        Thu, 21 Sep 2023 16:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695312678;
        bh=Eyeuwkdvq7wj2OJOY9cYSl5PSXvzc5QooICACs47Ay0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KbFe+/1+bnHzJb3unGZKZOcamjzg2sv7W+jeOYvXiAHQYh8XuZ+s2JIx0+JK9uAVy
         Gf5jbHsfjiV5DAHW4EYfw2DIz3uESCdmM0X19+lRnBFFKiD5zsEHmFquHxS/HHHMme
         uT0JdIWpiLiEEhs6rJ6G6UMGHVq2M5huHC9YpUJqHoHzOmuz2fI2p4VnKfNsgd2WHy
         2SRkpjkmjYS3xsAKF/4r5niLd95jRcgBfbOw6uUPXJEQXtnQkxtAzL0Q9ksmD2ZOd5
         Dkzkn/R8FYi/oSsOMvmIbod+3CpfoQbzzwDT02Anuwn1c7yWcGty0O7JFa0XJMDapP
         34bDM+GJ3MI+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A18AC41671;
        Thu, 21 Sep 2023 16:11:18 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.6-2 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <875y43oo5q.fsf@mail.lhotse>
References: <875y43oo5q.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <875y43oo5q.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.6-2
X-PR-Tracked-Commit-Id: c3f4309693758b13fbb34b3741c2e2801ad28769
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7bdfc1af0a5af34b3c9620a2023d2ea00fd77b57
Message-Id: <169531267862.30941.14483156173324200251.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Sep 2023 16:11:18 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kjain@linux.ibm.com, naveen@kernel.org,
        linux-kernel@vger.kernel.org, bgray@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Sep 2023 19:45:21 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7bdfc1af0a5af34b3c9620a2023d2ea00fd77b57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
