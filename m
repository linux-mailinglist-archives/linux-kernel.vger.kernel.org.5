Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9685D7F02C0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjKRTpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjKRTpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:45:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F65B182
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 11:45:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADC42C433C8;
        Sat, 18 Nov 2023 19:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700336699;
        bh=iPOzN9M4W3f0bjODzDe2uZ3OY8xdK/MklwqPBnFlIGM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nsa2H2P6Bn5OYrrEQGh9baA1qRjxAngf7mB8zX2bUVxF3c6VhvWMP43kOzzuidCrP
         q0isz2k7e4F6CHMTyhy2aYjfNzDe0xpaB9UqJ5H/IerMYp+F9FW9l7h5jV9lW/oL3a
         EYicglCHvJZOBfrthyhtB/Kt+D0nWc4YIqbOP6/LMqsaArRhsjpg20bJ2qGaqeRfK2
         /ScCYVhcYWzW3Xey9lhv6QqYN00TijxzHWJq1Lob9XDDbixXUUD7lVHwIYC4VFaLj0
         JSuNIAxIpHwDE/ljtmrkfSIcoCbq0533NgJ1Kbe4IlhX37G0vtZs8YTKhMn4LZZLNW
         m7c1hBxvh35/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99D09EA6303;
        Sat, 18 Nov 2023 19:44:59 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msETjR-mEd6PUkE-E=OTMFKh-jD2ucuHP=uGyLScZQCLA@mail.gmail.com>
References: <CAH2r5msETjR-mEd6PUkE-E=OTMFKh-jD2ucuHP=uGyLScZQCLA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msETjR-mEd6PUkE-E=OTMFKh-jD2ucuHP=uGyLScZQCLA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc1-smb3-client-fixes
X-PR-Tracked-Commit-Id: 5eef12c4e3230f2025dc46ad8c4a3bc19978e5d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33b63f159a435c6dcaaf2cd0f312b28c76b61373
Message-Id: <170033669962.17055.15504208894696400054.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Nov 2023 19:44:59 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Nov 2023 18:37:16 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc1-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33b63f159a435c6dcaaf2cd0f312b28c76b61373

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
