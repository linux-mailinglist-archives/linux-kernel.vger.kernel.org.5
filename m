Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353017EF5D0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjKQQFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKQQFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:05:50 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFA790;
        Fri, 17 Nov 2023 08:05:47 -0800 (PST)
Received: from localhost (unknown [75.104.68.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7133944A;
        Fri, 17 Nov 2023 16:05:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7133944A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1700237147; bh=myvsvcwBTDBu3p8ZQoWupR+ELqvD/OSm6vnUBlIuGTQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bPeyQUbLOIqLYf53j98jes4jr241IzIS0ZTgfw6KMyS+Humgt5plQRDTIiMx55J5C
         F5cUIUaU1fr4tkMFTvBiFmyNn2xCxscXi/r90CXgOnOI9ynY2wfIJn98KizriTtDjE
         fQWc9NacEz3GlldanAzg1NCZia+utXGem24s0tlMucodPELzMFOqywYAU4WVF8KCsm
         M6+xZD8FDlq8Et1l05W+GETtzhmojaiv+DiMYO41phgzSP/srr9MKKPO8VLARLVt91
         LewnLj19oy3HL4GSKlZPNvkuQ+Ivlm/WuhSiMUCocB2ADj7Sret/WdugIAa1x73b02
         NKXxh4hmUdu4Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <2023002089@link.tyut.edu.cn>
Cc:     Hu Haowen <2023002089@link.tyut.edu.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/zh_TW: replace my email address
In-Reply-To: <20231106140140.25455-1-2023002089@link.tyut.edu.cn>
References: <20231106140140.25455-1-2023002089@link.tyut.edu.cn>
Date:   Fri, 17 Nov 2023 09:05:33 -0700
Message-ID: <875y20xt4i.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Applied.  Hopefully this one will last a little longer.

jon
