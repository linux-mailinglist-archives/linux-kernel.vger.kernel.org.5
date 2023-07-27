Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C786E765C6E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjG0Ttn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjG0Tte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:49:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677143AA8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:49:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1B7F61F30
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 19:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46873C433CD;
        Thu, 27 Jul 2023 19:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690487363;
        bh=AoPNpRJVEcq/HqqtL7mSLnL+EK8eYnqdQcIIRevMig8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lAbOBkK0KcLLK6z2t+c+989Bp9tFmt82mB7+UpDOxhdsoLZf90x6A81y715QY6Xwv
         O34IKXhKlg3eL99g7LdwtDZZaVNy4JEsnfh5yO+qPr8LGTtjguRhfkfmcuzuu2fAgq
         8Yk01F9x7MDtP05u9kaNxz2Mpiy4r0d3YtOomVSMQqgaz8+P63k8aAE3Rd83etqjIu
         Y3Q9GJmfVHes/1My1kkaYyeFbD71rQW54FKQQG4ohaF2035m7T/RuTnypx3ie9oR2z
         uDUrC+vPROieLnGozci/Ys7NonRBhQNil8YCfL3GZgYwCAQoyP0T+07hnoyYqGBJcB
         wexb4PbdJ40+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35344C59A4C;
        Thu, 27 Jul 2023 19:49:23 +0000 (UTC)
Subject: Re: [GIT PULL]: soundwire fixes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZMJZJq02ERXGscVn@matsya>
References: <ZMJZJq02ERXGscVn@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZMJZJq02ERXGscVn@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.5-fixes
X-PR-Tracked-Commit-Id: 7891d0a5ce6f627132d3068ba925cf86f29008b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc168790de87bd70371793cfecb0fab26f85b857
Message-Id: <169048736321.11614.7918167383349256817.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Jul 2023 19:49:23 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Jul 2023 17:16:46 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc168790de87bd70371793cfecb0fab26f85b857

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
