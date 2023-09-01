Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132AD7903F8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346477AbjIAXUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350896AbjIAXUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:20:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA75CE5D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:19:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F794B825C3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 23:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 434E4C433C8;
        Fri,  1 Sep 2023 23:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693610397;
        bh=o2YvXVhBm5o4/WPfsiKFvqONzLVTEwMDFcVOH8k3I/8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BZH3EfOSqkYYbPpWGrPi4vUOaYpD9hef8+ogWH4niIrkjY+6wxY3GX7lZVrxj4fH/
         oahNJ0FG2m+LpaXeSSxpnxBNIFEI3hlILaWcURxsACyxlqbvAXZJlSXi63cnGLEgU1
         4wElcKP03xBxj2fUyRxoEqH+kbgQZyAhFFlVcsvVRCALg1HcUISNfJvOWOYxcoZBh8
         UR+B71F4FIqYQi6eWhfvscgQUqPVEbsLWpWum4MYLxk5dbPvafLjj1dnitgVW0IVxg
         f80TtAi8dmDwaDDENhtSavpZ+1pqzNnrOKCQ3d2fsFucGxwW9dW+C633lBR6lndyiV
         H/LoEgf2ampgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EA4DC64457;
        Fri,  1 Sep 2023 23:19:57 +0000 (UTC)
Subject: Re: [GIT PULL] percpu changes for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZO/aXSBuVRuqFHtz@snowbird>
References: <ZO/aXSBuVRuqFHtz@snowbird>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <ZO/aXSBuVRuqFHtz@snowbird>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git tags/percpu-for-6.6
X-PR-Tracked-Commit-Id: 14ef95be6f5558fb9e43aaf06ef9a1d6e0cae6c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e987af4546ac5de50e514182c1d0ca33843fa665
Message-Id: <169361039718.4205.1224960409267407809.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Sep 2023 23:19:57 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Aug 2023 17:10:05 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git tags/percpu-for-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e987af4546ac5de50e514182c1d0ca33843fa665

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
