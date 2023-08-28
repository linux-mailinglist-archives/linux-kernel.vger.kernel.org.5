Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C735E78B95A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjH1UPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjH1UPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363CCF4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 925D66515C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6332BC433C7;
        Mon, 28 Aug 2023 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693253704;
        bh=3ng2EVepeu+LjlvxfUFzmhwRGPo9wZ3EclHN+yIA/mA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jFLCcWJmV64XAulkPzkGLVBUvDXTdRVW4r1oAR3KCCl8Act3Rvfb2XXrqWWE41RNx
         NJfbTXWIiMbObwP20tWZp5nUkeuB5AjC+c1mhRFlB6v8LnU4GsiHiAkg9Ct23/kc6Z
         gGpBOmGk6yoMoZG/2gTbns3GL0xStg8r82BxyE92E38OAwBRASveucy631UMbOtfOa
         Dk9h2jw6jYPKJdcexOpTwtZAvo+Cf1Y7xt6j+I9P9kc+mjYm/+F2XMuM+yQvYzswrE
         CyFQD8T1CwzLu1zNJt7/irVlbGrly752//6G2vtqIz6StndWnG3uKOGoN41JN8gu6P
         IOmzuf1PDAUQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FD25C3274C;
        Mon, 28 Aug 2023 20:15:04 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZOvu8n2Js03Oa7lN@debian>
References: <ZOvu8n2Js03Oa7lN@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZOvu8n2Js03Oa7lN@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.6-rc1
X-PR-Tracked-Commit-Id: 91b1ad0815fbb1095c8b9e8a2bf4201186afe304
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd2c0198a8365dcc3bb6aed22313d56088e3af55
Message-Id: <169325370432.5740.11272705112357051863.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 20:15:04 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Ferry Meng <mengferry@linux.alibaba.com>,
        Alexander Larsson <alexl@redhat.com>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 08:48:50 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd2c0198a8365dcc3bb6aed22313d56088e3af55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
