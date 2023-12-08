Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5050B80AE2D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574742AbjLHUpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574736AbjLHUpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:45:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32D9198E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 12:45:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A73AC433C7;
        Fri,  8 Dec 2023 20:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702068324;
        bh=K+OWFJryI4pDti8SH/NpnPQEFZ3Y62Vzeopq9So2HrU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J+ZCzDxqInladyzdchUQLH4SW85FzzO6YP3WQf6YfsgSDdSdS21CaPJhixFbOLhu4
         k3TxdXSSO69Qub7wKoC+Q8zRDzt67kA+3tX6Uj/ej46bYsWLHaPBMxvg1xALxy8XRd
         lAXU6xxrrlvdNx+W9qX60oyV3BjRkD1lzvxgVsYmsfsKhZ5FDM/pKz6XQw2oqPJEOY
         /EMN9WeDEn8D4tV1YrUfIZl3ud6rG7V0PFm5biHDpUPTgCa322Bj303UZjjupSzaoo
         f20tL3x9b65nJsjgc4YRbNzcERvrhE1eKBAU74tSu07cANFeV+D/OsZGXocktLRIPI
         zQjFNYH8B9IaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57FC2C04DD9;
        Fri,  8 Dec 2023 20:45:24 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <04e6cd5c53b77f7cf01df448525709f1eb7b7712.camel@HansenPartnership.com>
References: <04e6cd5c53b77f7cf01df448525709f1eb7b7712.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <04e6cd5c53b77f7cf01df448525709f1eb7b7712.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 235f2b548d7f4ac5931d834f05d3f7f5166a2e72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2e8a57ee9036c7d5443382b6c3c09b51a92ec7e
Message-Id: <170206832435.6831.10264763598499219064.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Dec 2023 20:45:24 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 08 Dec 2023 13:44:22 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2e8a57ee9036c7d5443382b6c3c09b51a92ec7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
