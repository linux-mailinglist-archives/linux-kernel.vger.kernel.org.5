Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B665D8092B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjLGUrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLGUqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:46:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0C2171E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:46:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0838AC433C8;
        Thu,  7 Dec 2023 20:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701982017;
        bh=VHgYIj0+UrPkCxCsGm3HpQawc2WU0JPwE3Cs4W/7ltg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BtpQt7NfGgZSZu5UMLdbFwFVqrXtTNQngV11FstnPNYtTzvaqVOQoaAVA5qMZF/UY
         Qfezu68KOAV5WQYS0fnTcHrrPeewr4yVZn8WGJhzDCpEGblnfTW13Lnyq81PFGVPvY
         qhLtxABU76k/26t4Jt5Q6m/gzQzWSZVLfLepU5N0uz5TdUq9xO6Da83Ff17A7Md6lK
         f0ipMFXY2a9A5ievkn1gid8SuscurIotuzCXF+4FlSbOEEQ/TW3ELnJGTTLPTV9yVb
         s3aXTDbypCpmz0uGJbSzUmM28fjpjA5XhDFjBVEWVWBCtW9FC2BFTqKSCbUR2Ma1ja
         fNVISf2d2dcqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6975C4314C;
        Thu,  7 Dec 2023 20:46:56 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.7, take 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231206223952.GA3467946-robh@kernel.org>
References: <20231206223952.GA3467946-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231206223952.GA3467946-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.7-1
X-PR-Tracked-Commit-Id: 136c6531ba12e4a658376387e355a09c9b5223e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5c0b601453483f3068b9b06e13f83ea546c36e6
Message-Id: <170198201693.1554.11167426650810078167.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Dec 2023 20:46:56 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Dec 2023 16:39:52 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5c0b601453483f3068b9b06e13f83ea546c36e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
