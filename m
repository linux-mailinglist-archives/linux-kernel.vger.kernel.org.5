Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17771791D53
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245159AbjIDSnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351442AbjIDSnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:43:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C54FCDE;
        Mon,  4 Sep 2023 11:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1319B80EF9;
        Mon,  4 Sep 2023 18:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 818FEC433C8;
        Mon,  4 Sep 2023 18:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693853026;
        bh=yV1vaq175i9r8coAhXYIVDjTeVoOv0w4lRwcWZei5g4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N0PrE5+b/gUD3k7ASG2ObMfqG4PMB4TcPwoJqy2uR8+NAOZpi8AqZQqqJA5Vfaw2e
         xyL45BeRbEUW2T+SQQOCJiPa8IxPyb0txzu4tS3W8cumS7ftRtUI/lAHkF58T/OPWR
         rGEjBoDQIAqTdQ9SgycaWp9FU+ogWJmo/xniHJX48NHNIhxN4Gmj+0eVVWisom5FuL
         PKA6YkFsekADk021UKIfjsV4iEPKaQ51eA0cXNwe5oLnddVW+SMvW8ksrao/iUBAsM
         YRHKp+ao8ErUEy/I2s1m6fl0FHjRNvVmW1tVep8i6GUBJme6FKYya75haOyoee46Bo
         XcOVPWsjIk9MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 614A5C04DD9;
        Mon,  4 Sep 2023 18:43:46 +0000 (UTC)
Subject: Re: [git pull] m68knommu changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fe6c0932-ac00-8a81-4eae-8759547ddd1f@linux-m68k.org>
References: <fe6c0932-ac00-8a81-4eae-8759547ddd1f@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <fe6c0932-ac00-8a81-4eae-8759547ddd1f@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.6
X-PR-Tracked-Commit-Id: cf18ecd34f71dfd2815046d4c0d7b6439bb0cbde
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a1415eebeece5a27fb40c0242b171c104ad5727
Message-Id: <169385302639.15626.4383869315476746170.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Sep 2023 18:43:46 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Sep 2023 11:08:06 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a1415eebeece5a27fb40c0242b171c104ad5727

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
