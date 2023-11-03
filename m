Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A776F7E09AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378180AbjKCTxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377815AbjKCTxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:53:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B07D4E;
        Fri,  3 Nov 2023 12:53:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AB79C433C9;
        Fri,  3 Nov 2023 19:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699041192;
        bh=vJK+HTBVrBZqEsFha7PFvEuOMVFmc5cHgad9vM2yzE4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=szBgiB/vgKgzhZAdgIoBjRRzGe8xLnxDf2ZoYZjNB+vZaR6zY0DXYz97TNIzBGde9
         4DcBdY62Fu/FT/GGTs32NLVyEoqPMXD0oWjrDu9qvqUj4i08+ffuGLSPZ0NWC8rN00
         N3IClp0JZbseLwe8WiitSXn3SVT4XTzvT1g6sWr9va1ujX7YSFHm/Qoc9nQphLM16+
         FQ1Q8kLH76tD3LrCGIPnSP0zr9rAzmr4kiVop/W25SFm6huOAh/sLnmentqhK8xi6/
         Uprpuy3s+fknsSuUQi9JP3hHFtA7zU3xGFh9zcBI0bIOLnZ2ya5vyY8m23t69L0Uen
         DHHkt57g8o8Tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBC9AC04DD9;
        Fri,  3 Nov 2023 19:53:11 +0000 (UTC)
Subject: Re: [GIT PULL] AppArmor updates for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bf45d4d9-5a15-4ba3-9f55-b8c7e300dc54@canonical.com>
References: <bf45d4d9-5a15-4ba3-9f55-b8c7e300dc54@canonical.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <bf45d4d9-5a15-4ba3-9f55-b8c7e300dc54@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2023-11-03
X-PR-Tracked-Commit-Id: 6cede10161be00d129a24e8b84c2674785a32cf8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bdfe2d88b9ff8b0cce32ce87cd47c0e9d665f48
Message-Id: <169904119195.17286.4098682969111235538.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 19:53:11 +0000
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Nov 2023 04:13:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2023-11-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bdfe2d88b9ff8b0cce32ce87cd47c0e9d665f48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
