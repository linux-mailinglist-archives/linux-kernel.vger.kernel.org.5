Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F9B75425D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbjGNSMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbjGNSMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:12:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54723A8D;
        Fri, 14 Jul 2023 11:12:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 155E261DF1;
        Fri, 14 Jul 2023 18:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A089C433C7;
        Fri, 14 Jul 2023 18:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689358278;
        bh=0QcofHl5/TLm05Jn/aQNIQzk2G3ZrPIlfqQ1yCTG4Is=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TqpiOp90J4zfNSWxtmtiJvrJqxfrNP8XdOmlQ/2hx5RlR8LrMr+YphJ131nfnK5Yt
         Ws3tMgdKQlKDqPUxyxeiMs3TlMyDO1jImmz+UJsUTSjSwDITzMwWmfqngCt2f+pGJ6
         sQOX5hNUbHlPkTRmwFG9YVfvyfrTmEv9k3Ol4sq2FYhyTIx50+L0fR6wroUSUH36Ms
         UMYoupIfKXHi+7a+5fPPzqzvlH32RcdxbQqpVhUQ98cki7HeeEFyQuKFniGoSKs2ln
         J7Z/k6irS2rePd0c9wBuynfJ7OEtETWuzuY4et19AVDd+GdkGNqS6YUlUq3NMO10Lk
         YtOvhCGHO+I1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66C7BE1B4D6;
        Fri, 14 Jul 2023 18:11:18 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fix for 6.5-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230714151629.69199-1-idryomov@gmail.com>
References: <20230714151629.69199-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230714151629.69199-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.5-rc2
X-PR-Tracked-Commit-Id: a282a2f10539dce2aa619e71e1817570d557fc97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddbd91617f6d0b2fd8d509c45348a56125df07b1
Message-Id: <168935827841.1072.8726094197521277973.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Jul 2023 18:11:18 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jul 2023 17:16:21 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddbd91617f6d0b2fd8d509c45348a56125df07b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
