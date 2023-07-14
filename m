Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1374754346
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbjGNTgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbjGNTgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:36:46 -0400
X-Greylist: delayed 4802 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Jul 2023 12:36:45 PDT
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5553A91;
        Fri, 14 Jul 2023 12:36:45 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BC87F5BF;
        Fri, 14 Jul 2023 19:36:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BC87F5BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689363404; bh=Y6cx46rpyh4f4kwzVAMRkODbnECw1wEIsMHA+sJSiFk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rkhiCVGUzUcMHrD9BPxy+15/3RNrw4fFAeTTf5qCi2Tk89A1pkY8CVO1+U8PRPfuL
         WYo09QA9gPZdFOFqftdtEqsT/pGIVs2RMtQpdqQl2jmh2OZzEcVRchviTCojJzU+p/
         2c/a2rIkGjOAOgtWg6it4AsuygjqthETJ6r1UG+Qi3bsnDbYZLBIS1CSidlvi0231K
         BigK+Z/XGzhE8CKF2NGFfjURfNonotxadSMwCSDbnJexDZiTKkDbYFkTs5TC8eUThk
         abwSapIoq2P9gYohspDzVCpyD5dU7VR5I1MgtYOrJLoZbSczwAt2KD0VfPtswcJs9h
         gBVb2XhGeiPxA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: deprecated.rst: Update an example
In-Reply-To: <3484e46180dd2cf05d993ff1a78b481bc2ad1f71.1687723931.git.christophe.jaillet@wanadoo.fr>
References: <3484e46180dd2cf05d993ff1a78b481bc2ad1f71.1687723931.git.christophe.jaillet@wanadoo.fr>
Date:   Fri, 14 Jul 2023 13:36:44 -0600
Message-ID: <875y6mz3n7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr> writes:

> vmalloc() has a 2-factor form. It is vmalloc_array().
> So use another function as an example.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  Documentation/process/deprecated.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

jon
