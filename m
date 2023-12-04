Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7904804138
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjLDV65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjLDV64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:58:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0321C3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:59:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BBC2C433C8;
        Mon,  4 Dec 2023 21:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701727142;
        bh=4akh1rC0M9jmWAqlssoPVtfX3XuQwBwyV+kVe6CKKoM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MeqkDXwP2g+C3IlQVxb2MPczoqWb43F58+S64DwRa0C96/RgSFeonT54QEStxdh5T
         efgHyoYJwuk3j5QMp4YQ/6O6aZvtxLW0eFwAXV7caOtrs/mNuiACv0oTvfjl96Ul3/
         dSkdHKQpdv4lM4wADMSUyb7ocOweooA8hzFzCPQc8cutUPdwIY5yeMqbgyY2/YH3VT
         A4/J+XtkyIV3Xff7a/PRt4KuNJhtiRfHhUuuIQ8Bycq4fHYgR1UdvRAVDsha+u0+Ti
         8fTzMY/VKrH7uhfCubpcbnX7Ja0nmJeW+rsjLy8Ryu+RIFnFpFadwCtA6+aLLMvGrN
         wnGrnF89E0KgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58A6AC41677;
        Mon,  4 Dec 2023 21:59:02 +0000 (UTC)
Subject: Re: [GIT PULL] vdpa: bugfixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231204083808-mutt-send-email-mst@kernel.org>
References: <20231204083808-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231204083808-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: cefc9ba6aed48a3aa085888e3262ac2aa975714b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e535748449a51842872c46db61525f7524fc63a
Message-Id: <170172714235.21763.13703793577004715330.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Dec 2023 21:59:02 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eperezma@redhat.com, jasowang@redhat.com, lkp@intel.com,
        mst@redhat.com, shannon.nelson@amd.com, steven.sistare@oracle.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Dec 2023 08:38:08 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e535748449a51842872c46db61525f7524fc63a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
