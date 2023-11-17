Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E817EFB92
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346323AbjKQWrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346286AbjKQWrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:47:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C0ED4D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 14:46:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25AFCC433C7;
        Fri, 17 Nov 2023 22:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700261217;
        bh=LQEZbzImKyMI0l+a5jI9iXbjyONdjfJ5zmCC6p7z77I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nAHGEl6I5q8LirdQQJhDElIDUDCxrUcH0KA/Ja3iyPNCZzEBv6SwU0vnd8oShj9Qy
         ntlPM68tM2yOBm2cn/hYnhMxoWR572mUS4uR2aE8Nen1ud9JRtqc+kkjuYe8Pt9Tpb
         m8C+GrCmO7lTPlSOJGJU7KP50S3aRXlSJb1xDkReYYaNETBreAcgoGkRug5DzpMIjX
         cKyQBkq1NrHSW1PgyOoI+WRl4rQrWaP0orxy6RfXD2r0hvY2z1NZoWONfIFe+pPedL
         2QH4H5tEfAZG1GoFZkEGdW2pO4+Mqm9aVcoua7ud0exZjxae5H46WdZZzNUj9L7bEN
         1FdQMhQN55a3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13128EA6300;
        Fri, 17 Nov 2023 22:46:57 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231117223325.no4eqblc5zqte5xg@moria.home.lan>
References: <20231117223325.no4eqblc5zqte5xg@moria.home.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231117223325.no4eqblc5zqte5xg@moria.home.lan>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-11-17
X-PR-Tracked-Commit-Id: ba276ce5865b5a22ee96c4c5664bfefd9c1bb593
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 791c8ab095f71327899023223940dd52257a4173
Message-Id: <170026121706.14371.7933584278902729663.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Nov 2023 22:46:57 +0000
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Nov 2023 17:33:25 -0500:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-11-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/791c8ab095f71327899023223940dd52257a4173

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
