Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B59789FDB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 17:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjH0PHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 11:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjH0PGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 11:06:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF62FE;
        Sun, 27 Aug 2023 08:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6101961A38;
        Sun, 27 Aug 2023 15:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B478EC433C8;
        Sun, 27 Aug 2023 15:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693148792;
        bh=wZARqDEoybHeA99iKsn+pqaNyfaKDn+gLfEPtsaPwC0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CWRPqdCOplrixkBFZFCmy5q4mPhchFHimcYHkcwZvNgfYswQQk0NKRwMIQ7MIxk8C
         V1WjanuD86UQzUpAio+c8xOWkHDJYe+csOnK5zvngFZq/SVuU46hs1+6r67P+oqXqk
         ZXeYAp7g3L6YoSDvHWA8VFar5W+mc8QUp0VuLisSJTcQnJEd2Ly7QCzlVY6PdMiClG
         xGU0rqBxvv5FUHwMMDjypex6bCo7yoci19WCiFv3jHZsPGP5aKUvTpVRl19I1z6ihP
         MOzMmCJ5WHZNmlheqfCiw5Vj/apF+8P9TMQfa1PrAwmsZq+pFPO449VPdrLlcBkOba
         Tts7w/9oBUTZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9776DC395DF;
        Sun, 27 Aug 2023 15:06:32 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.5-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4fa74fe53f7a1302b1c4c7c4e17590aa97f9ecc5.camel@HansenPartnership.com>
References: <4fa74fe53f7a1302b1c4c7c4e17590aa97f9ecc5.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <4fa74fe53f7a1302b1c4c7c4e17590aa97f9ecc5.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 1bd3a76880b2bce017987cf53780b372cf59528e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85eb043618bb17124050197d71c453d4a1f556e5
Message-Id: <169314879249.32068.2436191817520744905.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Aug 2023 15:06:32 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Aug 2023 08:01:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85eb043618bb17124050197d71c453d4a1f556e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
