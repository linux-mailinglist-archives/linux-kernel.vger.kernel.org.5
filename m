Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3777F4E89
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjKVRka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVRk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:40:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF381B1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:40:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 718D9C433CB;
        Wed, 22 Nov 2023 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700674824;
        bh=SonejxZcTHqWO1jy0K425Oliek+tjKbIPRvz6sd9uXM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hqAgrgMuur10jmC2Za5Fx/go1JZV/fNMGd1tQmvEIof7Wa46705F0bUNET5NYiaRr
         0jDNpJFe3HW8t+1100V69KftJ3u4kmecbqaXHHxBDcrmXhwhbUwYaUQP284VGpS60R
         OhPhzrWhLPqw58+HCNyQUctKRuwp034dDneQfaeVwe4XByVJ3MIsLNw3DDk+ir0xjX
         kWec10OvJT6iAN2Wkc9SBBO3hCfoDEU1Gjr3Iy/ta8hI3ldxReI3CrA66BiX8coswC
         LxBg6G+i5R9SDPYC3eaUyCNjWK7WpLlq93S6IP4Xqlh6UrFkGKrvKN09QeZDXqb/0u
         Wf8vTQy+zZ7uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54A89C595D0;
        Wed, 22 Nov 2023 17:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Add documentation to exported functions in lib
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <170067482434.16276.15670962527244628798.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Nov 2023 17:40:24 +0000
References: <GV1PR10MB6563B895FB2E3677DB984302E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <GV1PR10MB6563B895FB2E3677DB984302E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Nov 2023 22:06:36 +0530 you wrote:
> Most functions in `net/bluetooth/lib.c` lack propper
> documentation.
> 
> This patch adds documentation to all exported functions
> in `net/bluetooth/lib.c`.
> Unnecessary or redundant comments are also removed to
> ensure the file looks clean.
> 
> [...]

Here is the summary with links:
  - Bluetooth: Add documentation to exported functions in lib
    https://git.kernel.org/bluetooth/bluetooth-next/c/1b70ac811a14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


