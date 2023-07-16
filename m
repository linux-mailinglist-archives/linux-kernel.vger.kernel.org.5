Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61734755759
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 23:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjGPVRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 17:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjGPVRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:17:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB04136
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 14:17:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11E4B60EBA
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 21:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 772DFC433C7;
        Sun, 16 Jul 2023 21:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689542219;
        bh=z55Sa1zqc3pO+lZ8ruS14Z1IpBtXds9A0deDJjrwELw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SdTLR6XGTiQP2b7hOMtRk3I+MqqxMsDi0eXV7BTYz3ShlpvLOVAedN93EFBhukZzZ
         3ahQRaQGUUFZszgql37KQiKqlzr7Yj//hMcVsuLXmLeMER7vSBwmKIDNm6MLz5u3Tt
         zDmhoaKymcGB3MJCYn02tute4eJGtzQJHHWyxLq2bx08ySc+TrtjCw78tPFmXyYzXY
         fz2mqqcgjQBXILYifOf+QdKrcAxOkAcK1cPpOQcp6WW67p4xSn9/BViBCMQF7bgq0i
         jYQ0MfAA8PVptshxLmjUm1LgS/KjdDlVJuoQcO09leVcSXH/wj+1EVTJfL9TmOm8N2
         tHF5FSVVbXE7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62D25C4166F;
        Sun, 16 Jul 2023 21:16:59 +0000 (UTC)
Subject: Re: [PULL 0/3] Xtensa fixes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230716203125.1658027-1-jcmvbkbc@gmail.com>
References: <20230716203125.1658027-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230716203125.1658027-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230716
X-PR-Tracked-Commit-Id: a160e9414d8a1747225206558b24d7df513b3c8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b8d6e8539498e8b2fa67fbcce3fe87834d44a7a
Message-Id: <168954221939.10251.6679547195461516367.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jul 2023 21:16:59 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Jul 2023 13:31:25 -0700:

> https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230716

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b8d6e8539498e8b2fa67fbcce3fe87834d44a7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
