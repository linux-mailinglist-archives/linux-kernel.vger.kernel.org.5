Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD0675C4F2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjGUKq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjGUKqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:46:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED421FE1;
        Fri, 21 Jul 2023 03:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8D5860B9B;
        Fri, 21 Jul 2023 10:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05F4C433C7;
        Fri, 21 Jul 2023 10:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689936353;
        bh=bVNXVddqgqx1/2cVxz9Duf0iI7M4JNjftVODFvQksBw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MMe8+UN1AYvQDmbxtdcaYtRwOeD1cv/rDNshzQLq818XgH9e9Sy3CimOVXUYbevj2
         v+3ZR4LXFpeHaqtJII/ktXn26Zy8RTCGnyOoGgMQAklZA3HxoHDQfEmO05xLKzTioU
         VPwFZ1bAmhNLo4q7LsybDaqDcaR/9GTV6pKHB0WnzK/x+oZ2UEffhonGX6Ybf6bfy3
         d6s582PefhesphdgBW6O8uGwvszjjl48ShHR/fmbSf1K+j7AOfh/s8a7ua9qKWWeBP
         rDTBT1J0+VE4ZK3KbOW77vOea28fMt/hFTS9D9MaErXuzHEbJB8TigSOS0qEGMiy/x
         GuILY+9gHJhZg==
From:   Kalle Valo <kvalo@kernel.org>
To:     hanyu001@208suo.com
Cc:     stf_xl@wp.pl, helmut.schaa@googlemail.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wireless: ralink: rt2x00: Remove unnecessary spaces
References: <tencent_0AFA418AB6A31D66F3B0481E8BC58A70A108@qq.com>
        <c0f897b57f6b05d26f2c006154fa15ed@208suo.com>
Date:   Fri, 21 Jul 2023 13:45:50 +0300
In-Reply-To: <c0f897b57f6b05d26f2c006154fa15ed@208suo.com> (hanyu's message of
        "Fri, 21 Jul 2023 17:37:59 +0800")
Message-ID: <87pm4l35lt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hanyu001@208suo.com writes:

> Fix checkpatch warnings:
>
> ./drivers/net/wireless/ralink/rt2x00/rt2x00reg.h:168: ERROR: space
> prohibited after that open parenthesis '('
> ./drivers/net/wireless/ralink/rt2x00/rt2x00reg.h:168: ERROR: space
> prohibited before that close parenthesis ')'
> ./drivers/net/wireless/ralink/rt2x00/rt2x00reg.h:169: ERROR: space
> prohibited after that open parenthesis '('
> ./drivers/net/wireless/ralink/rt2x00/rt2x00reg.h:169: ERROR: space
> prohibited before that close parenthesis ')'
>
> Signed-off-by: Yu Han <hanyu001@208suo.com>

I have seen a lot of checkpatch fixes from you. We do not really like
random checkpatch fixes from new people, too much work for very little
gain. From looking at the title it's clear that you have not even read
our wireless specific instructions from our wiki (see link below).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
