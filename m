Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC17F7E95AA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 04:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjKMDmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 22:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjKMDmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 22:42:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7398172B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 19:42:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18A03C433C9;
        Mon, 13 Nov 2023 03:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699846957;
        bh=kMNFG6GxX2xUFljVxR1VqetFQ36ylMY7i02oFlEPvY4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZwphHPpdRBRcxW8WwL+61aqtReG0vbOZhou5QDxFxJhMW+N5UxG/L7RRTq+4HaK7v
         rWfHnrGt7vbhMIPJ90sk+0ejaTDNQ++aLauDZG3becE9nm0cYY8HrysUIgVFmjGcdw
         sW9e3ewFdoPQRYNcL8UCNnIezxKc9H+xp/s8CYWDDcUH79rm+ZtfFbLvChTp0P0UD7
         AGDtHcV8B0CZ9QpWRdZ3fuO+QR4OFWTVCtHc6IazcvJ4JKK/gwDnDpjZru16mKn7Av
         HgMUtzjY2ouQ6r3c5C/Avdy3D4oPCgFyApIbN4VPPYi9vgVr93NKVRZgJsfqK4/z2Q
         1lNwQSqbrhVcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F254DE32713;
        Mon, 13 Nov 2023 03:42:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [1/2] media: platform: cros-ec: Rename conns array for the match
 table
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169984695698.27851.12936649022716476866.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Nov 2023 03:42:36 +0000
References: <KL1PR01MB38096300BE18095E51FB7A5BAECAA@KL1PR01MB3809.apcprd01.prod.exchangelabs.com>
In-Reply-To: <KL1PR01MB38096300BE18095E51FB7A5BAECAA@KL1PR01MB3809.apcprd01.prod.exchangelabs.com>
To:     Ken Lin <ken_lin5@hotmail.com>
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        bleung@chromium.org, hverkuil-cisco@xs4all.nl, mchehab@kernel.org,
        rekanorman@chromium.org, sadolfsson@chromium.org,
        u.kleine-koenig@pengutronix.de, chrome-platform@lists.linux.dev,
        linux-media@vger.kernel.org,
        rasheed.hsueh@lcfc.corp-partner.google.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Hans Verkuil <hverkuil-cisco@xs4all.nl>:

On Thu,  5 Oct 2023 09:38:40 +0800 you wrote:
> Rename conns array to port_**_conns, ** is the ports which support cec.
> ex: dibbi_conns support Port D and B will be renamed to port_db_conns.
> Make it much cleaner and readable.
> 
> Signed-off-by: Ken Lin <ken_lin5@hotmail.com>
> ---
> 
> [...]

Here is the summary with links:
  - [1/2] media: platform: cros-ec: Rename conns array for the match table
    https://git.kernel.org/chrome-platform/c/678e8d804149
  - [2/2] media: platform: cros-ec: Add Taranza to the match table
    https://git.kernel.org/chrome-platform/c/cd5c11d5aacd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


