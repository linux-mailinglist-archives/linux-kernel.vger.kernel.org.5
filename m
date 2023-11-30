Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E237FFB0E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376352AbjK3TTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376269AbjK3TTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:19:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF710DF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:19:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC40C433B6;
        Thu, 30 Nov 2023 19:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701371951;
        bh=ryf0ac22TL6DaGrTFgOPiOATU06MewbNS0dcr3C123M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PGdfVwwRrgWewpOo2s9FxLYSSS3AZYXHf92wPyUAn9ThkAl/79PE490k/9gR5PCUy
         Z8iKG+Yf5lgyXmFJCDn7fRirIQ533MFUnFNbN06nOetLxAlLvPh8ilZZXnLwjehEXM
         5hIfMsBvcQGlZCSe0gaBmvAgpeNqI85t1WBhOioNujgge7wS4iClZR89b+jDUeXsiW
         m5MnZSEzbJkGSGVAHkeZw/1obqn67x+rQsJFuQBlxe+2jKLyJWW0sfkJvEx+MgB8+w
         XykW7B5/Bd3z/j3fftyN62BB4vByy/OuNK8iUQrY5i8rbvrj6oJoyFcgfT4rMyX08u
         MDbhSd0viR44g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next] wifi: rt2x00: Simplify bool conversion
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231115010017.112081-1-yang.lee@linux.alibaba.com>
References: <20231115010017.112081-1-yang.lee@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     stf_xl@wp.pl, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170137194830.1963309.4994000152784974396.kvalo@kernel.org>
Date:   Thu, 30 Nov 2023 19:19:10 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Li <yang.lee@linux.alibaba.com> wrote:

> ./drivers/net/wireless/ralink/rt2x00/rt2800lib.c:1331:47-52: WARNING: conversion to bool not needed here
> ./drivers/net/wireless/ralink/rt2x00/rt2800lib.c:1332:47-52: WARNING: conversion to bool not needed here
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7531
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Patch applied to wireless-next.git, thanks.

cda398fcb488 wifi: rt2x00: Simplify bool conversion

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231115010017.112081-1-yang.lee@linux.alibaba.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

