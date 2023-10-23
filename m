Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60C37D2869
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjJWCQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjJWCQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:16:01 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDB8D41;
        Sun, 22 Oct 2023 19:15:59 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 35FD760A;
        Mon, 23 Oct 2023 02:15:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 35FD760A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1698027358; bh=EsvZ/Rla1pxEbVIbWjMoKGCfc+E8i3JEDgnFTdW5bDs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=f1QQBLuQ1ppsicfqtMnF3BmhNKOHxrmsStmVy21RMjiQcNX32L+fESxWDBHw7cCkt
         NDVq1Qw53ZONIx3AolkpI9IysMmO7M9Bqwe6uto5aqvjv2Q+0aH5Ypx7J3HfPIm+tb
         ZkCr5kSVyKoJS17mi4pPwYJeFquwpbAXygvTBYRNHJt1vFLwZnMLMwrYXoW49/eRGG
         HEFJZxSBcDj3Ju4hLxfDsmwZpFtTVWOSrvy2QSlcQl7pmjEAr6Fdlwnc0EAYkB4PLh
         sunBFbdAIFoXK25tAz18ShmI/sCYKQuMnI0puo4Ie2mocHOYe+42qNpBu6Y7knEHVG
         nMizskTjWlf+Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <2023002089@link.tyut.edu.cn>
Cc:     Hu Haowen <2023002089@link.tyut.edu.cn>, src.res.211@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/zh_TW: replace my email address
In-Reply-To: <20231012130008.102174-1-2023002089@link.tyut.edu.cn>
References: <20231012130008.102174-1-2023002089@link.tyut.edu.cn>
Date:   Sun, 22 Oct 2023 20:15:57 -0600
Message-ID: <87lebukrs2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <2023002089@link.tyut.edu.cn> writes:

> The Gmail address will not be used often from now on, and replace it
> with the email which is more frequently accessed by myself.
>
> Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>

Applied.

jon
