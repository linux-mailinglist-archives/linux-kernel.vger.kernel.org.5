Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1DA7AB08A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjIVLYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjIVLYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:24:47 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C75CA;
        Fri, 22 Sep 2023 04:24:42 -0700 (PDT)
Received: from localhost (unknown [195.89.33.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7E8F9735;
        Fri, 22 Sep 2023 11:24:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7E8F9735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1695381881; bh=hcCB/lmrbPTtKJaqCR5NdN2vcB6LwDLfbG8Q8BQm73o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MxWuvJxaR6CN8VcsRnnRtgelNjriuPG0UnfQbdoeEg+KMZjNnSOxY67433sObqTZp
         PU9Z3GX0NREnN2sIqw5M2GFG+uzypRdQlfNuAbrsxiPb0Qk0kbbpiYd+z0tztU687i
         92bYBr4Za3ti49A4v6hFhOrwA/SzJJLe8KNXHE0afQI1x4JyOJ4a5E27wQdju7PXK9
         kC/44PjcpSvDeHOOrf3q02M8oifGNLBuvMKg9YER8y09Y5JhsE0OtnQArYWOATCA0l
         FlOS4VPoahE3SDi20UlOFflYc5BPRkweFRHYwS03pZVvSB3z+kW49xfIQ5p3x3DOQ2
         hxm+UUgRCpwBA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [PATCH] docs: move leds under section Human interfaces
In-Reply-To: <20230913105519.675183-1-costa.shul@redhat.com>
References: <20230913105519.675183-1-costa.shul@redhat.com>
Date:   Fri, 22 Sep 2023 05:24:39 -0600
Message-ID: <87h6nm78nc.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> from uncategorized list
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/subsystem-apis.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

jon
