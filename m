Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876BB7FAF82
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjK1B0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 20:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjK1B0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:26:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89BB1B8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:26:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67C51C433C8;
        Tue, 28 Nov 2023 01:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701134817;
        bh=tnxFaU5digXS9w+34jo2ANB8bDJ9CQjVLsvQcCUdALU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ye+CPAJd/eZNY+l7e3I9kIoyyWZQXGZBtY/xNGnLyKiWzN64ev0+GBq5OCxRAufxC
         axwLHYn9OMqZq+nezcLMZcXQfTW0uhkvgjCks0peXDJBeeXRWGhDEj0GaS8Pc2fG/u
         DLk60fmTLn0/SpeNJpQL3qsexHsY5xDQPAwRnhyO3Z4QT9pvJveFFRiRJ3pyMJ0ZpY
         FDeYFH84zAjLTfSWxZFouMwHwDSrlFUlv/Nv3ONe8s38q9Fo4HaZbzmy72I4JTtKyA
         6vLQuZDzK2rfeC8MKFp7N0qe83tEYmytcSyZ7YeMRebP2Wdoa7IEk63gLaCLLvGB1h
         qh0s8hkHOOLww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D1DCE00092;
        Tue, 28 Nov 2023 01:26:57 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvMv=F2JpZNW=t03TY+1H7W+6eJtNDE+f838wsS+r8BfA@mail.gmail.com>
References: <CAH2r5mvMv=F2JpZNW=t03TY+1H7W+6eJtNDE+f838wsS+r8BfA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvMv=F2JpZNW=t03TY+1H7W+6eJtNDE+f838wsS+r8BfA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.7-rc3-smb3-server-fixes
X-PR-Tracked-Commit-Id: cd80ce7e68f1624ac29cd0a6b057789d1236641e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df60cee26a2e3d937a319229e335cb3f9c1f16d2
Message-Id: <170113481731.2219.4184290566110950813.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Nov 2023 01:26:57 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Nov 2023 15:00:59 -0600:

> git://git.samba.org/ksmbd.git tags/6.7-rc3-smb3-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df60cee26a2e3d937a319229e335cb3f9c1f16d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
